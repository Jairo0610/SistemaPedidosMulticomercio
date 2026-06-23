<?php

namespace Database\Factories;

use App\Models\Direccion;
use Illuminate\Database\Eloquent\Factories\Factory;

/**
 * @extends Factory<Direccion>
 */
class DireccionFactory extends Factory
{
    /**
     * Define the model's default state.
     *
     * @return array<string, mixed>
     */
    public function definition(): array
    {
        // 'user_id' lo asigna el seeder (InteraccionSeeder), porque la dirección pertenece
        // a un cliente concreto. Coordenadas dentro del área de San Salvador.
        return [
            'nombre' => fake()->randomElement(['Casa', 'Trabajo', 'Casa de mamá', 'Oficina']),
            'direccion' => fake()->streetAddress(),
            'referencia' => fake()->optional()->sentence(4),
            'latitud' => fake()->latitude(13.6, 13.8),
            'longitud' => fake()->longitude(-89.3, -89.1),
            'predeterminada' => false,
        ];
    }
}
