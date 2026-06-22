<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class HistorialEstadoPedido extends Model
{
    protected $table = 'historial_estados_pedido';
    const UPDATED_AT = null;
    protected $fillable = [
        'pedido_id',
        'estado',
        'observacion',
    ];

    // Pedido al que pertenece este cambio
    public function pedido()
    {
        return $this->belongsTo(Pedido::class);
    }
}
