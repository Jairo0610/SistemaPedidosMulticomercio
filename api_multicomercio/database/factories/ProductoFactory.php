<?php

namespace Database\Factories;

use App\Models\Producto;
use Illuminate\Database\Eloquent\Factories\Factory;

/**
 * @extends Factory<Producto>
 */
class ProductoFactory extends Factory
{
    /**
     * Define the model's default state.
     *
     * @return array<string, mixed>
     */
    public function definition(): array
    {
        // 'empresa_id' y 'subcategoria_id' los asigna el seeder al crear, porque dependen
        // de la empresa y su catálogo. Si se usa esta factory de forma aislada se pasan estos campos.
        return [
            'nombre' => ucfirst(fake()->words(2, true)),
            'descripcion' => fake()->sentence(8),
            'imagen_url' => null,
            'precio' => fake()->randomFloat(2, 1, 50),
            'activo' => true,
        ];
    }

    /**
     * Producto oculto del catálogo (no se muestra a los clientes).
     */
    public function inactivo(): static
    {
        return $this->state(fn (array $attributes) => [
            'activo' => false,
        ]);
    }
}
