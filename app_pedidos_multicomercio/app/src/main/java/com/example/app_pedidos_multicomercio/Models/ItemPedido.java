package com.example.app_pedidos_multicomercio.Models;

import com.google.gson.annotations.SerializedName;

/* una línea del pedido que la app envía: qué producto y cuántos. */
public class ItemPedido {
    @SerializedName("producto_id")
    private int productoId;
    private int cantidad;

    public ItemPedido(int productoId, int cantidad) {
        this.productoId = productoId;
        this.cantidad = cantidad;
    }
}
