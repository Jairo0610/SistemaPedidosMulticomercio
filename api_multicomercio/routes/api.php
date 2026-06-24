<?php
use App\Http\Controllers\SubCategoriaController;
use App\Http\Controllers\CategoriaController;
use App\Http\Controllers\EmpresaController;
use App\Http\Controllers\ProductoController;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Route;

Route::get('/user', function (Request $request) {
    return $request->user();
})->middleware('auth:sanctum');

Route::get('/categorias', [CategoriaController::class, 'index']);

Route::get('/empresas', [EmpresaController::class, 'index']);

Route::get('/empresas/{empresa}', [EmpresaController::class, 'show']);

Route::get('/empresas/{empresa}/productos', [EmpresaController::class, 'productos']);

Route::get('/productos', [ProductoController::class, 'index']);

Route::get('/productos/{producto}', [ProductoController::class, 'show']);

Route::get('/subCategorias', [SubCategoriaController::class, 'index']);

Route::get('/subCategorias/{subcategoria}', [SubCategoriaController::class, 'show']);