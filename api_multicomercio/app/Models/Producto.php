<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\SoftDeletes;

class Producto extends Model
{
    use HasFactory, SoftDeletes;
    protected $fillable = [
        'empresa_id',
        'subcategoria_id',
        'nombre',
        'descripcion',
        'imagen_url',
        'precio',
        'activo',
    ];

    // De qué empresa es este producto
    public function empresa()
    {
        return $this->belongsTo(Empresa::class);
    }

    // A qué sección del catálogo de subcategorias pertenece
    public function subcategoria()
    {
        return $this->belongsTo(Subcategoria::class);
    }

    // Promos que le aplican
    public function promociones()
    {
        return $this->belongsToMany(Promocion::class, 'promocion_producto');
    }

    // En qué pedidos aparece (precio fijo al momento de comprar)
    public function detalles()
    {
        return $this->hasMany(DetallePedido::class);
    }

    // Stock por sucursal
    public function disponibilidades()
    {
        return $this->hasMany(Disponibilidad::class);
    }

    // Calificaciones que le han dejado
    public function calificaciones()
    {
        return $this->hasMany(Calificacion::class);
    }

    // Quién lo tiene guardado como favorito
    public function favoritos()
    {
        return $this->hasMany(Favorito::class);
    }

    // devuelve la URL pública de Firebase a partir de la ruta guardada,
    // así la app puede cargar la imagen directamente con Glide
    protected function getImagenUrlAttribute(?string $value): ?string
    {
        if (! $value) {
            return null;
        }
        // si ya viene como URL completa (datos antiguos), se deja igual
        if (str_starts_with($value, 'http')) {
            return $value;
        }
        $bucket = config('filesystems.disks.firebase.bucket');
        return 'https://firebasestorage.googleapis.com/v0/b/'
            . $bucket . '/o/' . rawurlencode($value) . '?alt=media';
    }
}
