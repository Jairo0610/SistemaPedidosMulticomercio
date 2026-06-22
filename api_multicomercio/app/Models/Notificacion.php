<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class Notificacion extends Model
{
    const UPDATED_AT = null;
    protected $fillable = [
        'user_id',
        'pedido_id',
        'titulo',
        'mensaje',
        'tipo',
        'leida',
    ];

    // A quién va la notificación
    public function user()
    {
        return $this->belongsTo(User::class);
    }

    // Pedido relacionado con esta notificación
    public function pedido()
    {
        return $this->belongsTo(Pedido::class);
    }
}
