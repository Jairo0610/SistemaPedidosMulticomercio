package com.example.app_pedidos_multicomercio.Models;

import com.google.gson.annotations.SerializedName;

public class SubCategoria {
    private int id;
    @SerializedName("empresa_id")
    private int empresaId;
    private String nombre;
    private int orden;

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public int getEmpresaId() {
        return empresaId;
    }

    public void setEmpresaId(int empresaId) {
        this.empresaId = empresaId;
    }

    public String getNombre() {
        return nombre;
    }

    public void setNombre(String nombre) {
        this.nombre = nombre;
    }

    public int getOrden() {
        return orden;
    }

    public void setOrden(int orden) {
        this.orden = orden;
    }
}
