package com.example.app_pedidos_multicomercio.Util;

import com.example.app_pedidos_multicomercio.Client.ApiClient;
import com.example.app_pedidos_multicomercio.Models.DispositivoRequest;
import com.google.firebase.messaging.FirebaseMessaging;

import retrofit2.Call;
import retrofit2.Callback;
import retrofit2.Response;

// registra el token FCM del dispositivo en el backend para recibir notificaciones push
public class FcmManager {

    // pide el token actual a Firebase y lo manda al backend
    public static void registrarToken() {
        // sin token de Sanctum no se puede autenticar el registro
        if (SessionManager.getToken() == null) return;

        FirebaseMessaging.getInstance().getToken()
                .addOnCompleteListener(task -> {
                    if (task.isSuccessful() && task.getResult() != null) {
                        enviar(task.getResult());
                    }
                });
    }

    // envía un token ya conocido (lo usa onNewToken del servicio de mensajería)
    public static void enviar(String fcmToken) {
        if (SessionManager.getToken() == null) return;

        ApiClient.getApiService().registrarDispositivo(new DispositivoRequest(fcmToken))
                .enqueue(new Callback<Void>() {
                    @Override
                    public void onResponse(Call<Void> call, Response<Void> response) { }

                    @Override
                    public void onFailure(Call<Void> call, Throwable t) { }
                });
    }
}
