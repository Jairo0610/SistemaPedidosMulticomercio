package com.example.app_pedidos_multicomercio.Models;

import com.google.gson.annotations.SerializedName;

public class Detalle {
    @SerializedName("producto_id")
    private int productoId;
    private int cantidad;
    @SerializedName("precio_unitario")
    private double precioUnitario;
    private double subtotal;
    private Producto producto;

    public int getProductoId() { return productoId; }
    public int getCantidad() { return cantidad; }
    public double getPrecioUnitario() { return precioUnitario; }
    public double getSubtotal() { return subtotal; }

    public String getNombreProducto() {
        return producto != null ? producto.getNombre() : ("Producto #" + productoId);
    }
}
