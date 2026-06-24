<?php

namespace App\Http\Controllers;

use App\Models\User;
use Illuminate\Http\Request;
use Kreait\Firebase\Contract\Auth as FirebaseAuth;
use Kreait\Firebase\Exception\Auth\FailedToVerifyToken;

class AuthController extends Controller
{
    /**
     * POST /api/auth/firebase   body: { "id_token": "<ID token de Firebase>" }
     * Devuelve un token de Sanctum que la app usará en cada petición.
     */
    public function firebase(Request $request, FirebaseAuth $firebaseAuth)
    {
        $request->validate([
            'id_token' => ['required', 'string'],
        ]);

        // 1. Verificar el ID token contra Firebase y obtener los datos del usuario.
        try {
            // los 60 segundos dan margen por si el reloj del servidor va un poco atrasado
            $verified = $firebaseAuth->verifyIdToken($request->input('id_token'), false, 60);
        } catch (FailedToVerifyToken $e) {
            return response()->json(['message' => 'ID token de Firebase inválido.'], 401);
        }

        // 2. Datos del usuario que vienen firmados dentro del token.
        $uid    = $verified->claims()->get('sub');
        $email  = $verified->claims()->get('email');
        $nombre = $verified->claims()->get('name') ?? $email;
        $foto   = $verified->claims()->get('picture');

        // 3. Buscar o crear el usuario por firebase_uid.
        $user = User::firstOrCreate(
            ['firebase_uid' => $uid],
            [
                'name'     => $nombre,
                'email'    => $email,
                'foto_url' => $foto,
                'rol'      => 'cliente',
            ]
        );

        // 4. Emitir un token de Sanctum para la app.
        $token = $user->createToken('mobile')->plainTextToken;

        return response()->json([
            'token' => $token,
            'user'  => $user,
        ]);
    }
}
