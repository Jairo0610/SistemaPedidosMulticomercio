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
     * Crear un pedido (entrega a domicilio o pago con tarjeta)
     * toma precios y dirección, lo deja en estado_pago=pendiente y crea el
     * PaymentIntent de Stripe. La app paga con el client_secret y luego confirma.
     *
     * se crea con POST /api/pedidos
     */
    public function store(StorePedidoRequest $request)
    {
        $datos     = $request->validated();
        $empresa   = Empresa::findOrFail($datos['empresa_id']);
        $direccion = Direccion::findOrFail($datos['direccion_id']);

        // La empresa debe tener al menos una sucursal que atienda el pedido.
        $sucursal = $empresa->sucursales()->first();
        if (! $sucursal) {
            return response()->json(['message' => 'La empresa no tiene sucursales disponibles.'], 422);
        }

        // Cargar de golpe los productos pedidos.
        $ids       = collect($datos['items'])->pluck('producto_id');
        $productos = Producto::whereIn('id', $ids)->get()->keyBy('id');

        // Todos los productos deben ser de la empresa elegida (carrito = una empresa).
        foreach ($productos as $producto) {
            if ((int) $producto->empresa_id !== (int) $empresa->id) {
                return response()->json([
                    'message' => 'Todos los productos deben pertenecer a la misma empresa.',
                ], 422);
            }
        }

        $pedido = DB::transaction(function () use ($datos, $request, $empresa, $sucursal, $direccion, $productos) {
            $total   = 0;
            $lineas  = [];

            foreach ($datos['items'] as $item) {
                $producto = $productos[$item['producto_id']];
                // Precio congelado = precio actual con promoción vigente aplicada.
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

            $pedido = Pedido::create([
                'numero'            => $this->generarNumero(),
                'user_id'           => $request->user()->id,
                'empresa_id'        => $empresa->id,
                'sucursal_id'       => $sucursal->id,
                'modalidad_entrega' => 'domicilio',
                'metodo_pago'       => 'tarjeta',
                'estado_entrega'    => 'nuevo',
                'estado_pago'       => 'pendiente',
                'total'             => $total,
                // toma la dirección,  se copian, no apunta a la libreta
                'direccion_entrega' => $direccion->direccion,
                'latitud_entrega'   => $direccion->latitud,
                'longitud_entrega'  => $direccion->longitud,
            ]);

            $pedido->detalles()->createMany($lineas);
            $pedido->historialEstados()->create([
                'estado'      => 'nuevo',
                'observacion' => 'Pedido creado desde la app.',
            ]);

            return $pedido;
        });

        // crear el PaymentIntent en Stripe por el total del pedido
        $stripe = new StripeClient(config('services.stripe.secret'));
        $intent = $stripe->paymentIntents->create([
            'amount'   => (int) round($pedido->total * 100), // Stripe trabaja en centavos
            'currency' => 'usd',
            'metadata' => ['pedido_id' => $pedido->id],
        ]);

        // guardamos el id del PaymentIntent para verificar el pago al confirmar.
        $pedido->update(['stripe_payment_id' => $intent->id]);

        return response()->json([
            'pedido_id'     => $pedido->id,
            'numero'        => $pedido->numero,
            'total'         => $pedido->total,
            'client_secret' => $intent->client_secret,
        ], 201);
    }

    /**
     * confirmar el pago tras cobrar en la app, el backend consulta el PaymentIntent
     * en Stripe (no confía en el cliente) y, si está pagado, marca el pedido
     *
     * se confirma con POST /api/pedidos/{pedido}/confirmar-pago
     */
    public function confirmarPago(Request $request, Pedido $pedido)
    {
        // Solo el dueño del pedido puede confirmarlo.
        abort_unless($pedido->user_id === $request->user()->id, 403);

        if (! $pedido->stripe_payment_id) {
            return response()->json(['message' => 'El pedido no tiene un pago asociado.'], 422);
        }

        $stripe = new StripeClient(config('services.stripe.secret'));
        $intent = $stripe->paymentIntents->retrieve($pedido->stripe_payment_id);

        if ($intent->status !== 'succeeded') {
            return response()->json([
                'message' => 'El pago aún no se ha completado.',
                'estado'  => $intent->status,
            ], 422);
        }

        if ($pedido->estado_pago !== 'pagado') {
            $pedido->cambiarEstado('estado_pago', 'pagado', 'Pago confirmado con tarjeta (Stripe).');
        }

        return response()->json($pedido->load(['detalles.producto:id,nombre', 'empresa:id,nombre']));
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