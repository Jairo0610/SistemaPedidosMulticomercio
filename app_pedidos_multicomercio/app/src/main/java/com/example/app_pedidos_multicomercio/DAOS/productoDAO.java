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

    @Query("SELECT * FROM productos WHERE idProducto=:idProducto")
    ProductoEntity getProductoById(int idProducto);

    @Query("SELECT COUNT(*) FROM productos")
    int contarProductos();

    // total de unidades en el carrito (suma de cantidades); null si está vacío
    @Query("SELECT SUM(cantidad) FROM productos")
    Integer sumarCantidades();

    // empresa del carrito (todos los items son de la misma); null si está vacío.
    @Query("SELECT empresaId FROM productos LIMIT 1")
    Integer getEmpresaEnCarrito();

    @Insert
    long insertProducto(ProductoEntity producto);

    @Update
    int updateProducto(ProductoEntity producto);

    @Query("DELETE FROM productos WHERE idProducto=:idProducto")
    int deleteProducto(int idProducto);

    @Query("DELETE FROM productos")
    int vaciarCarrito();
}
