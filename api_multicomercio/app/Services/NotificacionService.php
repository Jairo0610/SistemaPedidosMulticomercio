<?php

namespace App\Services;

use App\Models\Notificacion;
use App\Models\Pedido;
use Illuminate\Support\Facades\Log;
use Kreait\Firebase\Messaging\CloudMessage;
use Kreait\Firebase\Messaging\Notification as FcmNotification;

class NotificacionService
{
    // guarda la notificación en la BD y la envía por push al cliente del pedido
    public function pedidoEstadoCambiado(Pedido $pedido, string $campo, string $valor): void
    {
        [$titulo, $mensaje] = $this->texto($pedido, $campo, $valor);

        Notificacion::create([
            'user_id'   => $pedido->user_id,
            'pedido_id' => $pedido->id,
            'titulo'    => $titulo,
            'mensaje'   => $mensaje,
            'tipo'      => $campo,
        ]);

        $this->enviarPush($pedido, $titulo, $mensaje);
    }

    // arma el título y mensaje según el nuevo estado
    private function texto(Pedido $pedido, string $campo, string $valor): array
    {
        $num = $pedido->numero;

        $mapa = [
            'estado_entrega' => [
                'nuevo'             => ['Pedido recibido', "Tu pedido $num fue recibido"],
                'en_preparacion'    => ['En preparación', "Tu pedido $num se está preparando"],
                'en_camino'         => ['En camino', "Tu pedido $num va en camino"],
                'listo_para_retiro' => ['Listo para retiro', "Tu pedido $num está listo para retirar"],
                'entregado'         => ['Entregado', "Tu pedido $num fue entregado, ¡buen provecho!"],
            ],
            'estado_pago' => [
                'pagado'    => ['Pago confirmado', "El pago de tu pedido $num fue confirmado"],
                'pendiente' => ['Pago pendiente', "Tu pedido $num está pendiente de pago"],
            ],
        ];

        // si el estado no está mapeado, un texto genérico de respaldo
        return $mapa[$campo][$valor] ?? ['Actualización de pedido', "Tu pedido $num cambió de estado"];
    }

    // envía el push a todos los dispositivos del cliente; si falla no rompe el flujo del panel
    private function enviarPush(Pedido $pedido, string $titulo, string $mensaje): void
    {
        $tokens = $pedido->user->dispositivos()->pluck('fcm_token')->all();

        if (empty($tokens)) {
            return;
        }

        $cloudMessage = CloudMessage::new()
            ->withNotification(FcmNotification::create($titulo, $mensaje))
            ->withData(['pedido_id' => (string) $pedido->id]);

        try {
            app('firebase.messaging')->sendMulticast($cloudMessage, $tokens);
        } catch (\Throwable $e) {
            Log::warning('FCM no se pudo enviar: ' . $e->getMessage());
        }
    }
}
