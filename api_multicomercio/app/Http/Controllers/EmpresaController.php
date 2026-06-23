<?php

namespace App\Http\Controllers;

use App\Models\Empresa;
use Illuminate\Http\Request;

class EmpresaController extends Controller
{
    public function index()
    {
        return response()->json(Empresa::with('sucursales')->get()->take(10));
    }

    public function show(Empresa $empresa)
    {
        return $empresa->load('sucursales');
    }
    public function productos(Empresa $empresa)
    {
        return $empresa->productos()->get();
    }
}
