package com.example.app_pedidos_multicomercio.Models;

import com.google.gson.annotations.SerializedName;

public class Producto {
    private int id;
    @SerializedName("empresa_id")
    private int empresaId;
    @SerializedName("subcategoria_id")
    private int subcategoriaId;
    private String nombre;
    private String descripcion;
    @SerializedName("imagen_url")
    private String imagenUrl;
    private double precio;

    public int getId() { return id; }
    public void setId(int id) { this.id = id; }

    public int getEmpresaId() { return empresaId; }
    public void setEmpresaId(int empresaId) { this.empresaId = empresaId; }

    public int getSubcategoriaId() { return subcategoriaId; }
    public void setSubcategoriaId(int subcategoriaId) { this.subcategoriaId = subcategoriaId; }

    public String getNombre() { return nombre; }
    public void setNombre(String nombre) { this.nombre = nombre; }

    public String getDescripcion() { return descripcion; }
    public void setDescripcion(String descripcion) { this.descripcion = descripcion; }

    public String getImagenUrl() { return imagenUrl; }
    public void setImagenUrl(String imagenUrl) { this.imagenUrl = imagenUrl; }

    public double getPrecio() { return precio; }
    public void setPrecio(double precio) { this.precio = precio; }
}
