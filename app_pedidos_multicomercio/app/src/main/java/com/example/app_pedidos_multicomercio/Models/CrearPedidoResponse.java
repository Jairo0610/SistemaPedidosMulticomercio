package com.example.app_pedidos_multicomercio.Models;

import com.google.gson.annotations.SerializedName;

/* respuesta de POST /api/pedidos: el pedido creado y el client_secret de Stripe. */
public class CrearPedidoResponse {
    @SerializedName("pedido_id")
    private int pedidoId;
    private String numero;
    private double total;
    @SerializedName("client_secret")
    private String clientSecret;

    public int getPedidoId() { return pedidoId; }
    public String getNumero() { return numero; }
    public double getTotal() { return total; }
    public String getClientSecret() { return clientSecret; }
}
