<?php

namespace App\Models;

use App\Services\NotificacionService;
use Illuminate\Database\Eloquent\Model;

class Pedido extends Model
{
    protected $fillable = [
        'numero',
        'user_id',
        'empresa_id',
        'sucursal_id',
        'modalidad_entrega',
        'metodo_pago',
        'estado_entrega',
        'estado_pago',
        'total',
        'direccion_entrega',
        'latitud_entrega',
        'longitud_entrega',
        'stripe_payment_id',
    ];
    
    // Quién hizo el pedido
    public function user()
    {
        return $this->belongsTo(User::class);
    }

    // A qué empresa va el pedido
    public function empresa()
    {
        return $this->belongsTo(Empresa::class);
    }

    // Sucursal que atiende el pedido
    public function sucursal()
    {
        return $this->belongsTo(Sucursal::class);
    }

    // Qué pidió, con el precio que tenía al momento
    public function detalles()
    {
        return $this->hasMany(DetallePedido::class);
    }

    // Por qué estados pasó el pedido
    public function historialEstados()
    {
        return $this->hasMany(HistorialEstadoPedido::class);
    }

    // Notificaciones que se mandaron por este pedido
    public function notificaciones()
    {
        return $this->hasMany(Notificacion::class);
    }

    // cambia un estado (entrega o pago), registra el historial y notifica al cliente
    // $campo es 'estado_entrega' o 'estado_pago'
    public function cambiarEstado(string $campo, string $valor, ?string $observacion = null): void
    {
        $this->update([$campo => $valor]);

        $this->historialEstados()->create([
            'estado'      => $valor,
            'observacion' => $observacion,
        ]);

        app(NotificacionService::class)->pedidoEstadoCambiado($this, $campo, $valor);
    }
}
