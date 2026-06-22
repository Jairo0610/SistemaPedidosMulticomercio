<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class Categoria extends Model
{
    protected $fillable = [
        'nombre',
        'descripcion',
        'icono_url',
        'activa',
    ];

    // Empresas agrupadas bajo esta categoría (restaurantes, farmacias, tiendas, etc.)
    public function empresas()
    {
        return $this->hasMany(Empresa::class);
    }
}
