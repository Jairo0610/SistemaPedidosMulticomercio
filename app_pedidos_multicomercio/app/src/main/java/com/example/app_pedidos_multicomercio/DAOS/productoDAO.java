package com.example.app_pedidos_multicomercio.DAOS;

import androidx.room.Dao;
import androidx.room.Insert;
import androidx.room.Query;
import androidx.room.Update;

import com.example.app_pedidos_multicomercio.Entitys.ProductoEntity;

import java.util.List;

@Dao
public interface productoDAO {
    @Query("SELECT * FROM productos")
    List<ProductoEntity> getAllProductos();

    @Insert
    long insertProducto(ProductoEntity producto);

    @Update
    int updateProducto(ProductoEntity producto);

    @Query("DELETE FROM productos WHERE idProducto=:idProducto")
    int deleteProducto(int idProducto);

}
