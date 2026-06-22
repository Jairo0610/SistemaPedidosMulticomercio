<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class DetallePedido extends Model
{
    protected $fillable = [
        'pedido_id',
        'producto_id',
        'cantidad',
        'precio_unitario',
        'subtotal',
    ];

    // Pedido al que pertenece
    public function pedido()
    {
        return $this->belongsTo(Pedido::class);
    }

    // Qué producto se pidió, precio fijo al momento de comprar
    public function producto()
    {
        return $this->belongsTo(Producto::class);
    }
}
