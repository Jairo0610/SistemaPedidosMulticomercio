<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class Subcategoria extends Model
{
    protected $fillable = [
        'empresa_id',
        'nombre',
        'orden',
    ];

    // Empresa dueña de esta lista de subcategorías
    public function empresa()
    {
        return $this->belongsTo(Empresa::class);
    }

    // Productos que pertenecen a esta subcategoría
    public function productos()
    {
        return $this->hasMany(Producto::class);
    }
}
