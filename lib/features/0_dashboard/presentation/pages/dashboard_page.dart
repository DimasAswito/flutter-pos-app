import 'package:flutter/material.dart';
import '../../../1_home_kasir/presentation/pages/kasir_page.dart';
import '../../../2_produk_manajemen/presentation/pages/produk_page.dart';
import '../../../3_riwayat_transaksi/presentation/pages/riwayat_page.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  // Variabel untuk menyimpan index menu yang sedang aktif
  int _selectedIndex = 0;

  // Daftar halaman yang akan ditampilkan sesuai menu
  static const List<Widget> _pages = <Widget>[
    KasirPage(),
    ProdukPage(),
    RiwayatPage(),
  ];

  // Fungsi untuk mengubah state saat item di navigasi di-tap
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Body akan menampilkan halaman dari list _pages sesuai _selectedIndex
      body: _pages.elementAt(_selectedIndex),

      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart_outlined),
            activeIcon: Icon(Icons.shopping_cart),
            label: 'Kasir',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.inventory_2_outlined),
            activeIcon: Icon(Icons.inventory_2),
            label: 'Produk',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.history_outlined),
            activeIcon: Icon(Icons.history),
            label: 'Riwayat',
          ),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped, // Memanggil fungsi saat di-tap
      ),
    );
  }
}