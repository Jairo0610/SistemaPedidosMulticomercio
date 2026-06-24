package com.example.app_pedidos_multicomercio;

import android.os.Bundle;

import androidx.annotation.NonNull;
import androidx.appcompat.app.AlertDialog;
import androidx.fragment.app.Fragment;
import androidx.recyclerview.widget.LinearLayoutManager;
import androidx.recyclerview.widget.RecyclerView;

import android.text.InputType;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.ArrayAdapter;
import android.widget.Button;
import android.widget.EditText;
import android.widget.LinearLayout;
import android.widget.Spinner;
import android.widget.TextView;
import android.widget.Toast;

import com.example.app_pedidos_multicomercio.Adapters.CarritoAdapter;
import com.example.app_pedidos_multicomercio.Client.ApiClient;
import com.example.app_pedidos_multicomercio.DAOS.productoDAO;
import com.example.app_pedidos_multicomercio.DataBase.AppDataBase;
import com.example.app_pedidos_multicomercio.Entitys.ProductoEntity;
import com.example.app_pedidos_multicomercio.Models.CrearPedidoResponse;
import com.example.app_pedidos_multicomercio.Models.Direccion;
import com.example.app_pedidos_multicomercio.Models.DireccionRequest;
import com.example.app_pedidos_multicomercio.Models.ItemPedido;
import com.example.app_pedidos_multicomercio.Models.Pedido;
import com.example.app_pedidos_multicomercio.Models.PedidoRequest;
import com.stripe.android.paymentsheet.PaymentSheet;
import com.stripe.android.paymentsheet.PaymentSheetResult;

import java.util.ArrayList;
import java.util.List;

import retrofit2.Call;
import retrofit2.Callback;
import retrofit2.Response;

/*
 * carrito y checkout, lista los items (Room), elige una dirección, paga con tarjeta
 * (Stripe PaymentSheet) y crea el pedido en el backend
 */
public class CarritoFragment extends Fragment implements CarritoAdapter.OnCarritoCambiado {

    private RecyclerView recyclerCarrito;
    private Spinner spinnerDirecciones;
    private TextView btnAgregarDireccion, txtSubtotal, txtCostoEnvio, txtTotal, txtSubtitulo;
    private Button btnConfirmarPedido;

    private productoDAO dao;
    private CarritoAdapter adapter;
    private final List<ProductoEntity> carrito = new ArrayList<>();
    private List<Direccion> direcciones = new ArrayList<>();

    private PaymentSheet paymentSheet;
    // datos del pago en curso: el pedido aún no existe hasta que Stripe apruebe
    private PedidoRequest pedidoPendiente;
    private String paymentIntentId;

    public CarritoFragment() { }

