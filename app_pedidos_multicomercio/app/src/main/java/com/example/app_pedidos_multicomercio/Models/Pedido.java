package com.example.app_pedidos_multicomercio.Models;

import com.google.gson.annotations.SerializedName;

import java.util.List;

public class Pedido {
    private int id;
    private String numero;
    private double total;
    @SerializedName("estado_entrega")
    private String estadoEntrega;
    @SerializedName("estado_pago")
    private String estadoPago;
    @SerializedName("created_at")
    private String createdAt;
    private Empresa empresa;
    private List<Detalle> detalles;

    public int getId() { return id; }
    public String getNumero() { return numero; }
    public double getTotal() { return total; }
    public String getEstadoEntrega() { return estadoEntrega; }
    public String getEstadoPago() { return estadoPago; }
    public String getCreatedAt() { return createdAt; }
    public List<Detalle> getDetalles() { return detalles; }

    public String getNombreEmpresa() {
        return empresa != null ? empresa.getNombre() : "";
    }
}
