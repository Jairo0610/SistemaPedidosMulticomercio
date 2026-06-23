package com.example.app_pedidos_multicomercio.Models;

import com.google.gson.annotations.SerializedName;

public class Categoria {
    private int id;
    private String nombre;
    private String descripcion;
    @SerializedName("icono_url")
    private String iconoUrl;

    public int getId() { return id; }
    public void setId(int id) { this.id = id; }

    public String getNombre() { return nombre; }
    public void setNombre(String nombre) { this.nombre = nombre; }

    public String getDescripcion() { return descripcion; }
    public void setDescripcion(String descripcion) { this.descripcion = descripcion; }

    public String getIconoUrl() { return iconoUrl; }
    public void setIconoUrl(String iconoUrl) { this.iconoUrl = iconoUrl; }
}
