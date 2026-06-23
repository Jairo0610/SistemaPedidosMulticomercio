<?php

namespace Database\Seeders;

use App\Models\Categoria;
use Illuminate\Database\Console\Seeds\WithoutModelEvents;
use Illuminate\Database\Seeder;

class CategoriaSeeder extends Seeder
{
    /**
     * Run the database seeds.
     */
    public function run(): void
    {
        // Categorías fijas del negocio (se declaran en seeder
        // y no en factory). Son la base de la que cuelgan las empresas.
        $categorias = [
            ['nombre' => 'Restaurantes', 'descripcion' => 'Comida preparada y a domicilio'],
            ['nombre' => 'Farmacias',    'descripcion' => 'Medicamentos y productos de salud'],
            ['nombre' => 'Supermercados','descripcion' => 'Abarrotes y productos del hogar'],
            ['nombre' => 'Tiendas',      'descripcion' => 'Comercios y artículos varios'],
            ['nombre' => 'Cafeterías',   'descripcion' => 'Café, panadería y repostería'],
            ['nombre' => 'Ferreterías',  'descripcion' => 'Herramientas y materiales'],
        ];

        foreach ($categorias as $categoria) {
            Categoria::create($categoria);
        }
    }
}
