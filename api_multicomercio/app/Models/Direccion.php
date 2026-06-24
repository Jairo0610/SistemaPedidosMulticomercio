<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Direccion extends Model
{
    use HasFactory;
    protected $table = 'direcciones';

    protected $fillable = [
        'user_id',
        'nombre',
        'direccion',
        'referencia',
        'latitud',
        'longitud',
        'predeterminada',
    ];


    //cast de los campos para que se conviertan automáticamente a boolean y float,
    //al leer los datos de la bd y los serealiza a json se convierten a los tipos correctos
    protected $casts = [
        'predeterminada' => 'boolean',
        'latitud'        => 'float',
        'longitud'       => 'float',
    ];

    // Usuario cliente al que le pertenece esta dirección
    public function user()
    {
        return $this->belongsTo(User::class);
    }
}
