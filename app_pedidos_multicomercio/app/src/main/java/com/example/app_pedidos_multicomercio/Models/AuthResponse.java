package com.example.app_pedidos_multicomercio.Models;

/* respuesta de POST /api/auth/firebase: el token de Sanctum + el usuario. */
public class AuthResponse {
    private String token;
    private User user;

    public String getToken() { return token; }
    public User getUser() { return user; }
}
