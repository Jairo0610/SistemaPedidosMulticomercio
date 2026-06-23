package com.example.app_pedidos_multicomercio.Entitys;

import androidx.room.Entity;
import androidx.room.PrimaryKey;

@Entity(tableName = "productos")
public class Producto {
    @PrimaryKey(autoGenerate = false)
    private int idProducto;
    private String refereceProducto;
    private String imgURL;
    private String nombreProducto;
    private int cantidad;
    private double precioUnitario;

    public Producto() {
    }

    public Producto(int idProducto, String refereceProducto, String imgURL, String nombreProducto, int cantidad, double precioUnitario) {
        this.idProducto = idProducto;
        this.refereceProducto = refereceProducto;
        this.imgURL = imgURL;
        this.nombreProducto = nombreProducto;
        this.cantidad = cantidad;
        this.precioUnitario = precioUnitario;
    }

    public int getIdProducto() {
        return idProducto;
    }

    public void setIdProducto(int idProducto) {
        this.idProducto = idProducto;
    }

    public String getRefereceProducto() {
        return refereceProducto;
    }

    public void setRefereceProducto(String refereceProducto) {
        this.refereceProducto = refereceProducto;
    }

    public String getImgURL() {
        return imgURL;
    }

    public void setImgURL(String imgURL) {
        this.imgURL = imgURL;
    }

    public String getNombreProducto() {
        return nombreProducto;
    }

    public void setNombreProducto(String nombreProducto) {
        this.nombreProducto = nombreProducto;
    }

    public int getCantidad() {
        return cantidad;
    }

    public void setCantidad(int cantidad) {
        this.cantidad = cantidad;
    }

    public double getPrecioUnitario() {
        return precioUnitario;
    }

    public void setPrecioUnitario(double precioUnitario) {
        this.precioUnitario = precioUnitario;
    }
}
