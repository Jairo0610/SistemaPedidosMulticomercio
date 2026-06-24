package com.example.app_pedidos_multicomercio.Client;

import com.example.app_pedidos_multicomercio.Util.SessionManager;

import java.io.IOException;

import okhttp3.Interceptor;
import okhttp3.Request;
import okhttp3.Response;

/**
 * Añade automáticamente el header Authorization: Bearer <token> a cada petición
 * cuando hay sesión iniciada. Así no hay que repetirlo en cada llamada.
 */
public class AuthInterceptor implements Interceptor {

    @Override
    public Response intercept(Chain chain) throws IOException {
        Request original = chain.request();
        String token = SessionManager.getToken();

        if (token == null) {
            return chain.proceed(original);
        }

        Request conToken = original.newBuilder()
                .header("Authorization", "Bearer " + token)
                .header("Accept", "application/json")
                .build();

        return chain.proceed(conToken);
    }
}
