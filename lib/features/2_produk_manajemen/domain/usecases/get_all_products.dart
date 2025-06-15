// lib/features/2_produk_manajemen/domain/usecases/get_all_products.dart
import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../entities/product.dart';
import '../repositories/product_repository.dart';

class GetAllProducts {
  final ProductRepository repository;

  GetAllProducts(this.repository);

  // Kita gunakan 'call' agar class ini bisa dipanggil seperti fungsi
  Future<Either<Failure, List<Product>>> call() async {
    return await repository.getProducts();
  }
}