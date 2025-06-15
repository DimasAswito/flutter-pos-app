import 'package:equatable/equatable.dart';
import '../../domain/entities/product.dart';

abstract class ProductState extends Equatable {
  const ProductState();
  @override
  List<Object> get props => [];
}

class ProductInitial extends ProductState {}
class ProductLoading extends ProductState {}
class ProductLoaded extends ProductState {
  final List<Product> products;
  const ProductLoaded(this.products);
  @override
  List<Object> get props => [products];
}
class ProductError extends ProductState {
  final String message;
  const ProductError(this.message);
  @override
  List<Object> get props => [message];
}

class ProductAdding extends ProductState {} // Saat proses menyimpan
class ProductAdded extends ProductState {}  // Saat berhasil disimpan
class ProductAddError extends ProductState { // Saat gagal
  final String message;
  const ProductAddError(this.message);
  @override
  List<Object> get props => [message];
}

class ProductUpdating extends ProductState {}
class ProductUpdated extends ProductState {
  final Product updatedProduct;
  const ProductUpdated(this.updatedProduct);
  @override
  List<Object> get props => [updatedProduct];
}
class ProductUpdateError extends ProductState {
  final String message;
  const ProductUpdateError(this.message);
  @override List<Object> get props => [message];
}

class ProductDeleting extends ProductState {}
class ProductDeleted extends ProductState {}
class ProductDeleteError extends ProductState {
  final String message;
  const ProductDeleteError(this.message);
  @override List<Object> get props => [message];
}