package com.example.app_pedidos_multicomercio.Models;

import com.google.gson.annotations.SerializedName;

/* respuesta de POST /api/pedidos/intent: el client_secret y el id del PaymentIntent. */
public class CrearPedidoResponse {
    private double total;
    @SerializedName("client_secret")
    private String clientSecret;
    @SerializedName("payment_intent_id")
    private String paymentIntentId;

    public double getTotal() { return total; }
    public String getClientSecret() { return clientSecret; }
    public String getPaymentIntentId() { return paymentIntentId; }
}
