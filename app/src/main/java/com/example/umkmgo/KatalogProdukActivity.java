package com.example.umkmgo;

import android.os.Bundle;
import android.util.Log;
import android.view.Menu;
import android.view.MenuItem;
import android.view.View;
import android.view.ViewGroup;
import android.widget.TextView;
import android.widget.Toast;

import androidx.annotation.NonNull;
import androidx.appcompat.app.AppCompatActivity;
import androidx.appcompat.widget.SearchView;
import androidx.recyclerview.widget.GridLayoutManager;
import androidx.recyclerview.widget.RecyclerView;

import com.google.android.material.floatingactionbutton.FloatingActionButton;

import java.util.ArrayList;
import java.util.List;

public class KatalogProdukActivity extends AppCompatActivity {

    private static final String TAG = "KatalogProdukActivity";

    // Deklarasi variabel UI
    private RecyclerView recyclerViewKatalog;
    private FloatingActionButton fabTambahProduk;
    private SearchView searchViewKatalog;
    private TextView tvStatusKatalog;

    // Deklarasi variabel Adapter dan List
    private ProductAdapter productAdapter;
    private List<Product> productList;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_katalog_produk);

        // Inisialisasi semua komponen UI menggunakan findViewById
        recyclerViewKatalog = findViewById(R.id.recycler_view_katalog);
        fabTambahProduk = findViewById(R.id.fab_tambah_produk);
        searchViewKatalog = findViewById(R.id.search_view_katalog);
        tvStatusKatalog = findViewById(R.id.tv_status_katalog);

        // Inisialisasi List dan Adapter
        productList = new ArrayList<>();
        productAdapter = new ProductAdapter(productList);

        // Setup RecyclerView
        if (recyclerViewKatalog != null) {
            recyclerViewKatalog.setLayoutManager(new GridLayoutManager(this, 2));
            recyclerViewKatalog.setAdapter(productAdapter);
        } else {
            Log.e(TAG, "RecyclerView is null! Check your layout file for R.id.recycler_view_katalog.");
            Toast.makeText(this, "Layout Error: RecyclerView not found.", Toast.LENGTH_LONG).show();
            return;
        }

        // Setup Listeners
        setupFabListener();
        setupSearchViewListener();

        // Muat data produk (sekarang menggunakan data dummy) dan periksa status user
        loadDummyProducts();
        checkUserStatus();
    }

    private void setupFabListener() {
        if (fabTambahProduk != null) {
            fabTambahProduk.setOnClickListener(v -> {
                Toast.makeText(KatalogProdukActivity.this, "Buka halaman tambah produk", Toast.LENGTH_SHORT).show();
            });
        }
    }

    private void setupSearchViewListener() {
        if (searchViewKatalog != null) {
            searchViewKatalog.setOnQueryTextListener(new SearchView.OnQueryTextListener() {
                @Override
                public boolean onQueryTextSubmit(String query) {
                    // Logika pencarian bisa ditambahkan di sini
                    return false;
                }

                @Override
                public boolean onQueryTextChange(String newText) {
                    // Logika filter bisa ditambahkan di sini
                    return false;
                }
            });
        }
    }

    private void checkUserStatus() {
        // Karena tidak menggunakan Firebase, kita asumsikan user adalah penjual untuk menampilkan FAB
        boolean isSeller = true;

        if (isSeller && fabTambahProduk != null) {
            fabTambahProduk.setVisibility(View.VISIBLE);
        } else if (fabTambahProduk != null) {
            fabTambahProduk.setVisibility(View.GONE);
        }
    }

    // Menggantikan loadProductsFromFirestore() dengan data tiruan
    private void loadDummyProducts() {
        Log.d(TAG, "Memuat data produk dummy.");
        // Bersihkan list sebelum menambahkan data baru
        productList.clear();

        // Tambahkan beberapa produk tiruan
        productList.add(new Product("Keripik Singkong Balado", 15000, "Toko Ibu Susi"));
        productList.add(new Product("Kue Lapis Legit", 50000, "Toko Kue Barokah"));
        productList.add(new Product("Batik Tulis Madura", 250000, "Galeri Batik Pesisir"));
        productList.add(new Product("Madu Hutan Asli", 75000, "Produk Hutan Lestari"));

        // Beri tahu adapter bahwa data telah berubah
        productAdapter.notifyDataSetChanged();

        // Perbarui tampilan status (sembunyikan teks "Belum ada produk")
        if (productList.isEmpty() && tvStatusKatalog != null) {
            tvStatusKatalog.setVisibility(View.VISIBLE);
            tvStatusKatalog.setText("Belum ada produk.");
        } else if (tvStatusKatalog != null) {
            tvStatusKatalog.setVisibility(View.GONE);
        }
    }

    // --- INNER CLASS untuk Adapter ---
    // (Tidak ada perubahan di sini, sudah benar)
    public static class ProductAdapter extends RecyclerView.Adapter<ProductAdapter.ProductViewHolder> {
        private final List<Product> products;

        public ProductAdapter(List<Product> products) {
            this.products = products;
        }

        @NonNull
        @Override
        public ProductViewHolder onCreateViewHolder(@NonNull ViewGroup parent, int viewType) {
            View view = android.view.LayoutInflater.from(parent.getContext())
                    .inflate(R.layout.item_produk, parent, false);
            return new ProductViewHolder(view);
        }

        @Override
        public void onBindViewHolder(@NonNull ProductViewHolder holder, int position) {
            Product product = products.get(position);
            holder.tvNamaProduk.setText(product.getNamaProduk());
            // Menggunakan String.format untuk harga agar lebih aman
            holder.tvHarga.setText(String.format("Rp %,d", product.getHarga()));
            holder.tvNamaToko.setText(product.getNamaToko());
        }

        @Override
        public int getItemCount() {
            return products != null ? products.size() : 0;
        }

        public static class ProductViewHolder extends RecyclerView.ViewHolder {
            TextView tvNamaProduk, tvHarga, tvNamaToko;

            public ProductViewHolder(@NonNull View itemView) {
                super(itemView);
                tvNamaProduk = itemView.findViewById(R.id.tv_nama_produk);
                tvHarga = itemView.findViewById(R.id.tv_harga);
                tvNamaToko = itemView.findViewById(R.id.tv_nama_toko);
            }
        }
    }

    // --- Menu Handling ---
    // (Tidak ada perubahan di sini, sudah benar)
    @Override
    public boolean onCreateOptionsMenu(Menu menu) {
        getMenuInflater().inflate(R.menu.menu_katalog, menu);
        return true;
    }

    @Override
    public boolean onOptionsItemSelected(@NonNull MenuItem item) {
        int id = item.getItemId();
        if (id == R.id.action_settings) {
            Toast.makeText(this, "Buka Settings", Toast.LENGTH_SHORT).show();
            return true;
        } else if (id == R.id.action_dashboard) {
            Toast.makeText(this, "Buka Dashboard", Toast.LENGTH_SHORT).show();
            return true;
        }
        return super.onOptionsItemSelected(item);
    }
}
