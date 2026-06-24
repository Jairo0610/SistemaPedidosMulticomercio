package com.example.app_pedidos_multicomercio.Models;

import com.google.gson.annotations.SerializedName;

// lo que la app envía a POST /api/dispositivos para registrar el token FCM
public class DispositivoRequest {
    @SerializedName("fcm_token")
    private String fcmToken;

    public DispositivoRequest(String fcmToken) {
        this.fcmToken = fcmToken;
    }
}
