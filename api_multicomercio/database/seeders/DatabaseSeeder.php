<?php

namespace Database\Seeders;

use Illuminate\Database\Console\Seeds\WithoutModelEvents;
use Illuminate\Database\Seeder;

class DatabaseSeeder extends Seeder
{
    use WithoutModelEvents;

    /**
     * Seed the application's database.
     */
    public function run(): void
    {
        // El orden lo dictan las llaves foráneas, no se puede crear una empresa sin que
        // exista su categoría y su usuario, ni un producto sin su empresa y subcategoría.
        $this->call([
            CategoriaSeeder::class,
            UserSeeder::class,
            EmpresaSeeder::class,
            ProductoSeeder::class,
            PromocionSeeder::class,
            InteraccionSeeder::class,
        ]);
    }
}
