// lib/features/2_produk_manajemen/data/repositories/product_repository_impl.dart
import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../../domain/entities/product.dart';
import '../../domain/repositories/product_repository.dart';
import '../datasources/product_remote_data_source.dart';
import '../models/product_model.dart';

class ProductRepositoryImpl implements ProductRepository {
  final ProductRemoteDataSource remoteDataSource;
  // final NetworkInfo networkInfo; // Nanti untuk cek koneksi internet

  ProductRepositoryImpl({
    required this.remoteDataSource,
    // required this.networkInfo,
  });

  @override
  Future<Either<Failure, List<Product>>> getProducts() async {
    // Di sini kita bisa cek koneksi internet dulu
    // if (await networkInfo.isConnected) {
    try {
      final remoteProducts = await remoteDataSource.getProducts();
      // Karena remoteDataSource mengembalikan List<ProductModel>,
      // dan repository harus mengembalikan List<Product>, maka tidak perlu konversi
      // karena ProductModel adalah turunan dari Product.
      return Right(remoteProducts);
    } catch (e) {
      return Left(ServerFailure());
    }
    // } else {
    //   // Handle offline case
    // }
  }

  @override
  Future<Either<Failure, void>> addProduct(Product product) async {
    try {
      // Karena ProductModel adalah turunan dari Product, kita bisa lakukan casting
      // atau idealnya, ProductRepository menerima ProductModel atau DTO.
      // Untuk simple, kita buat ProductModel baru.
      final productModel = ProductModel(
        id: '',
        // ID akan digenerate oleh Firestore, jadi kita kosongkan
        name: product.name,
        price: product.price,
        stock: product.stock,
        category: product.category,
        imageUrl: product.imageUrl,
      );
      await remoteDataSource.addProduct(productModel);
      return const Right(null); // Berhasil
    } catch (e) {
      return Left(ServerFailure()); // Gagal
    }
  }

  @override
  Future<Either<Failure, void>> updateProduct(Product product) async {
    try {
      final productModel = ProductModel(
          id: product.id, name: product.name, price: product.price,
          stock: product.stock, category: product.category, imageUrl: product.imageUrl);
      await remoteDataSource.updateProduct(productModel);
      return const Right(null);
    } catch (e) {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, void>> deleteProduct(String id) async {
    try {
      await remoteDataSource.deleteProduct(id);
      return const Right(null);
    } catch (e) {
      return Left(ServerFailure());
    }
  }
}