package com.example.app_pedidos_multicomercio.Service;

import com.example.app_pedidos_multicomercio.Models.AuthRequest;
import com.example.app_pedidos_multicomercio.Models.AuthResponse;
import com.example.app_pedidos_multicomercio.Models.Categoria;
import com.example.app_pedidos_multicomercio.Models.CrearPedidoResponse;
import com.example.app_pedidos_multicomercio.Models.Direccion;
import com.example.app_pedidos_multicomercio.Models.DireccionRequest;
import com.example.app_pedidos_multicomercio.Models.DispositivoRequest;
import com.example.app_pedidos_multicomercio.Models.Empresa;
import com.example.app_pedidos_multicomercio.Models.Pedido;
import com.example.app_pedidos_multicomercio.Models.PedidoRequest;
import com.example.app_pedidos_multicomercio.Models.Producto;

import java.util.List;

import retrofit2.Call;
import retrofit2.http.Body;
import retrofit2.http.GET;
import retrofit2.http.POST;
import retrofit2.http.Path;

public interface ApiService {
    // catálogo (público)
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

    // autenticación
    @POST("auth/firebase")
    Call<AuthResponse> authFirebase(@Body AuthRequest body);

    // direcciones (requieren token)
    @GET("direcciones")
    Call<List<Direccion>> getDirecciones();

    @POST("direcciones")
    Call<Direccion> crearDireccion(@Body DireccionRequest body);

    // pedidos (requieren token)
    @GET("pedidos")
    Call<List<Pedido>> getPedidos();

    @POST("pedidos")
    Call<CrearPedidoResponse> crearPedido(@Body PedidoRequest body);

    @POST("pedidos/{id}/confirmar-pago")
    Call<Pedido> confirmarPago(@Path("id") int id);

    // notificaciones push (requiere token)
    @POST("dispositivos")
    Call<Void> registrarDispositivo(@Body DispositivoRequest body);
}
