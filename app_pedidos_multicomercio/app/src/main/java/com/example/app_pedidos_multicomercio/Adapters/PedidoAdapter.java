package com.example.app_pedidos_multicomercio.Adapters;

import android.content.Context;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.TextView;

import androidx.annotation.NonNull;
import androidx.recyclerview.widget.RecyclerView;

import com.example.app_pedidos_multicomercio.Models.Detalle;
import com.example.app_pedidos_multicomercio.Models.Pedido;

import com.example.app_pedidos_multicomercio.R;

import java.util.List;

// lista los pedidos del cliente
public class PedidoAdapter extends RecyclerView.Adapter<PedidoAdapter.PedidoVH> {

    private final Context context;
    private final List<Pedido> data;

    public PedidoAdapter(Context context, List<Pedido> data) {
        this.context = context;
        this.data = data;
    }

    @NonNull
    @Override
    public PedidoVH onCreateViewHolder(@NonNull ViewGroup parent, int viewType) {
        View v = LayoutInflater.from(parent.getContext()).inflate(R.layout.item_pedido, parent, false);
        return new PedidoVH(v);
    }

    @Override
    public void onBindViewHolder(@NonNull PedidoVH h, int position) {
        Pedido p = data.get(position);

        h.txtNombreComercio.setText(p.getNombreEmpresa());
        h.txtTotal.setText(String.format("$%.2f", p.getTotal()));
        h.txtEstado.setText(etiquetaEstado(p));
        h.txtProductos.setText(resumenProductos(p));
        h.txtFecha.setText(p.getCreatedAt() != null && p.getCreatedAt().length() >= 10
                ? p.getCreatedAt().substring(0, 10) : "");
    }

    @Override
    public int getItemCount() {
        return data.size();
    }

    private String etiquetaEstado(Pedido p) {
        // si aún está pendiente de pago, eso manda; si no, el estado de entrega
        if (!"pagado".equalsIgnoreCase(p.getEstadoPago())) {
            return "Pago pendiente";
        }
        return p.getEstadoEntrega() != null ? p.getEstadoEntrega().replace('_', ' ') : "";
    }

    private String resumenProductos(Pedido p) {
        if (p.getDetalles() == null || p.getDetalles().isEmpty()) return "";
        StringBuilder sb = new StringBuilder();
        for (Detalle d : p.getDetalles()) {
            if (sb.length() > 0) sb.append(", ");
            sb.append(d.getCantidad()).append("x ").append(d.getNombreProducto());
        }
        return sb.toString();
    }

    public static class PedidoVH extends RecyclerView.ViewHolder {
        TextView txtNombreComercio, txtTotal, txtEstado, txtProductos, txtFecha;

        public PedidoVH(@NonNull View itemView) {
            super(itemView);
            txtNombreComercio = itemView.findViewById(R.id.txtNombreComercio);
            txtTotal = itemView.findViewById(R.id.txtTotal);
            txtEstado = itemView.findViewById(R.id.txtEstado);
            txtProductos = itemView.findViewById(R.id.txtProductos);
            txtFecha = itemView.findViewById(R.id.txtFecha);
        }
    }
}
