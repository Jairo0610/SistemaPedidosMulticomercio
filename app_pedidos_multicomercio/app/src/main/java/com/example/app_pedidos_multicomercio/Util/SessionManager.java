package com.example.app_pedidos_multicomercio.Util;

import android.content.Context;
import android.content.SharedPreferences;

/**
 * Guarda el token de Sanctum que devuelve el backend tras verificar el login de Firebase.
 * Mantiene además una copia en memoria (estática) para que el interceptor de OkHttp pueda
 * leer el token sin necesitar un Context en cada petición.
 */
public class SessionManager {

    private static final String PREFS = "sesion";
    private static final String KEY_TOKEN = "sanctum_token";

    // Copia en memoria que lee AuthInterceptor.
    private static String tokenEnMemoria;

    /** Llamar una vez al arrancar (p. ej. en SessionActivity) para cargar el token guardado. */
    public static void init(Context context) {
        tokenEnMemoria = prefs(context).getString(KEY_TOKEN, null);
    }

    public static void guardarToken(Context context, String token) {
        tokenEnMemoria = token;
        prefs(context).edit().putString(KEY_TOKEN, token).apply();
    }

    /** Token actual (o null si no hay sesión). Lo usa el interceptor. */
    public static String getToken() {
        return tokenEnMemoria;
    }

    public static void limpiar(Context context) {
        tokenEnMemoria = null;
        prefs(context).edit().remove(KEY_TOKEN).apply();
    }

    private static SharedPreferences prefs(Context context) {
        return context.getApplicationContext().getSharedPreferences(PREFS, Context.MODE_PRIVATE);
    }
}
