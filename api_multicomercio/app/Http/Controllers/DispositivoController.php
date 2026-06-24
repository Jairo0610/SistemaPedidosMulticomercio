<?php

namespace App\Http\Controllers;

use App\Http\Requests\StoreDispositivoRequest;
use App\Models\Dispositivo;

class DispositivoController extends Controller
{
    /**
     * registra el token FCM del dispositivo del cliente para recibir push
     * POST /api/dispositivos
     */
    public function store(StoreDispositivoRequest $request)
    {
        // el token es único; si ya existía se reasigna al usuario actual
        $dispositivo = Dispositivo::updateOrCreate(
            ['fcm_token' => $request->validated()['fcm_token']],
            ['user_id' => $request->user()->id],
        );

        return response()->json($dispositivo, 201);
    }
}
