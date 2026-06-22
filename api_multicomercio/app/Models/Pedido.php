<?php

namespace App\Models;

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
}
