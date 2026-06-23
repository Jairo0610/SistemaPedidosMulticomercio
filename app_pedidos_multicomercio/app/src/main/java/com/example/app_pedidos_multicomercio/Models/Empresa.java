package com.example.app_pedidos_multicomercio.Models;

import com.google.gson.annotations.SerializedName;
import java.util.List;

public class Empresa {
    private int id;
    @SerializedName("categoria_id")
    private int categoriaId;
    private String nombre;
    private String descripcion;
    @SerializedName("logo_url")
    private String logoUrl;
    private List<Sucursal> sucursales;

    public int getId() { return id; }
    public void setId(int id) { this.id = id; }

    public int getCategoriaId() { return categoriaId; }
    public void setCategoriaId(int categoriaId) { this.categoriaId = categoriaId; }

    public String getNombre() { return nombre; }
    public void setNombre(String nombre) { this.nombre = nombre; }

    public String getDescripcion() { return descripcion; }
    public void setDescripcion(String descripcion) { this.descripcion = descripcion; }

    public String getLogoUrl() { return logoUrl; }
    public void setLogoUrl(String logoUrl) { this.logoUrl = logoUrl; }

    public List<Sucursal> getSucursales() { return sucursales; }
    public void setSucursales(List<Sucursal> sucursales) { this.sucursales = sucursales; }
}
