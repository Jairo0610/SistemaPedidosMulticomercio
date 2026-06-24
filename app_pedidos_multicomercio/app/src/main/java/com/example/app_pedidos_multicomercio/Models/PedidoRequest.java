package com.example.app_pedidos_multicomercio.Models;

import com.google.gson.annotations.SerializedName;

import java.util.List;

/* cuerpo de POST /api/pedidos/intent y POST /api/pedidos */
public class PedidoRequest {
    @SerializedName("empresa_id")
    private int empresaId;
    @SerializedName("direccion_id")
    private int direccionId;
    private List<ItemPedido> items;
    // solo se setea para el POST /pedidos final (tras pagar); en el intent va null
    @SerializedName("payment_intent_id")
    private String paymentIntentId;

    public PedidoRequest(int empresaId, int direccionId, List<ItemPedido> items) {
        this.empresaId = empresaId;
        this.direccionId = direccionId;
        this.items = items;
    }

    public void setPaymentIntentId(String paymentIntentId) {
        this.paymentIntentId = paymentIntentId;
    }
}
