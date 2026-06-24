package com.example.app_pedidos_multicomercio.Models;

import com.google.gson.annotations.SerializedName;

public class User {
    private int id;
    private String name;
    private String email;
    @SerializedName("foto_url")
    private String fotoUrl;
    private String rol;

    public int getId() { return id; }
    public String getName() { return name; }
    public String getEmail() { return email; }
    public String getFotoUrl() { return fotoUrl; }
    public String getRol() { return rol; }
}
