// test/widget_test.dart

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:umkmgo/main.dart'; // Impor dari main.dart untuk mendapatkan definisi Product dan dummy data
// import 'package:umkmgo/product_catalog_page.dart'; // DIHAPUS: Unused import

void main() {
  // Grup tes untuk halaman katalog produk
  testWidgets('Product Catalog Page renders correctly and search works', (WidgetTester tester) async {
    // Bangun widget ProductCatalogPage melalui root MyApp.
    await tester.pumpWidget(const MyApp());

    // Verifikasi elemen UI awal
    // Verifikasi bahwa search bar ditampilkan
    expect(find.byType(TextField), findsOneWidget);
    expect(find.text('Cari produk...'), findsOneWidget);

    // Verifikasi bahwa produk-produk awal (dari dummy data) ditampilkan.
    expect(find.text('Keripik Singkong Balado'), findsOneWidget);
    expect(find.text('Kue Lapis Legit'), findsOneWidget);

    // Simulasi pencarian (interaksi)
    // Masukkan teks 'batik' ke dalam search bar
    await tester.enterText(find.byType(TextField), 'batik');
    await tester.pump(); // Jalankan frame baru untuk memperbarui UI setelah state berubah

    // Verifikasi hasil setelah pencarian
    // Verifikasi bahwa produk 'Batik Tulis Madura' masih ada
    expect(find.text('Batik Tulis Madura'), findsOneWidget);

    // Verifikasi bahwa produk lain yang tidak cocok dengan pencarian sudah hilang dari layar
    expect(find.text('Keripik Singkong Balado'), findsNothing);
    expect(find.text('Kue Lapis Legit'), findsNothing);
  });
}
