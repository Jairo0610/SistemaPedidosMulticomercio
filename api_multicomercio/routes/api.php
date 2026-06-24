<?php

use App\Http\Controllers\AuthController;
use App\Http\Controllers\CategoriaController;
use App\Http\Controllers\DireccionController;
use App\Http\Controllers\EmpresaController;
use App\Http\Controllers\PedidoController;
use App\Http\Controllers\ProductoController;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Route;

// autenticación de la app móvil (pública)
Route::post('/auth/firebase', [AuthController::class, 'firebase']);

// catálogo (público, solo lectura)
Route::get('/categorias', [CategoriaController::class, 'index']);
Route::get('/empresas', [EmpresaController::class, 'index']);
Route::get('/empresas/{empresa}', [EmpresaController::class, 'show']);
Route::get('/empresas/{empresa}/productos', [EmpresaController::class, 'productos']);
Route::get('/productos', [ProductoController::class, 'index']);
Route::get('/productos/{producto}', [ProductoController::class, 'show']);

// rutas del cliente (requieren token de Sanctum)
Route::middleware('auth:sanctum')->group(function () {
    Route::get('/user', fn (Request $request) => $request->user());

    // libreta de direcciones
    Route::get('/direcciones', [DireccionController::class, 'index']);
    Route::post('/direcciones', [DireccionController::class, 'store']);

    // pedidos
    Route::get('/pedidos', [PedidoController::class, 'index']);
    Route::post('/pedidos', [PedidoController::class, 'store']);
    Route::post('/pedidos/{pedido}/confirmar-pago', [PedidoController::class, 'confirmarPago']);
});
