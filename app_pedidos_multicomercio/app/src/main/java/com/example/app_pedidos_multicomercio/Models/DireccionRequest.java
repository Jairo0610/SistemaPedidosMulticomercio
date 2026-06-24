package com.example.app_pedidos_multicomercio.Models;

/* lo que la app envía a POST /api/direcciones para agregar una dirección. */
public class DireccionRequest {
    private String nombre;
    private String direccion;
    private String referencia;
    private Double latitud;
    private Double longitud;
    private boolean predeterminada;

    public DireccionRequest(String nombre, String direccion, String referencia,
                            Double latitud, Double longitud, boolean predeterminada) {
        this.nombre = nombre;
        this.direccion = direccion;
        this.referencia = referencia;
        this.latitud = latitud;
        this.longitud = longitud;
        this.predeterminada = predeterminada;
    }
}
