<?php

namespace App\Http\Controllers;

use App\Models\Empresa;
use Illuminate\Http\Request;

class EmpresaController extends Controller
{
    public function index()
    {
        return Empresa::with('sucursales')->get();
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
