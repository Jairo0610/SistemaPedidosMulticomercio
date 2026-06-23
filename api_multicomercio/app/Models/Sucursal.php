<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class Sucursal extends Model
{
    protected $table = 'sucursales';

    protected $fillable = [
        'empresa_id',
        'nombre',
        'direccion',
        'latitud',
        'longitud',
        'telefono',
        'activa',
    ];

    // De qué empresa es esta sucursal
    public function empresa()
    {
        return $this->belongsTo(Empresa::class);
    }

    // Pedidos que llegan a esta sucursal
    public function pedidos()
    {
        return $this->hasMany(Pedido::class);
    }

    // Qué hay en stock aquí
    public function disponibilidades()
    {
        return $this->hasMany(Disponibilidad::class);
    }
}
