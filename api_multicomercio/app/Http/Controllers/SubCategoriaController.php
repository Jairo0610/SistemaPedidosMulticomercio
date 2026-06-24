<?php

namespace App\Http\Controllers;
use App\Models\Subcategoria; 

use Illuminate\Http\Request;

class SubCategoriaController extends Controller
{
    public function index()
    {
        return Subcategoria::all();
    }

    public function show(Subcategoria $subcategoria)
    {
        return $subcategoria;
    }
}
