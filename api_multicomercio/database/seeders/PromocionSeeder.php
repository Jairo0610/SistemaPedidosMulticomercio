<?php

namespace Database\Seeders;

use App\Models\Empresa;
use App\Models\Promocion;
use Illuminate\Database\Console\Seeds\WithoutModelEvents;
use Illuminate\Database\Seeder;

class PromocionSeeder extends Seeder
{
    /**
     * Run the database seeds.
     */
    public function run(): void
    {
        // Una promoción vigente por empresa, aplicada a algunos de sus productos.
        // El enlace con los productos se guarda en la tabla pivote 'promocion_producto'
        // usando attach(). Las fechas están puestas para que quede activa al correr el seeder.
        $empresas = Empresa::with('productos')->get();

        foreach ($empresas as $empresa) {
            if ($empresa->productos->isEmpty()) {
                continue;
            }

            $promocion = Promocion::create([
                'empresa_id' => $empresa->id,
                'nombre' => 'Promoción ' . $empresa->nombre,
                'descripcion' => '15% de descuento en productos seleccionados',
                'tipo' => 'porcentaje',
                'valor' => 15.00,
                'fecha_inicio' => now()->subDay(),
                'fecha_fin' => now()->addMonth(),
                'activa' => true,
            ]);

            // Se eligen hasta 3 productos al azar y se vinculan a la promoción.
            $productos = $empresa->productos->random(min(3, $empresa->productos->count()));
            $promocion->productos()->attach($productos->pluck('id'));
        }
    }
}
