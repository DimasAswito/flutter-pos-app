import 'package:flutter/material.dart';

class RiwayatPage extends StatelessWidget {
  const RiwayatPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Riwayat Transaksi'),
      ),
      body: const Center(
        child: Text(
          'Halaman untuk Melihat Riwayat Transaksi',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}