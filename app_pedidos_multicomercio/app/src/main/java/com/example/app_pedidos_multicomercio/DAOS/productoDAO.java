package com.example.app_pedidos_multicomercio.DAOS;

import androidx.room.Dao;
import androidx.room.Insert;
import androidx.room.Query;
import androidx.room.Update;

import com.example.app_pedidos_multicomercio.Entitys.Producto;

import java.util.List;

@Dao
public interface productoDAO {
    @Query("SELECT * FROM productos")
    List<Producto> getAllProductos();

    @Insert
    long insertProducto(Producto producto);

    @Update
    int updateProducto(Producto producto);

    @Query("DELETE FROM productos WHERE idProducto=:idProducto")
    int deleteProducto(int idProducto);

}
