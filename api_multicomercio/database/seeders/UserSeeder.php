<?php

namespace Database\Seeders;

use App\Models\User;
use Illuminate\Database\Console\Seeds\WithoutModelEvents;
use Illuminate\Database\Seeder;
use Illuminate\Support\Facades\Hash;

class UserSeeder extends Seeder
{
    /**
     * Run the database seeds.
     */
    public function run(): void
    {
        // 1) Administrador del sistema, entra al panel con email y contraseña.
        User::create([
            'name' => 'Administrador',
            'email' => 'admin@multicomercio.com',
            'password' => Hash::make('password'),
            'rol' => 'admin',
        ]);

        // 2) Dueños de empresa, también entran al panel con contraseña. Cada uno gestionará
        //    una empresa, se enlazan en EmpresaSeeder buscando por este email.
        $empresas = [
            ['name' => 'Pizza Express',      'email' => 'pizza@multicomercio.com'],
            ['name' => 'Farmacia Vida',      'email' => 'farmacia@multicomercio.com'],
            ['name' => 'Super La Despensa',  'email' => 'super@multicomercio.com'],
        ];

        foreach ($empresas as $empresa) {
            User::create([
                'name' => $empresa['name'],
                'email' => $empresa['email'],
                'password' => Hash::make('password'),
                'rol' => 'empresa',
            ]);
        }

        // 3) Clientes, inician sesión con Google/Firebase sin contraseña, se generan
        //    con la factory usando el estado cliente().
        User::factory()->cliente()->count(8)->create();
    }
}
