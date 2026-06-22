<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class Direccion extends Model
{
    protected $fillable = [
        'user_id',
        'nombre',
        'direccion',
        'referencia',
        'latitud',
        'longitud',
        'predeterminada',
    ];

    // Usuario cliente al que le pertenece esta dirección
    public function user()
    {
        return $this->belongsTo(User::class);
    }
}
