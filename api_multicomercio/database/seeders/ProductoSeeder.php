<?php

namespace Database\Seeders;

use App\Models\Disponibilidad;
use App\Models\Empresa;
use App\Models\Producto;
use Illuminate\Database\Console\Seeds\WithoutModelEvents;
use Illuminate\Database\Seeder;

class ProductoSeeder extends Seeder
{
    /**
     * Run the database seeds.
     */
    public function run(): void
    {
        // 4 productos por subcategoría generados con la factory, por cada uno se registra
        // su disponibilidad en cada sucursal de la empresa, la tabla tiene índice único
        // (sucursal_id, producto_id), por eso se crea exactamente una fila por combinación.
        $empresas = Empresa::with(['subcategorias', 'sucursales'])->get();

        foreach ($empresas as $empresa) {
            foreach ($empresa->subcategorias as $subcategoria) {
                $productos = Producto::factory()
                    ->count(4)
                    ->create([
                        'empresa_id' => $empresa->id,
                        'subcategoria_id' => $subcategoria->id,
                    ]);

                foreach ($productos as $producto) {
                    foreach ($empresa->sucursales as $sucursal) {
                        Disponibilidad::create([
                            'sucursal_id' => $sucursal->id,
                            'producto_id' => $producto->id,
                            'stock' => fake()->numberBetween(10, 100),
                            'stock_minimo' => 5,
                            'disponible' => true,
                        ]);
                    }
                }
            }
        }
    }
}
