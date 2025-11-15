package com.example.umkmgo; // Ganti dengan nama paket Anda

import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.TextView;
import androidx.annotation.NonNull;
import androidx.recyclerview.widget.RecyclerView;
import java.util.List;
import java.util.Locale;

/**
 * Adapter untuk menampilkan daftar produk dalam RecyclerView.
 */
public class ProductAdapter extends RecyclerView.Adapter<ProductAdapter.ProductViewHolder> {
    private final List<Product> products;

    public ProductAdapter(List<Product> products) {
        this.products = products;
    }

    @NonNull
    @Override
    public ProductViewHolder onCreateViewHolder(@NonNull ViewGroup parent, int viewType) {
        // Menginflate layout item_produk.xml
        View view = LayoutInflater.from(parent.getContext())
                .inflate(R.layout.item_produk, parent, false);
        return new ProductViewHolder(view);
    }

    @Override
    public void onBindViewHolder(@NonNull ProductViewHolder holder, int position) {
        Product product = products.get(position);

        // Asumsi: item_produk.xml memiliki tv_nama_produk, tv_harga, dan tv_nama_toko
        holder.tvNamaProduk.setText(product.getNamaProduk());

        // Format harga
        String formattedPrice = String.format(Locale.getDefault(), "Rp %,d", product.getHarga());
        holder.tvHarga.setText(formattedPrice);

        holder.tvNamaToko.setText(product.getNamaToko() != null ? product.getNamaToko() : "Toko Lokal");

        // TODO: Implementasi pemuatan gambar produk (Glide/Picasso)

        holder.itemView.setOnClickListener(v -> {
            // Aksi saat produk diklik (Navigasi ke DetailProdukActivity)
        });
    }

    @Override
    public int getItemCount() {
        return products.size();
    }

    public static class ProductViewHolder extends RecyclerView.ViewHolder {
        // ImageView ivFotoProduk; // Jika ada ImageView
        final TextView tvNamaProduk;
        final TextView tvHarga;
        final TextView tvNamaToko;

        public ProductViewHolder(@NonNull View itemView) {
            super(itemView);
            // Inisialisasi view dari item_produk.xml
            // tvNamaProduk = itemView.findViewById(R.id.tv_nama_produk);
            // tvHarga = itemView.findViewById(R.id.tv_harga);
            // tvNamaToko = itemView.findViewById(R.id.tv_nama_toko);

            // Karena kita belum melihat item_produk.xml, inisialisasi ini disimulasikan
            tvNamaProduk = (TextView) itemView;
            tvHarga = (TextView) itemView;
            tvNamaToko = (TextView) itemView;
        }
    }
}
