import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/entities/product.dart';
import '../bloc/product_bloc.dart';
import '../bloc/product_event.dart';
import '../bloc/product_state.dart';

// Pisahkan BottomSheet ke widget sendiri agar bisa stateful
class EditProductBottomSheet extends StatefulWidget {
  final Product product;
  const EditProductBottomSheet({super.key, required this.product});

  @override
  State<EditProductBottomSheet> createState() => _EditProductBottomSheetState();
}

class _EditProductBottomSheetState extends State<EditProductBottomSheet> {
  late TextEditingController _nameController;
  late TextEditingController _priceController;
  late TextEditingController _stockController;
  late TextEditingController _categoryController;
  bool _isDirty = false;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.product.name);
    _priceController = TextEditingController(text: widget.product.price.toString());
    _stockController = TextEditingController(text: widget.product.stock.toString());
    _categoryController = TextEditingController(text: widget.product.category);

    // Tambahkan listener untuk mendeteksi perubahan
    _nameController.addListener(() => setState(() => _isDirty = true));
    _priceController.addListener(() => setState(() => _isDirty = true));
    _stockController.addListener(() => setState(() => _isDirty = true));
    _categoryController.addListener(() => setState(() => _isDirty = true));
  }

  @override
  void dispose() {
    _nameController.dispose();
    _priceController.dispose();
    _stockController.dispose();
    _categoryController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(16, 16, 16, MediaQuery.of(context).viewInsets.bottom + 16),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('Edit Produk', style: Theme.of(context).textTheme.titleLarge),
            const SizedBox(height: 16),
            TextField(controller: _nameController, decoration: const InputDecoration(labelText: 'Nama Produk')),
            TextField(controller: _priceController, decoration: const InputDecoration(labelText: 'Harga'), keyboardType: TextInputType.number),
            TextField(controller: _stockController, decoration: const InputDecoration(labelText: 'Stok'), keyboardType: TextInputType.number),
            TextField(controller: _categoryController, decoration: const InputDecoration(labelText: 'Kategori')),
            const SizedBox(height: 24),
            ElevatedButton(
              // Tombol hanya aktif jika ada perubahan
              onPressed: _isDirty ? () {
                final updatedProduct = widget.product.copyWith(
                  name: _nameController.text,
                  price: int.parse(_priceController.text),
                  stock: int.parse(_stockController.text),
                  category: _categoryController.text,
                );
                context.read<ProductBloc>().add(UpdateExistingProduct(updatedProduct));
                Navigator.pop(context); // Tutup bottom sheet
              } : null,
              child: const Text('Perbarui'),
            ),
          ],
        ),
      ),
    );
  }
}

// --- Halaman Detail Utama ---
class ProductDetailPage extends StatefulWidget {
  final Product product;
  const ProductDetailPage({super.key, required this.product});

  @override
  State<ProductDetailPage> createState() => _ProductDetailPageState();
}

class _ProductDetailPageState extends State<ProductDetailPage> {
  late Product _currentProduct;

  @override
  void initState() {
    super.initState();
    _currentProduct = widget.product;
  }

  void _showEditBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (_) => BlocProvider.value(
        value: BlocProvider.of<ProductBloc>(context),
        child: EditProductBottomSheet(product: _currentProduct),
      ),
    );
  }

  void _showDeleteConfirmationDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          title: const Text('Hapus Produk'),
          content: const Text('Apakah Anda yakin ingin menghapus produk ini?'),
          actions: <Widget>[
            TextButton(
              child: const Text('Batal'),
              onPressed: () => Navigator.of(dialogContext).pop(),
            ),
            TextButton(
              child: const Text('Iya, Hapus'),
              onPressed: () {
                context.read<ProductBloc>().add(DeleteProductById(_currentProduct.id));
                Navigator.of(dialogContext).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<ProductBloc, ProductState>(
      listener: (context, state) {
        // ... (state ProductUpdating, Deleting, dll tidak berubah)

        if (state is ProductUpdated) {
          ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Produk berhasil diperbarui!'))
          );
          // INI BAGIAN PENTINGNYA:
          // Perbarui state lokal (_currentProduct) dengan data baru dari state.
          setState(() {
            _currentProduct = state.updatedProduct;
          });
        }

        if (state is ProductDeleting) {
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Menghapus...')));
        }
        if (state is ProductDeleted) {
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Produk berhasil dihapus!')));
          Navigator.pop(context); // Kembali ke halaman list
        }

        if (state is ProductUpdateError || state is ProductDeleteError) {
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Terjadi kesalahan.')));
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(_currentProduct.name),
          actions: [
            IconButton(
              icon: const Icon(Icons.delete_outline),
              onPressed: () => _showDeleteConfirmationDialog(context),
            )
          ],
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(child: Image.network(_currentProduct.imageUrl ?? '', height: 200, fit: BoxFit.cover, errorBuilder: (context, error, stackTrace) => const Icon(Icons.image, size: 200, color: Colors.grey))),
              const SizedBox(height: 24),
              Text('Harga', style: Theme.of(context).textTheme.bodySmall),
              Text('Rp ${_currentProduct.price}', style: Theme.of(context).textTheme.headlineSmall),
              const SizedBox(height: 16),
              Text('Stok', style: Theme.of(context).textTheme.bodySmall),
              Text('${_currentProduct.stock} pcs', style: Theme.of(context).textTheme.headlineSmall),
              const SizedBox(height: 16),
              Text('Kategori', style: Theme.of(context).textTheme.bodySmall),
              Text(_currentProduct.category, style: Theme.of(context).textTheme.headlineSmall),
            ],
          ),
        ),
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.all(16.0),
          child: ElevatedButton.icon(
            icon: const Icon(Icons.edit),
            label: const Text('Edit Produk'),
            onPressed: () => _showEditBottomSheet(context),
          ),
        ),
      ),
    );
  }
}