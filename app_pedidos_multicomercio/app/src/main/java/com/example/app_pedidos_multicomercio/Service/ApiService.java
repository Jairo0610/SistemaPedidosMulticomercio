package com.example.app_pedidos_multicomercio.Service;

import com.example.app_pedidos_multicomercio.Models.Categoria;
import com.example.app_pedidos_multicomercio.Models.Empresa;
import com.example.app_pedidos_multicomercio.Models.Producto;

import java.util.List;

import retrofit2.Call;
import retrofit2.http.GET;
import retrofit2.http.Path;

public interface ApiService {
    @GET("categorias")
    Call<List<Categoria>> getCategorias();

    @GET("empresas")
    Call<List<Empresa>> getEmpresas();

    @GET("empresas/{id}")
    Call<Empresa> getEmpresa(@Path("id") int id);

    @GET("empresas/{id}/productos")
    Call<List<Producto>> getProductosDeEmpresa(@Path("id") int id);

    @GET("productos")
    Call<List<Producto>> getProductos();

    @GET("productos/{id}")
    Call<Producto> getProducto(@Path("id") int id);
}
