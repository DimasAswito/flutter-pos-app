import 'package:equatable/equatable.dart';

import '../../../2_produk_manajemen/domain/entities/product.dart';

abstract class ProductEvent extends Equatable {
  const ProductEvent();
  @override
  List<Object> get props => [];
}

// Event untuk memicu pengambilan data produk
class FetchAllProducts extends ProductEvent {}

class AddNewProduct extends ProductEvent {
  final Product product;
  const AddNewProduct(this.product);
  @override
  List<Object> get props => [product];
}

class UpdateExistingProduct extends ProductEvent {
  final Product product;
  const UpdateExistingProduct(this.product);
  @override List<Object> get props => [product];
}

class DeleteProductById extends ProductEvent {
  final String id;
  const DeleteProductById(this.id);
  @override List<Object> get props => [id];
}
