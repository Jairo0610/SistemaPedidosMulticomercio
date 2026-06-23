<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class Promocion extends Model
{
    protected $table = 'promociones';

    protected $fillable = [
        'empresa_id',
        'nombre',
        'descripcion',
        'tipo',
        'valor',
        'fecha_inicio',
        'fecha_fin',
        'activa',
    ];

    // De qué empresa es esta promoción
    public function empresa()
    {
        return $this->belongsTo(Empresa::class);
    }

    // Productos que entran en esta promoción
    public function productos()
    {
        return $this->belongsToMany(Producto::class, 'promocion_producto');
    }
}
