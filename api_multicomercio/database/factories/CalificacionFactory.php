<?php

namespace Database\Factories;

use App\Models\Calificacion;
use Illuminate\Database\Eloquent\Factories\Factory;

/**
 * @extends Factory<Calificacion>
 */
class CalificacionFactory extends Factory
{
    /**
     * Define the model's default state.
     *
     * @return array<string, mixed>
     */
    public function definition(): array
    {
        // 'user_id' y 'producto_id' los asigna el seeder. La tabla tiene índice único
        // (user_id, producto_id), un cliente solo puede calificar una vez cada producto,
        // así que quien llame a esta factory tiene que evitar repetir esa combinación.
        return [
            'calificacion' => fake()->numberBetween(1, 5),
            'comentario' => fake()->optional()->sentence(),
        ];
    }
}
