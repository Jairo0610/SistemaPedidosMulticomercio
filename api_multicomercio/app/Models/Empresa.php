<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class Empresa extends Model
{
    protected $fillable = [
        'user_id',
        'categoria_id',
        'nombre',
        'descripcion',
        'logo_url',
        'activa',
    ];

    // Usuario propietario/administrador de la empresa
    public function user()
    {
        return $this->belongsTo(User::class);
    }

    // Categoría a la que pertenece la empresa (restaurante, farmacia, tienda, etc.)
    public function categoria()
    {
        return $this->belongsTo(Categoria::class);
    }

    // Agrupaciones del menú/catálogo definidas por la empresa
    public function subcategorias()
    {
        return $this->hasMany(Subcategoria::class);
    }

    // Puntos físicos de la empresa donde se preparan y retiran pedidos
    public function sucursales()
    {
        return $this->hasMany(Sucursal::class);
    }

    // Pedidos recibidos en cualquier sucursal de la empresa
    public function pedidos()
    {
        return $this->hasMany(Pedido::class);
    }

    // Catálogo completo de productos de la empresa
    public function productos()
    {
        return $this->hasMany(Producto::class);
    }

    // Promociones activas o históricas de la empresa
    public function promociones()
    {
        return $this->hasMany(Promocion::class);
    }
}