    @Override
    public void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        // paymentSheet debe crearse durante la inicialización del fragment
        paymentSheet = new PaymentSheet(this, this::onResultadoPago);
    }

    @Override
    public View onCreateView(LayoutInflater inflater, ViewGroup container, Bundle savedInstanceState) {
        View view = inflater.inflate(R.layout.fragment_carrito, container, false);

        recyclerCarrito = view.findViewById(R.id.recyclerCarrito);
        spinnerDirecciones = view.findViewById(R.id.spinnerDirecciones);
        btnAgregarDireccion = view.findViewById(R.id.btnAgregarDireccion);
        txtSubtotal = view.findViewById(R.id.txtSubtotal);
        txtCostoEnvio = view.findViewById(R.id.txtCostoEnvio);
        txtTotal = view.findViewById(R.id.txtTotal);
        txtSubtitulo = view.findViewById(R.id.txtSubtituloCarrito);
        btnConfirmarPedido = view.findViewById(R.id.btnConfirmarPedido);

        recyclerCarrito.setLayoutManager(new LinearLayoutManager(requireActivity()));
        dao = AppDataBase.getInstance(requireContext()).producto_dao();

        btnAgregarDireccion.setOnClickListener(v -> dialogoAgregarDireccion());
        btnConfirmarPedido.setOnClickListener(v -> confirmarPedido());

        cargarCarrito();
        cargarDirecciones();

        return view;
    }

    // carrito

    private void cargarCarrito() {
        AppDataBase.databaseWriteExecutor.execute(() -> {
            List<ProductoEntity> items = dao.getAllProductos();
            if (!isAdded()) return;
            requireActivity().runOnUiThread(() -> {
                carrito.clear();
                carrito.addAll(items);
                adapter = new CarritoAdapter(requireActivity(), carrito, this);
                recyclerCarrito.setAdapter(adapter);
                actualizarTotales();
            });
        });
    }

    /* llamado por el adapter cuando cambian cantidades o se elimina un item */
    @Override
    public void alCambiar() {
        actualizarTotales();
    }

    private void actualizarTotales() {
        double total = 0;
        int unidades = 0;
        for (ProductoEntity p : carrito) {
            total += p.getPrecioUnitario() * p.getCantidad();
            unidades += p.getCantidad();
        }
        txtSubtotal.setText(String.format("$%.2f", total));
        txtCostoEnvio.setText("$0.00");
        txtTotal.setText(String.format("$%.2f", total));
        txtSubtitulo.setText(unidades + (unidades == 1 ? " producto" : " productos"));
    }

    // direcciones

    private void cargarDirecciones() {
        ApiClient.getApiService().getDirecciones().enqueue(new Callback<List<Direccion>>() {
            @Override
            public void onResponse(@NonNull Call<List<Direccion>> call, @NonNull Response<List<Direccion>> response) {
                if (!isAdded()) return;
                if (response.isSuccessful() && response.body() != null) {
                    direcciones = response.body();
                    poblarSpinner();
                    if (direcciones.isEmpty()) {
                        Toast.makeText(getContext(), "Agrega una dirección de entrega", Toast.LENGTH_SHORT).show();
                    }
                } else {
                    Toast.makeText(getContext(), "No se pudieron cargar las direcciones (" + response.code() + ")", Toast.LENGTH_SHORT).show();
                }
            }

            @Override
            public void onFailure(@NonNull Call<List<Direccion>> call, @NonNull Throwable t) {
                if (isAdded()) Toast.makeText(getContext(), "Error de red al cargar direcciones", Toast.LENGTH_SHORT).show();
            }
        });
    }

    private void poblarSpinner() {
        ArrayAdapter<Direccion> ad = new ArrayAdapter<>(requireActivity(),
                android.R.layout.simple_spinner_item, direcciones);
        ad.setDropDownViewResource(android.R.layout.simple_spinner_dropdown_item);
        spinnerDirecciones.setAdapter(ad);

        // preseleccionar la predeterminada
        for (int i = 0; i < direcciones.size(); i++) {
            if (direcciones.get(i).isPredeterminada()) {
                spinnerDirecciones.setSelection(i);
                break;
            }
        }
    }

    private void dialogoAgregarDireccion() {
        LinearLayout layout = new LinearLayout(requireContext());
        layout.setOrientation(LinearLayout.VERTICAL);
        int pad = (int) (16 * getResources().getDisplayMetrics().density);
        layout.setPadding(pad, pad, pad, 0);

        EditText etNombre = new EditText(requireContext());
        etNombre.setHint("Nombre (ej. Casa, Trabajo)");
        EditText etDireccion = new EditText(requireContext());
        etDireccion.setHint("Dirección");
        etDireccion.setInputType(InputType.TYPE_TEXT_FLAG_MULTI_LINE);
        EditText etReferencia = new EditText(requireContext());
        etReferencia.setHint("Referencia (opcional)");

        layout.addView(etNombre);
        layout.addView(etDireccion);
        layout.addView(etReferencia);

        new AlertDialog.Builder(requireContext())
                .setTitle("Nueva dirección")
                .setView(layout)
                .setPositiveButton("Guardar", (d, w) -> {
                    String nombre = etNombre.getText().toString().trim();
                    String direccion = etDireccion.getText().toString().trim();
                    String referencia = etReferencia.getText().toString().trim();
                    if (nombre.isEmpty() || direccion.isEmpty()) {
                        Toast.makeText(getContext(), "Nombre y dirección son obligatorios", Toast.LENGTH_SHORT).show();
                        return;
                    }
                    // la primera dirección se marca predeterminada
                    boolean predeterminada = direcciones.isEmpty();
                    guardarDireccion(new DireccionRequest(nombre, direccion,
                            referencia.isEmpty() ? null : referencia, null, null, predeterminada));
                })
                .setNegativeButton("Cancelar", null)
                .show();
    }

    private void guardarDireccion(DireccionRequest req) {
        ApiClient.getApiService().crearDireccion(req).enqueue(new Callback<Direccion>() {
            @Override
            public void onResponse(@NonNull Call<Direccion> call, @NonNull Response<Direccion> response) {
                if (!isAdded()) return;
                if (response.isSuccessful()) {
                    Toast.makeText(getContext(), "Dirección agregada", Toast.LENGTH_SHORT).show();
                    cargarDirecciones();
                } else {
                    Toast.makeText(getContext(), "No se pudo guardar (" + response.code() + ")", Toast.LENGTH_SHORT).show();
                }
            }

            @Override
            public void onFailure(@NonNull Call<Direccion> call, @NonNull Throwable t) {
                if (isAdded()) Toast.makeText(getContext(), "Error de red al guardar dirección", Toast.LENGTH_SHORT).show();
            }
        });
    }

    // checkout y pago

    private void confirmarPedido() {
        if (carrito.isEmpty()) {
            Toast.makeText(getContext(), "Tu carrito está vacío", Toast.LENGTH_SHORT).show();
            return;
        }
        if (direcciones.isEmpty() || spinnerDirecciones.getSelectedItem() == null) {
            Toast.makeText(getContext(), "Elige o agrega una dirección de entrega", Toast.LENGTH_SHORT).show();
            return;
        }

        int empresaId = carrito.get(0).getEmpresaId();
        int direccionId = ((Direccion) spinnerDirecciones.getSelectedItem()).getId();

        List<ItemPedido> items = new ArrayList<>();
        for (ProductoEntity p : carrito) {
            items.add(new ItemPedido(p.getIdProducto(), p.getCantidad()));
        }

        // se guarda el pedido en curso para crearlo solo cuando el pago se apruebe
        pedidoPendiente = new PedidoRequest(empresaId, direccionId, items);

        btnConfirmarPedido.setEnabled(false);
        // paso 1: crear el PaymentIntent (todavía NO se crea el pedido)
        ApiClient.getApiService().iniciarPago(pedidoPendiente)
                .enqueue(new Callback<CrearPedidoResponse>() {
                    @Override
                    public void onResponse(@NonNull Call<CrearPedidoResponse> call, @NonNull Response<CrearPedidoResponse> response) {
                        if (!isAdded()) return;
                        btnConfirmarPedido.setEnabled(true);
                        if (response.isSuccessful() && response.body() != null) {
                            paymentIntentId = response.body().getPaymentIntentId();
                            presentarPago(response.body().getClientSecret());
                        } else {
                            Toast.makeText(getContext(), "No se pudo iniciar el pago (" + response.code() + ")", Toast.LENGTH_SHORT).show();
                        }
                    }

                    @Override
                    public void onFailure(@NonNull Call<CrearPedidoResponse> call, @NonNull Throwable t) {
                        if (!isAdded()) return;
                        btnConfirmarPedido.setEnabled(true);
                        Toast.makeText(getContext(), "Error de red al iniciar el pago", Toast.LENGTH_SHORT).show();
                    }
                });
    }

    private void presentarPago(String clientSecret) {
        PaymentSheet.Configuration config =
                new PaymentSheet.Configuration.Builder("Sistema Multicomercio").build();
        paymentSheet.presentWithPaymentIntent(clientSecret, config);
    }

    private void onResultadoPago(PaymentSheetResult result) {
        if (result instanceof PaymentSheetResult.Completed) {
            // paso 2: solo ahora (pago aprobado) se crea el pedido en el backend
            crearPedidoPagado();
        } else if (result instanceof PaymentSheetResult.Canceled) {
            Toast.makeText(getContext(), "Pago cancelado, no se creó el pedido", Toast.LENGTH_SHORT).show();
        } else if (result instanceof PaymentSheetResult.Failed) {
            Toast.makeText(getContext(), "El pago falló, no se creó el pedido", Toast.LENGTH_SHORT).show();
        }
    }

    /* crea el pedido en el backend; el backend reverifica el pago en Stripe antes de guardarlo */
    private void crearPedidoPagado() {
        if (pedidoPendiente == null || paymentIntentId == null) return;
        pedidoPendiente.setPaymentIntentId(paymentIntentId);

        ApiClient.getApiService().crearPedido(pedidoPendiente).enqueue(new Callback<Pedido>() {
            @Override
            public void onResponse(@NonNull Call<Pedido> call, @NonNull Response<Pedido> response) {
                if (!isAdded()) return;
                if (response.isSuccessful()) {
                    // vaciar el carrito local y navegar a mis pedidos
                    AppDataBase.databaseWriteExecutor.execute(() -> dao.vaciarCarrito());
                    Toast.makeText(getContext(), "¡Pedido realizado con éxito!", Toast.LENGTH_LONG).show();
                    irAPedidos();
                } else {
                    Toast.makeText(getContext(), "El pago se hizo pero no se pudo registrar el pedido (" + response.code() + ")", Toast.LENGTH_LONG).show();
                }
            }

            @Override
            public void onFailure(@NonNull Call<Pedido> call, @NonNull Throwable t) {
                if (isAdded()) Toast.makeText(getContext(), "Error de red al registrar el pedido", Toast.LENGTH_SHORT).show();
            }
        });
    }

    private void irAPedidos() {
        requireActivity().getSupportFragmentManager()
                .beginTransaction()
                .replace(R.id.sessionFrame, new PedidosFragment())
                .commit();
    }
}
