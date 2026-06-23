<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Calificacion extends Model
{
    use HasFactory;
    protected $table = 'calificaciones';

    protected $fillable = [
        'user_id',
        'producto_id',
        'calificacion',
        'comentario',
    ];

    // Cliente que calificó
    public function user()
    {
        return $this->belongsTo(User::class);
    }

    // Qué producto calificó (uno por cliente)
    public function producto()
    {
        return $this->belongsTo(Producto::class);
    }

    
}
