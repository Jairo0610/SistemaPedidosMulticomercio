package com.example.app_pedidos_multicomercio;

import android.os.Bundle;

import androidx.fragment.app.Fragment;
import androidx.recyclerview.widget.LinearLayoutManager;
import androidx.recyclerview.widget.RecyclerView;

import android.util.Log;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;

import com.example.app_pedidos_multicomercio.Adapters.EmpresaAdapter;
import com.example.app_pedidos_multicomercio.Client.ApiClient;
import com.example.app_pedidos_multicomercio.Models.Categoria;
import com.example.app_pedidos_multicomercio.Models.Empresa;
import com.example.app_pedidos_multicomercio.Service.ApiService;

import java.util.List;

import retrofit2.Call;
import retrofit2.Callback;
import retrofit2.Response;

public class InicioFragment extends Fragment {
    private RecyclerView rvEmpresas;
    private EmpresaAdapter empresaAdapter;
    private ApiService apiService;

    private List<Empresa> dataEmpresa;
    private  List<Categoria> dataCategoria;

    public InicioFragment() {
        // Required empty public constructor
    }
    public static InicioFragment newInstance(String param1, String param2) {
        InicioFragment fragment = new InicioFragment();
        Bundle args = new Bundle();
        fragment.setArguments(args);
        return fragment;
    }

    @Override
    public void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
    }

    @Override
    public View onCreateView(LayoutInflater inflater, ViewGroup container,
                             Bundle savedInstanceState) {

        View view = inflater.inflate(R.layout.fragment_inicio, container, false);

        rvEmpresas = view.findViewById(R.id.rvEmpresas);
        rvEmpresas.setLayoutManager(new LinearLayoutManager(requireActivity()));

        cargarDatosEmpresa();

        // Inflate the layout for this fragment
        return view;
    }
    public void cargarDatosEmpresa(){
        ApiClient.getApiService().getEmpresas().enqueue(new Callback<List<Empresa>>() {
            @Override
            public void onResponse(Call<List<Empresa>> call, Response<List<Empresa>> response) {
                if (!isAdded()) return;
                if (response.isSuccessful() && response.body() != null) {
                    dataEmpresa = response.body();
                    Log.i("Empresa", "" + dataEmpresa.size());

                    ApiClient.getApiService().getCategorias().enqueue(new Callback<List<Categoria>>() {
                        @Override
                        public void onResponse(Call<List<Categoria>> call, Response<List<Categoria>> response) {
                            if (!isAdded()) return;
                            if (response.isSuccessful() && response.body() != null) {
                                dataCategoria = response.body();
                                Log.i("Categoria", "" + dataCategoria.size());
                                empresaAdapter = new EmpresaAdapter(requireActivity(), dataEmpresa, dataCategoria);
                                rvEmpresas.setAdapter(empresaAdapter);
                            }
                        }
                        @Override
                        public void onFailure(Call<List<Categoria>> call, Throwable throwable) {
                            Log.e("Categoria", "Error al cargar", throwable);
                        }
                    });
                }
            }
            @Override
            public void onFailure(Call<List<Empresa>> call, Throwable throwable) {
                Log.e("Empresa", "Error al cargar", throwable);
            }
        });
    }
}