package com.example.app_pedidos_multicomercio;

import android.os.Bundle;

import androidx.annotation.NonNull;
import androidx.fragment.app.Fragment;
import androidx.recyclerview.widget.LinearLayoutManager;
import androidx.recyclerview.widget.RecyclerView;

import android.util.Log;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.TextView;

import com.example.app_pedidos_multicomercio.Adapters.PedidoAdapter;
import com.example.app_pedidos_multicomercio.Client.ApiClient;
import com.example.app_pedidos_multicomercio.Models.Pedido;

import java.util.List;

import retrofit2.Call;
import retrofit2.Callback;
import retrofit2.Response;

/* historial de pedidos del cliente */
public class PedidosFragment extends Fragment {

    private RecyclerView rvPedidos;
    private TextView txtCantidadPedidos;

    public PedidosFragment() { }

    @Override
    public View onCreateView(LayoutInflater inflater, ViewGroup container, Bundle savedInstanceState) {
        View view = inflater.inflate(R.layout.fragment_pedidos, container, false);

        rvPedidos = view.findViewById(R.id.rvPedidos);
        txtCantidadPedidos = view.findViewById(R.id.txtCantidadPedidos);
        rvPedidos.setLayoutManager(new LinearLayoutManager(requireActivity()));

        cargarPedidos();
        return view;
    }

    private void cargarPedidos() {
        ApiClient.getApiService().getPedidos().enqueue(new Callback<List<Pedido>>() {
            @Override
            public void onResponse(@NonNull Call<List<Pedido>> call, @NonNull Response<List<Pedido>> response) {
                if (!isAdded()) return;
                if (response.isSuccessful() && response.body() != null) {
                    List<Pedido> pedidos = response.body();
                    rvPedidos.setAdapter(new PedidoAdapter(requireActivity(), pedidos));
                    txtCantidadPedidos.setText(pedidos.size()
                            + (pedidos.size() == 1 ? " pedido realizado" : " pedidos realizados"));
                } else {
                    Log.e("Pedidos", "Respuesta no exitosa: " + response.code());
                }
            }

            @Override
            public void onFailure(@NonNull Call<List<Pedido>> call, @NonNull Throwable t) {
                Log.e("Pedidos", "Error al cargar", t);
            }
        });
    }
}
