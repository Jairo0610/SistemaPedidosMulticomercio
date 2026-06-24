<?php

namespace App\Http\Controllers;

use App\Http\Requests\StorePedidoRequest;
use App\Models\Direccion;
use App\Models\Empresa;
use App\Models\Pedido;
use App\Models\Producto;
use Illuminate\Http\Request;
use Illuminate\Support\Carbon;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Str;
use Stripe\StripeClient;

class PedidoController extends Controller
{
    /**
     * historial de pedidos del cliente autenticado
     * se obtiene con GET /api/pedidos
     */
    public function index(Request $request)
    {
        return $request->user()
            ->pedidos()
            ->with(['detalles.producto:id,nombre', 'empresa:id,nombre'])
            ->orderByDesc('id')
            ->get();
    }

    /**
     * crea el PaymentIntent de Stripe SIN crear el pedido todavía
     * la app muestra el PaymentSheet con este client_secret
     *
     * se llama con POST /api/pedidos/intent
     */
    public function intent(StorePedidoRequest $request)
    {
        $calc = $this->calcular($request->validated());
        if ($calc instanceof \Illuminate\Http\JsonResponse) {
            return $calc;
        }

        $stripe = new StripeClient(config('services.stripe.secret'));
        $intent = $stripe->paymentIntents->create([
            'amount'   => (int) round($calc['total'] * 100), // Stripe trabaja en centavos
            'currency' => 'usd',
            'metadata' => ['user_id' => $request->user()->id],
        ]);

        return response()->json([
            'client_secret'     => $intent->client_secret,
            'payment_intent_id' => $intent->id,
            'total'             => $calc['total'],
        ]);
    }

    /**
     * crea el pedido SOLO si Stripe ya aprobó el cobro (status succeeded)
     * si el pago no está completo, no se crea nada
     *
     * se crea con POST /api/pedidos
     */
    public function store(StorePedidoRequest $request)
    {
        $datos = $request->validated();

        if (empty($datos['payment_intent_id'])) {
            return response()->json(['message' => 'Falta el identificador del pago.'], 422);
        }

        // verificar el pago en Stripe (no se confía en el cliente)
        $stripe = new StripeClient(config('services.stripe.secret'));
        $intent = $stripe->paymentIntents->retrieve($datos['payment_intent_id']);

        if ($intent->status !== 'succeeded') {
            return response()->json(['message' => 'El pago no se ha completado.'], 422);
        }

        $calc = $this->calcular($datos);
        if ($calc instanceof \Illuminate\Http\JsonResponse) {
            return $calc;
        }

        // el monto cobrado debe coincidir con el total recalculado
        if ((int) $intent->amount !== (int) round($calc['total'] * 100)) {
            return response()->json(['message' => 'El monto pagado no coincide con el total.'], 422);
        }

        $pedido = DB::transaction(function () use ($datos, $request, $calc, $intent) {
            $pedido = Pedido::create([
                'numero'            => $this->generarNumero(),
                'user_id'           => $request->user()->id,
                'empresa_id'        => $calc['empresa']->id,
                'sucursal_id'       => $calc['sucursal']->id,
                'modalidad_entrega' => 'domicilio',
                'metodo_pago'       => 'tarjeta',
                'estado_entrega'    => 'nuevo',
                'estado_pago'       => 'pagado',
                'total'             => $calc['total'],
                // la dirección se copia (congela), no apunta a la libreta
                'direccion_entrega' => $calc['direccion']->direccion,
                'latitud_entrega'   => $calc['direccion']->latitud,
                'longitud_entrega'  => $calc['direccion']->longitud,
                'stripe_payment_id' => $intent->id,
            ]);

            $pedido->detalles()->createMany($calc['lineas']);
            $pedido->historialEstados()->create([
                'estado'      => 'nuevo',
                'observacion' => 'Pedido creado y pagado con tarjeta (Stripe).',
            ]);

            return $pedido;
        });

        return response()->json(
            $pedido->load(['detalles.producto:id,nombre', 'empresa:id,nombre']),
            201
        );
    }

    /**
     * valida empresa, sucursal y productos, y calcula el total con precios congelados
     * (promoción vigente aplicada). Devuelve los datos o una respuesta de error 422.
     */
    private function calcular(array $datos)
    {
        $empresa   = Empresa::findOrFail($datos['empresa_id']);
        $direccion = Direccion::findOrFail($datos['direccion_id']);

        // La empresa debe tener al menos una sucursal que atienda el pedido.
        $sucursal = $empresa->sucursales()->first();
        if (! $sucursal) {
            return response()->json(['message' => 'La empresa no tiene sucursales disponibles.'], 422);
        }

        $ids       = collect($datos['items'])->pluck('producto_id');
        $productos = Producto::whereIn('id', $ids)->get()->keyBy('id');

        $total  = 0;
        $lineas = [];
        foreach ($datos['items'] as $item) {
            $producto = $productos[$item['producto_id']];

            // todos los productos deben ser de la empresa elegida (carrito = una empresa)
            if ((int) $producto->empresa_id !== (int) $empresa->id) {
                return response()->json([
                    'message' => 'Todos los productos deben pertenecer a la misma empresa.',
                ], 422);
            }

            // precio congelado = precio actual con promoción vigente aplicada
            $precio   = $this->precioVigente($producto);
            $subtotal = $precio * $item['cantidad'];
            $total   += $subtotal;

            $lineas[] = [
                'producto_id'     => $producto->id,
                'cantidad'        => $item['cantidad'],
                'precio_unitario' => $precio,
                'subtotal'        => $subtotal,
            ];
        }

        return [
            'empresa'   => $empresa,
            'sucursal'  => $sucursal,
            'direccion' => $direccion,
            'total'     => $total,
            'lineas'    => $lineas,
        ];
    }

    /**
     * precio del producto con la promoción vigente aplicada (si la hay)
     * promoción vigente = activa y con la fecha de hoy dentro de su rango
     */
    private function precioVigente(Producto $producto): float
    {
        $hoy = Carbon::today();

        $promo = $producto->promociones()
            ->where('activa', true)
            ->whereDate('fecha_inicio', '<=', $hoy)
            ->whereDate('fecha_fin', '>=', $hoy)
            ->first();

        if (! $promo) {
            return (float) $producto->precio;
        }

        $precio = $promo->tipo === 'porcentaje'
            ? $producto->precio * (1 - $promo->valor / 100)
            : $producto->precio - $promo->valor;

        return (float) max(0, round($precio, 2));
    }

    /**
     * Genera un número de pedido único tipo PED-XXXXXXXX.
     */
    private function generarNumero(): string
    {
        do {
            $numero = 'PED-' . strtoupper(Str::random(8));
        } while (Pedido::where('numero', $numero)->exists());

        return $numero;
    }
}