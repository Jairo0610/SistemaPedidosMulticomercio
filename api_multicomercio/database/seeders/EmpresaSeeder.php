<?php

namespace Database\Seeders;

use App\Models\Categoria;
use App\Models\Empresa;
use App\Models\Subcategoria;
use App\Models\Sucursal;
use App\Models\User;
use Illuminate\Database\Console\Seeds\WithoutModelEvents;
use Illuminate\Database\Seeder;

class EmpresaSeeder extends Seeder
{
    /**
     * Run the database seeds.
     */
    public function run(): void
    {
        // Cada empresa se enlaza a su usuario (rol empresa, creado en UserSeeder) y a una
        // categoría (creada en CategoriaSeeder), de aquí salen sus subcategorías y sucursales.
        // Se busca por nombre/email para no depender de ids fijos.
        $empresas = [
            [
                'user_email' => 'pizza@multicomercio.com',
                'categoria' => 'Restaurantes',
                'nombre' => 'Pizza Express',
                'descripcion' => 'Pizzas artesanales a la leña',
                'subcategorias' => ['Pizzas', 'Bebidas', 'Postres'],
                'sucursales' => [
                    ['nombre' => 'Pizza Express Centro',     'direccion' => 'Av. España #123, San Salvador', 'latitud' => 13.69810000, 'longitud' => -89.19140000, 'telefono' => '2222-1111'],
                    ['nombre' => 'Pizza Express Escalón',    'direccion' => 'Col. Escalón, San Salvador',     'latitud' => 13.70260000, 'longitud' => -89.24350000, 'telefono' => '2222-2222'],
                ],
            ],
            [
                'user_email' => 'farmacia@multicomercio.com',
                'categoria' => 'Farmacias',
                'nombre' => 'Farmacia Vida',
                'descripcion' => 'Medicamentos y cuidado personal',
                'subcategorias' => ['Medicamentos', 'Cuidado personal', 'Bebés'],
                'sucursales' => [
                    ['nombre' => 'Farmacia Vida Soyapango', 'direccion' => 'Blvd. del Ejército, Soyapango', 'latitud' => 13.71000000, 'longitud' => -89.13900000, 'telefono' => '2233-3333'],
                ],
            ],
            [
                'user_email' => 'super@multicomercio.com',
                'categoria' => 'Supermercados',
                'nombre' => 'Super La Despensa',
                'descripcion' => 'Abarrotes y productos del hogar',
                'subcategorias' => ['Abarrotes', 'Bebidas', 'Limpieza'],
                'sucursales' => [
                    ['nombre' => 'La Despensa Metrocentro', 'direccion' => 'Metrocentro, San Salvador', 'latitud' => 13.70500000, 'longitud' => -89.21800000, 'telefono' => '2244-4444'],
                    ['nombre' => 'La Despensa Santa Tecla', 'direccion' => 'Paseo El Carmen, Santa Tecla', 'latitud' => 13.67400000, 'longitud' => -89.28900000, 'telefono' => '2244-5555'],
                ],
            ],
        ];

        foreach ($empresas as $datos) {
            $user = User::where('email', $datos['user_email'])->firstOrFail();
            $categoria = Categoria::where('nombre', $datos['categoria'])->firstOrFail();

            $empresa = Empresa::create([
                'user_id' => $user->id,
                'categoria_id' => $categoria->id,
                'nombre' => $datos['nombre'],
                'descripcion' => $datos['descripcion'],
            ]);

            // Subcategorías del catálogo de la empresa (con orden de aparición).
            foreach ($datos['subcategorias'] as $orden => $nombre) {
                Subcategoria::create([
                    'empresa_id' => $empresa->id,
                    'nombre' => $nombre,
                    'orden' => $orden,
                ]);
            }

            // Sucursales físicas de la empresa.
            foreach ($datos['sucursales'] as $sucursal) {
                Sucursal::create(array_merge($sucursal, ['empresa_id' => $empresa->id]));
            }
        }
    }
}
