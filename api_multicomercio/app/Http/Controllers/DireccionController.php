<?php

namespace App\Http\Controllers;

use App\Http\Requests\StoreDireccionRequest;
use App\Models\Direccion;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;

class DireccionController extends Controller
{
    /**
     * lista de direcciones del cliente autenticado
     * se obtiene con GET /api/direcciones
     */
    public function index(Request $request)
    {
        return $request->user()
            ->direcciones()
            ->orderByDesc('predeterminada')
            ->orderByDesc('id')
            ->get();
    }

    /**
     * agregar una dirección a la libreta del cliente
     * se agrega con POST /api/direcciones
     */
    public function store(StoreDireccionRequest $request)
    {
        $datos = $request->validated();
        $datos['user_id'] = $request->user()->id;

        $direccion = DB::transaction(function () use ($request, $datos) {
            // Si esta dirección se marca predeterminada, desmarcar las demás del usuario.
            if (! empty($datos['predeterminada'])) {
                $request->user()->direcciones()->update(['predeterminada' => false]);
            }

            return Direccion::create($datos);
        });

        return response()->json($direccion, 201);
    }
}
