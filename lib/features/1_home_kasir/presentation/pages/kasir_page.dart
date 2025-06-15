import 'package:flutter/material.dart';

class KasirPage extends StatelessWidget {
  const KasirPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Kasir'),
      ),
      body: const Center(
        child: Text(
          'Halaman untuk Transaksi',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}