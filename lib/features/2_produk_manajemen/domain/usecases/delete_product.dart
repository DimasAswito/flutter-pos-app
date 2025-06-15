import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../repositories/product_repository.dart';

class DeleteProduct {
  final ProductRepository repository;
  DeleteProduct(this.repository);
  Future<Either<Failure, void>> call(String id) async {
    return await repository.deleteProduct(id);
  }
}