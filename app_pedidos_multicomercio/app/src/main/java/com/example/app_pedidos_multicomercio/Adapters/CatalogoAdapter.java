package com.example.app_pedidos_multicomercio.Adapters;

import android.content.Context;
import android.content.Intent;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.ImageView;
import android.widget.TextView;

import androidx.annotation.NonNull;
import androidx.recyclerview.widget.RecyclerView;

import com.bumptech.glide.Glide;
import com.example.app_pedidos_multicomercio.DetalleProductoActivity;
import com.example.app_pedidos_multicomercio.Models.Producto;
import com.example.app_pedidos_multicomercio.Models.SubCategoria;
import com.example.app_pedidos_multicomercio.R;
import com.google.android.material.floatingactionbutton.FloatingActionButton;

import java.util.List;

public class CatalogoAdapter extends RecyclerView.Adapter<CatalogoAdapter.CatalogoVH> {


    private final Context context;
    private final List<Producto>dataProducto;
    private final List<SubCategoria> dataSubCategoria;

    public CatalogoAdapter(Context context, List<Producto> dataProducto, List<SubCategoria> dataSubCategoria) {
        this.context = context;
        this.dataProducto = dataProducto;
        this.dataSubCategoria = dataSubCategoria;
    }

    @NonNull
    @Override
    public CatalogoVH onCreateViewHolder(@NonNull ViewGroup parent, int viewType) {
        View view = LayoutInflater.from(parent.getContext())
                .inflate(R.layout.item_producto_catalogo, parent, false);
        return new CatalogoVH(view);
    }

    @Override
    public void onBindViewHolder(@NonNull CatalogoVH holder, int position) {
        Producto producto = dataProducto.get(position);

        holder.txtNombreProducto.setText(producto.getNombre());
        holder.txtDescripcion.setText(producto.getDescripcion());
        holder.txtPrecio.setText(String.format("$%.2f", producto.getPrecio()));


        if (dataSubCategoria != null) {
            for (SubCategoria item : dataSubCategoria) {
                if (item.getId() == producto.getSubcategoriaId()) {
                    holder.txtCategoria.setText(item.getNombre());
                    break;
                }
            }
        }

        Glide.with(context)
                .load(producto.getImagenUrl())
                .placeholder(R.drawable.image_not_found)
                .into(holder.imgProducto);


        holder.btnVerProducto.setOnClickListener(v -> {
            Intent intent = new Intent(context, DetalleProductoActivity.class);
            intent.putExtra("idProducto", producto.getId());
            context.startActivity(intent);
        });
    }

    @Override
    public int getItemCount() {
        return dataProducto != null ? dataProducto.size() : 0;
    }

    public static class CatalogoVH extends RecyclerView.ViewHolder {
        public FloatingActionButton btnVerProducto;
        public ImageView imgProducto;
        public TextView txtNombreProducto, txtCategoria, txtDescripcion, txtPrecio;

        public CatalogoVH(@NonNull View itemView) {
            super(itemView);
            imgProducto = itemView.findViewById(R.id.imgProductoCatalogo);
            txtNombreProducto = itemView.findViewById(R.id.txtNombreProductoCatalogo);
            txtCategoria = itemView.findViewById(R.id.txtCategoriaProductoCatalogo);
            txtDescripcion = itemView.findViewById(R.id.txtDescripcionProducto);
            txtPrecio = itemView.findViewById(R.id.txtPrecioProductoCatalogo);
            btnVerProducto = itemView.findViewById(R.id.btnVerProductoCatalogo);
        }
    }
}