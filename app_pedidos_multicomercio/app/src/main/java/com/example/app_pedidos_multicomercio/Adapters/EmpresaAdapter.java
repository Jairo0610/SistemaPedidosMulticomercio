package com.example.app_pedidos_multicomercio.Adapters;

import android.content.Context;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.ImageView;
import android.widget.TextView;

import androidx.annotation.NonNull;
import androidx.recyclerview.widget.RecyclerView;

import com.bumptech.glide.Glide;
import com.bumptech.glide.load.resource.bitmap.RoundedCorners;
import com.example.app_pedidos_multicomercio.Models.Categoria;
import com.example.app_pedidos_multicomercio.Models.Empresa;
import com.example.app_pedidos_multicomercio.R;

import java.util.List;

public class EmpresaAdapter extends RecyclerView.Adapter<EmpresaAdapter.EmpresaVH> {

    public Context context;
    public List<Empresa> dataEmpresa;
    public List<Categoria> dataCategoria;
    public interface OnEmpresaClickListener {
        void onEmpresaClick(Empresa empresa);
    }

    private OnEmpresaClickListener listener;

    public EmpresaAdapter(Context context, List<Empresa> dataEmpresa, List<Categoria> dataCategoria, OnEmpresaClickListener listener) {
        this.context = context;
        this.dataEmpresa = dataEmpresa;
        this.dataCategoria = dataCategoria;
        this.listener = listener;
    }

    @NonNull
    @Override
    public EmpresaVH onCreateViewHolder(@NonNull ViewGroup parent, int viewType) {
        View view = LayoutInflater.from(parent.getContext()).inflate(R.layout.item_empresa, parent, false);
        return new EmpresaVH(view);
    }

    @Override
    public void onBindViewHolder(@NonNull EmpresaVH holder, int position) {
        Empresa empresa = dataEmpresa.get(position);


        Glide.with(context)
                .load(empresa.getLogoUrl())
                .placeholder(R.drawable.tienda)
                .into(holder.imgComercio);

        holder.idEmpresa = empresa.getId();
        holder.txtNombreComercio.setText(empresa.getNombre());

        if (dataCategoria != null) {
            for (Categoria item : dataCategoria) {
                if (item.getId() == empresa.getCategoriaId()) {
                    holder.txtCategoria.setText(item.getNombre());
                    break;
                }
            }
        }

        holder.itemView.setOnClickListener(v -> {
            if (listener != null) {
                listener.onEmpresaClick(empresa);
            }
        });

    }

    @Override
    public int getItemCount() {
        return dataEmpresa.size();
    }

    public class EmpresaVH extends RecyclerView.ViewHolder {
        public int idEmpresa;
        public ImageView imgComercio;
        public TextView txtNombreComercio, txtCategoria;
        public EmpresaVH(@NonNull View itemView) {
            super(itemView);
            imgComercio = itemView.findViewById(R.id.imgComercio);
            txtNombreComercio = itemView.findViewById(R.id.txtNombreComercio);
            txtCategoria = itemView.findViewById(R.id.txtCategoriaComercio);
        }
    }
}
