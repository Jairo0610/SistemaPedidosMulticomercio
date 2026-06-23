<?php

namespace Database\Seeders;

use App\Models\Calificacion;
use App\Models\Direccion;
use App\Models\Favorito;
use App\Models\Producto;
use App\Models\User;
use Illuminate\Database\Console\Seeds\WithoutModelEvents;
use Illuminate\Database\Seeder;

class InteraccionSeeder extends Seeder
{
    /**
     * Run the database seeds.
     */
    public function run(): void
    {
        // Direcciones, favoritos y calificaciones de cada cliente, para tener datos con qué
        // probar esos endpoints. Los pedidos no se siembran aquí porque nacen del flujo de
        // compra, no de datos estáticos.
        $clientes = User::where('rol', 'cliente')->get();
        $productos = Producto::all();

        if ($productos->isEmpty()) {
            return;
        }

        foreach ($clientes as $cliente) {
            // Una dirección predeterminada y, a veces, una segunda.
            Direccion::factory()->create([
                'user_id' => $cliente->id,
                'predeterminada' => true,
            ]);

            if (fake()->boolean()) {
                Direccion::factory()->create(['user_id' => $cliente->id]);
            }

            // Hasta 3 productos marcados como favoritos. La tabla tiene índice único
            // (user_id, producto_id), así que random() devuelve productos sin repetir.
            foreach ($productos->random(min(3, $productos->count())) as $producto) {
                Favorito::create([
                    'user_id' => $cliente->id,
                    'producto_id' => $producto->id,
                ]);
            }

            // Hasta 2 calificaciones por cliente. Mismo índice único, sin repetir producto.
            foreach ($productos->random(min(2, $productos->count())) as $producto) {
                Calificacion::factory()->create([
                    'user_id' => $cliente->id,
                    'producto_id' => $producto->id,
                ]);
            }
        }
    }
}
