package com.example.app_pedidos_multicomercio.Models;

public class Direccion {
    private int id;
    private String nombre;
    private String direccion;
    private String referencia;
    private Double latitud;
    private Double longitud;
    private boolean predeterminada;

    public int getId() { return id; }
    public String getNombre() { return nombre; }
    public String getDireccion() { return direccion; }
    public String getReferencia() { return referencia; }
    public Double getLatitud() { return latitud; }
    public Double getLongitud() { return longitud; }
    public boolean isPredeterminada() { return predeterminada; }

    @Override
    public String toString() {
        return nombre + " — " + direccion;
    }
}
