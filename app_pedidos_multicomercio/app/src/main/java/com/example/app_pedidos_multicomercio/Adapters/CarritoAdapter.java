package com.example.app_pedidos_multicomercio.Adapters;

import android.content.Context;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.ImageButton;
import android.widget.ImageView;
import android.widget.TextView;

import androidx.annotation.NonNull;
import androidx.recyclerview.widget.RecyclerView;

import com.bumptech.glide.Glide;
import com.example.app_pedidos_multicomercio.DAOS.productoDAO;
import com.example.app_pedidos_multicomercio.DataBase.AppDataBase;
import com.example.app_pedidos_multicomercio.Entitys.ProductoEntity;
import com.example.app_pedidos_multicomercio.R;

import java.util.List;

/*
 * muestra los items del carrito con selector de cantidad y botón eliminar,
 * cada cambio se persiste en Room y avisa al fragment para recalcular el total
 */
public class CarritoAdapter extends RecyclerView.Adapter<CarritoAdapter.CarritoVH> {

    // el fragment implementa esto para refrescar el total cuando algo cambia
    public interface OnCarritoCambiado {
        void alCambiar();
    }

    private final Context context;
    private final List<ProductoEntity> items;
    private final productoDAO dao;
    private final OnCarritoCambiado listener;

    public CarritoAdapter(Context context, List<ProductoEntity> items, OnCarritoCambiado listener) {
        this.context = context;
        this.items = items;
        this.listener = listener;
        this.dao = AppDataBase.getInstance(context).producto_dao();
    }

    @NonNull
    @Override
    public CarritoVH onCreateViewHolder(@NonNull ViewGroup parent, int viewType) {
        View v = LayoutInflater.from(parent.getContext()).inflate(R.layout.item_carrito, parent, false);
        return new CarritoVH(v);
    }

    @Override
    public void onBindViewHolder(@NonNull CarritoVH h, int position) {
        ProductoEntity item = items.get(position);

        h.txtNombre.setText(item.getNombreProducto());
        h.txtPrecio.setText(String.format("$%.2f", item.getPrecioUnitario()));
        h.txtCantidad.setText(String.valueOf(item.getCantidad()));
        Glide.with(context)
                .load(item.getImgURL())
                .placeholder(R.drawable.tienda)
                .into(h.imgProducto);

        h.btnSumar.setOnClickListener(v -> cambiarCantidad(item, +1));
        h.btnRestar.setOnClickListener(v -> cambiarCantidad(item, -1));
        h.btnEliminar.setOnClickListener(v -> eliminar(item));
    }

    @Override
    public int getItemCount() {
        return items.size();
    }

    private void cambiarCantidad(ProductoEntity item, int delta) {
        int nueva = item.getCantidad() + delta;
        if (nueva < 1) {
            eliminar(item);
            return;
        }
        item.setCantidad(nueva);
        AppDataBase.databaseWriteExecutor.execute(() -> dao.updateProducto(item));
        notifyItemChanged(items.indexOf(item));
        listener.alCambiar();
    }

    private void eliminar(ProductoEntity item) {
        int pos = items.indexOf(item);
        if (pos < 0) return;
        items.remove(pos);
        AppDataBase.databaseWriteExecutor.execute(() -> dao.deleteProducto(item.getIdProducto()));
        notifyItemRemoved(pos);
        listener.alCambiar();
    }

    public static class CarritoVH extends RecyclerView.ViewHolder {
        ImageView imgProducto;
        TextView txtNombre, txtPrecio, txtCantidad;
        ImageButton btnSumar, btnRestar, btnEliminar;

        public CarritoVH(@NonNull View itemView) {
            super(itemView);
            imgProducto = itemView.findViewById(R.id.imgProductoCarrito);
            txtNombre = itemView.findViewById(R.id.txtNombreProductoCarrito);
            txtPrecio = itemView.findViewById(R.id.txtPrecioProductoCarrito);
            txtCantidad = itemView.findViewById(R.id.txtCantidadCarrito);
            btnSumar = itemView.findViewById(R.id.btnSumarCantidad);
            btnRestar = itemView.findViewById(R.id.btnRestarCantidad);
            btnEliminar = itemView.findViewById(R.id.btnEliminarItemCarrito);
        }
    }
}
