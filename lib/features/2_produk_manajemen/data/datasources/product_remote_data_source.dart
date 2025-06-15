import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/product_model.dart';

abstract class ProductRemoteDataSource {
  Future<List<ProductModel>> getProducts();
  Future<void> addProduct(ProductModel product);
  Future<void> updateProduct(ProductModel product);
  Future<void> deleteProduct(String id);
}

class ProductRemoteDataSourceImpl implements ProductRemoteDataSource {
  final FirebaseFirestore firestore;

  ProductRemoteDataSourceImpl({required this.firestore});

  @override
  Future<List<ProductModel>> getProducts() async {
    try {
      final querySnapshot = await firestore.collection('products').get();

      final List<ProductModel> products = querySnapshot.docs.map((doc) {
        // Ambil data dari dokumen
        final data = doc.data();
        // Penting: tambahkan ID dokumen ke dalam data map
        data['id'] = doc.id;
        // Konversi dari Map (JSON) ke ProductModel
        return ProductModel.fromJson(data);
      }).toList();

      return products;
    } catch (e) {
      // Tangani error jika terjadi
      print(e); // Untuk debugging
      throw Exception('Gagal mengambil data produk');
    }
  }

  @override
  Future<void> addProduct(ProductModel product) async {
    try {
      // .add() akan otomatis membuat dokumen dengan ID unik di Firestore
      await firestore.collection('products').add(product.toJson());
    } catch (e) {
      print(e); // Untuk debugging
      throw Exception('Gagal menambah produk');
    }
  }

  @override
  Future<void> updateProduct(ProductModel product) async {
    await firestore.collection('products').doc(product.id).update(product.toJson());
  }

  @override
  Future<void> deleteProduct(String id) async {
    await firestore.collection('products').doc(id).delete();
  }
}