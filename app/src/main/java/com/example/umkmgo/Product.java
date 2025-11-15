package com.example.umkmgo;

public class Product {
    private String namaProduk;
    private int harga;
    private String namaToko;
    // Anda bisa menambahkan atribut lain seperti URL gambar, deskripsi, dll.
    // private String urlGambar;
    // private String deskripsi;

    // Diperlukan constructor kosong untuk beberapa library (seperti Firebase)
    public Product() {
    }

    // Constructor untuk membuat objek Product baru
    public Product(String namaProduk, int harga, String namaToko) {
        this.namaProduk = namaProduk;
        this.harga = harga;
        this.namaToko = namaToko;
    }

    // Getter methods
    public String getNamaProduk() {
        return namaProduk;
    }

    public int getHarga() {
        return harga;
    }

    public String getNamaToko() {
        return namaToko;
    }

    // Setter methods (opsional, tergantung kebutuhan)
    public void setNamaProduk(String namaProduk) {
        this.namaProduk = namaProduk;
    }

    public void setHarga(int harga) {
        this.harga = harga;
    }

    public void setNamaToko(String namaToko) {
        this.namaToko = namaToko;
    }
}
