import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../entities/product.dart';
import '../repositories/product_repository.dart';

class UpdateProduct {
  final ProductRepository repository;
  UpdateProduct(this.repository);
  Future<Either<Failure, void>> call(Product product) async {
    return await repository.updateProduct(product);
  }
}