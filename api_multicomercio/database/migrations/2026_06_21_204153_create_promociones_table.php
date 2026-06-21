<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    /**
     * Run the migrations.
     */
    public function up(): void
    {
        Schema::create('promociones', function (Blueprint $table) {
            $table->id();
            $table->foreignId('empresa_id')->constrained('empresas')->onDelete('cascade');
            $table->string('nombre', 150);
            $table->text('descripcion')->nullable();
            $table->enum('tipo', ['porcentaje', 'monto_fijo']);
            $table->decimal('valor', 10, 2);
            $table->dateTime('fecha_inicio');
            $table->dateTime('fecha_fin');
            $table->boolean('activa')->default(true);
            $table->timestamps();
            $table->index(['fecha_inicio', 'fecha_fin']);
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('promociones');
    }
};
