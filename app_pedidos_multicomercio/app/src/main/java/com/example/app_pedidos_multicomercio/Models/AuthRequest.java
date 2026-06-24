package com.example.app_pedidos_multicomercio.Models;

import com.google.gson.annotations.SerializedName;

/* lo que la app envía a POST /api/auth/firebase. */
public class AuthRequest {
    @SerializedName("id_token")
    private String idToken;

    public AuthRequest(String idToken) {
        this.idToken = idToken;
    }
}
