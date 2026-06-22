<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class Favorito extends Model
{
    const UPDATED_AT = null;
    protected $fillable = [
        'user_id',
        'producto_id',
    ];

    // Que usuario cliente lo guardó
    public function user()
    {
        return $this->belongsTo(User::class);
    }

    // Qué producto es
    public function producto()
    {
        return $this->belongsTo(Producto::class);
    }
}
