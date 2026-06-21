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
        Schema::create('pedidos', function (Blueprint $table) {
            $table->id();
            $table->string('numero', 30)->unique();
            $table->foreignId('user_id')->constrained('users')->onDelete('restrict');
            $table->foreignId('empresa_id')->constrained('empresas')->onDelete('restrict');
            $table->foreignId('sucursal_id')->constrained('sucursales')->onDelete('restrict');
            $table->enum('modalidad_entrega', ['domicilio', 'retiro']);
            $table->enum('metodo_pago', ['tarjeta', 'contra_entrega']);
            $table->enum('estado_entrega', ['nuevo', 'en_preparacion', 'en_camino', 'listo_para_retiro', 'entregado'])->default('nuevo');
            $table->enum('estado_pago', ['pendiente', 'pagado'])->default('pendiente');
            $table->decimal('total', 10, 2);
            $table->string('direccion_entrega', 255)->nullable();
            $table->decimal('latitud_entrega', 10, 8)->nullable();
            $table->decimal('longitud_entrega', 11, 8)->nullable();
            $table->string('stripe_payment_id', 100)->nullable();
            $table->timestamps();
            $table->index(['estado_entrega', 'estado_pago']);
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('pedidos');
    }
};
