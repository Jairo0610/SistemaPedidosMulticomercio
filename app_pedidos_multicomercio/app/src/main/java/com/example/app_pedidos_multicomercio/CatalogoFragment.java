package com.example.app_pedidos_multicomercio;

import android.content.Intent;
import android.os.Bundle;

import androidx.fragment.app.Fragment;
import androidx.recyclerview.widget.LinearLayoutManager;
import androidx.recyclerview.widget.RecyclerView;

import android.util.Log;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.ImageView;
import android.widget.TextView;

import com.bumptech.glide.Glide;
import com.example.app_pedidos_multicomercio.Adapters.CatalogoAdapter;
import com.example.app_pedidos_multicomercio.Client.ApiClient;
import com.example.app_pedidos_multicomercio.DataBase.AppDataBase;
import com.example.app_pedidos_multicomercio.Models.Categoria;
import com.example.app_pedidos_multicomercio.Models.Empresa;
import com.example.app_pedidos_multicomercio.Models.Producto;
import com.example.app_pedidos_multicomercio.Models.SubCategoria;
import com.google.android.material.badge.BadgeDrawable;
import com.google.android.material.badge.BadgeUtils;
import com.google.android.material.floatingactionbutton.FloatingActionButton;

import java.util.List;

import retrofit2.Call;
import retrofit2.Callback;
import retrofit2.Response;

public class CatalogoFragment extends Fragment {

    private TextView txtNombreEmpresa, txtCategoria;
    private ImageView imgLogoEmpresa;
    private RecyclerView rvProducto;
    private CatalogoAdapter catalogoAdapter;
    private FloatingActionButton btnCarrito;
    private BadgeDrawable badgeCarrito;

    private List<Producto> dataProducto;
    private List<SubCategoria> dataSubCategoria;
    private int idEmpresa;

    public CatalogoFragment() {
        // Required empty public constructor
    }

    public static CatalogoFragment newInstance(String param1, String param2) {
        CatalogoFragment fragment = new CatalogoFragment();
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
        // Inflate the layout for this fragment
        View view = inflater.inflate(R.layout.fragment_catalogo, container, false);

        txtNombreEmpresa = view.findViewById(R.id.txtNombreEmpresa);
        txtCategoria = view.findViewById(R.id.txtCategoriaEmpresa);
        rvProducto = view.findViewById(R.id.rvProductos);
        rvProducto.setLayoutManager(new LinearLayoutManager(requireActivity()));

        imgLogoEmpresa = view.findViewById(R.id.imgLogoEmpresa);

        // botón de arriba: regresa a la vista de inicio (cierra la pantalla del comercio)
        view.findViewById(R.id.btnVolver).setOnClickListener(v -> requireActivity().finish());

        // FAB del carrito: lleva al carrito y muestra un badge con las unidades
        btnCarrito = view.findViewById(R.id.btnCarritoCatalogo);
        btnCarrito.setOnClickListener(v -> irAlCarrito());

        badgeCarrito = BadgeDrawable.create(requireContext());
        btnCarrito.post(() -> BadgeUtils.attachBadgeDrawable(badgeCarrito, btnCarrito));

        idEmpresa = requireActivity().getIntent().getIntExtra("idEmpresa", 0);

        cargarDatosEmpresa();

        cargarProductos();

        return view;
    }

    @Override
    public void onResume() {
        super.onResume();
        // al volver del detalle, refrescar el contador del carrito
        actualizarBadgeCarrito();
    }

    @Override
    public void onDestroyView() {
        if (badgeCarrito != null && btnCarrito != null) {
            BadgeUtils.detachBadgeDrawable(badgeCarrito, btnCarrito);
        }
        super.onDestroyView();
    }

    private void actualizarBadgeCarrito() {
        AppDataBase.databaseWriteExecutor.execute(() -> {
            Integer total = AppDataBase.getInstance(requireContext()).producto_dao().sumarCantidades();
            int unidades = total == null ? 0 : total;
            if (!isAdded()) return;
            requireActivity().runOnUiThread(() -> {
                if (badgeCarrito == null) return;
                badgeCarrito.setVisible(unidades > 0);
                badgeCarrito.setNumber(unidades);
            });
        });
    }

    // vuelve a la sesión y selecciona la pestaña del carrito
    private void irAlCarrito() {
        Intent intent = new Intent(requireActivity(), SessionActivity.class);
        intent.putExtra("abrir", "carrito");
        intent.addFlags(Intent.FLAG_ACTIVITY_CLEAR_TOP | Intent.FLAG_ACTIVITY_SINGLE_TOP);
        startActivity(intent);
    }
    private void cargarDatosEmpresa(){
        ApiClient.getApiService().getEmpresa(idEmpresa).enqueue(new Callback<Empresa>() {
            @Override
            public void onResponse(Call<Empresa> call, Response<Empresa> response) {
                if (response.isSuccessful() && response.body() != null){

                    Empresa empresa = response.body();
                    txtNombreEmpresa.setText(empresa.getNombre());

                    Glide.with(requireActivity())
                            .load(empresa.getLogoUrl())
                            .circleCrop()
                            .placeholder(R.drawable.tienda)
                            .into(imgLogoEmpresa);

                    ApiClient.getApiService().getCategorias().enqueue(new Callback<List<Categoria>>() {
                        @Override
                        public void onResponse(Call<List<Categoria>> call, Response<List<Categoria>> response) {
                            if (response.isSuccessful() && response.body() != null){
                                List<Categoria> listaCategoria = response.body();

                                for (Categoria item:
                                        listaCategoria) {
                                    if (item.getId() == empresa.getCategoriaId()){
                                        txtCategoria.setText(item.getNombre());
                                        break;
                                    }
                                }
                            }
                        }

                        @Override
                        public void onFailure(Call<List<Categoria>> call, Throwable throwable) {

                        }
                    });


                }

            }

            @Override
            public void onFailure(Call<Empresa> call, Throwable throwable) {

            }
        });
    }
    private void cargarProductos(){
        ApiClient.getApiService().getProductosDeEmpresa(idEmpresa).enqueue(new Callback<List<Producto>>() {
            @Override
            public void onResponse(Call<List<Producto>> call, Response<List<Producto>> response) {
                if (response.isSuccessful() && response.body() != null){
                    dataProducto = response.body();

                    ApiClient.getApiService().getSubCategorias().enqueue(new Callback<List<SubCategoria>>() {
                        @Override
                        public void onResponse(Call<List<SubCategoria>> call, Response<List<SubCategoria>> response) {
                            if (response.isSuccessful() && response.body() != null){
                                dataSubCategoria = response.body();

                                catalogoAdapter = new CatalogoAdapter(requireActivity(), dataProducto, dataSubCategoria);

                                requireView().findViewById(R.id.progressProductos).setVisibility(View.GONE);
                                rvProducto.setVisibility(View.VISIBLE);
                                rvProducto.setAdapter(catalogoAdapter);
                            }
                        }

                        @Override
                        public void onFailure(Call<List<SubCategoria>> call, Throwable throwable) {
                            Log.e("Catalogo", "Error: " + throwable.getMessage());
                        }
                    });

                }
            }

            @Override
            public void onFailure(Call<List<Producto>> call, Throwable throwable) {

            }
        });
    }
}