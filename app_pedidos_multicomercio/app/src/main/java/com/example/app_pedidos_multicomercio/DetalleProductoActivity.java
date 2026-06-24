package com.example.app_pedidos_multicomercio;

import android.os.Bundle;
import android.util.Log;
import android.widget.Button;
import android.widget.ImageView;
import android.widget.TextView;

import androidx.activity.EdgeToEdge;
import androidx.appcompat.app.AppCompatActivity;
import androidx.core.graphics.Insets;
import androidx.core.view.ViewCompat;
import androidx.core.view.WindowInsetsCompat;

import com.bumptech.glide.Glide;
import com.example.app_pedidos_multicomercio.Client.ApiClient;
import com.example.app_pedidos_multicomercio.Models.Producto;
import com.example.app_pedidos_multicomercio.Models.SubCategoria;
import com.google.android.material.floatingactionbutton.FloatingActionButton;

import retrofit2.Call;
import retrofit2.Callback;
import retrofit2.Response;

public class DetalleProductoActivity extends AppCompatActivity {
    private TextView txtNombre, txtDescripcion, txtCantidad, txtCategoria, txtPrecio, txtTotal;
    private FloatingActionButton btnVolver;
    private Button btnSumar, btnRestar, btnAgregarAlCarrito;
    private ImageView imgProducto;
    private int cantidad = 1;
    private double precio = 0.0 , totalPrecio = 0.0;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        EdgeToEdge.enable(this);
        setContentView(R.layout.activity_detalle_producto);
        ViewCompat.setOnApplyWindowInsetsListener(findViewById(R.id.main), (v, insets) -> {
            Insets systemBars = insets.getInsets(WindowInsetsCompat.Type.systemBars());
            v.setPadding(systemBars.left, systemBars.top, systemBars.right, systemBars.bottom);
            return insets;
        });

        int idProducto = getIntent().getIntExtra("idProducto", 0);
        Log.d("DetalleProducto", "idProducto recibido: " + idProducto);

        txtNombre = findViewById(R.id.txtNombreDetalle);
        txtDescripcion = findViewById(R.id.txtDescripcionDetalle);
        txtCantidad = findViewById(R.id.txtCantidadDetalle);
        txtCategoria = findViewById(R.id.txtSubCategoriaDetalle);
        txtPrecio = findViewById(R.id.txtPrecioDetalle);
        txtTotal = findViewById(R.id.txtTotalDetalle);

        btnVolver = findViewById(R.id.btnVolverDetalle);
        btnSumar = findViewById(R.id.btnSumar);
        btnRestar = findViewById(R.id.btnRestar);
        btnAgregarAlCarrito = findViewById(R.id.btnAgregarAlCarrito);

        imgProducto = findViewById(R.id.imgProductoDetalle);

        txtCantidad.setText(String.valueOf(cantidad));

        btnVolver.setOnClickListener(v -> finish());

        btnSumar.setOnClickListener(v -> {
            cantidad++;
            txtCantidad.setText(String.valueOf(cantidad));
            totalPrecio = precio * Double.parseDouble(txtCantidad.getText().toString());
            txtTotal.setText(String.format("$%.2f", totalPrecio));
        });
        btnRestar.setOnClickListener(v -> {
            if (cantidad > 1){
                cantidad--;
                txtCantidad.setText(String.valueOf(cantidad));
                totalPrecio = precio * Double.parseDouble(txtCantidad.getText().toString());
                txtTotal.setText(String.format("$%.2f", totalPrecio));
            }
        });


        btnAgregarAlCarrito.setOnClickListener(v -> {
            //Logica para agregar carrito
        });

        cargarDatos();
    }

    public void cargarDatos(){
        int idProducto = getIntent().getIntExtra("idProducto", 0);
        ApiClient.getApiService().getProducto(idProducto).enqueue(new Callback<Producto>() {
            @Override
            public void onResponse(Call<Producto> call, Response<Producto> response) {
                if (response.isSuccessful() && response.body() != null){
                    Producto producto = response.body();

                    ApiClient.getApiService().getSubCategoria(producto.getSubcategoriaId()).enqueue(new Callback<SubCategoria>() {
                        @Override
                        public void onResponse(Call<SubCategoria> call, Response<SubCategoria> response) {
                            if (response.isSuccessful() && response.body() != null){
                                SubCategoria subCategoria = response.body();

                                txtNombre.setText(producto.getNombre());
                                txtDescripcion.setText(producto.getDescripcion());
                                txtCategoria.setText((subCategoria.getNombre()));
                                precio = producto.getPrecio();
                                txtPrecio.setText(String.format("$%.2f", precio));
                                totalPrecio = producto.getPrecio();
                                txtTotal.setText(String.format("$%.2f", totalPrecio));

                                Glide.with(DetalleProductoActivity.this)
                                        .load(producto.getImagenUrl())
                                        .placeholder(R.drawable.image_not_found)
                                        .into(imgProducto);
                            }
                        }

                        @Override
                        public void onFailure(Call<SubCategoria> call, Throwable throwable) {
                            Log.e("DetalleProducto", "Error subcat: " + throwable.getMessage());
                        }
                    });
                }
            }

            @Override
            public void onFailure(Call<Producto> call, Throwable throwable) {
                Log.e("DetalleProducto", "Error producto: " + throwable.getMessage());
            }
        });
    }
}