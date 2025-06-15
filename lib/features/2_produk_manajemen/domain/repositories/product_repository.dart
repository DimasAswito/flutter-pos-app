// lib/features/2_produk_manajemen/domain/repositories/product_repository.dart
import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../entities/product.dart';

abstract class ProductRepository {
  // Kontrak ini menyatakan: "Harus ada fungsi getProducts,
  // yang akan mengembalikan Failure jika gagal, atau List<Product> jika berhasil"
  Future<Either<Failure, List<Product>>> getProducts();
  Future<Either<Failure, void>> addProduct(Product product);
  Future<Either<Failure, void>> updateProduct(Product product);
  Future<Either<Failure, void>> deleteProduct(String id);
}