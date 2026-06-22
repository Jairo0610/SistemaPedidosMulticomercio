<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class Disponibilidad extends Model
{
    protected $fillable = [
        'sucursal_id',
        'producto_id',
        'stock',
        'stock_minimo',
        'disponible',
    ];

    // En qué sucursal está este stock
    public function sucursal()
    {
        return $this->belongsTo(Sucursal::class);
    }

    // De qué producto es este registro
    public function producto()
    {
        return $this->belongsTo(Producto::class);
    }
}
