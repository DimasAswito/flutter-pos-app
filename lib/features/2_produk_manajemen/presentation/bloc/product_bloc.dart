import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/usecases/add_product.dart';
import '../../domain/usecases/delete_product.dart';
import '../../domain/usecases/get_all_products.dart';
import '../../domain/usecases/update_product.dart';
import 'product_event.dart';
import 'product_state.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  final GetAllProducts getAllProducts;
  final AddProduct addProduct;
  final UpdateProduct updateProduct;
  final DeleteProduct deleteProduct;

  ProductBloc({
    required this.getAllProducts,
    required this.addProduct,
    required this.updateProduct,
    required this.deleteProduct
  }) : super(ProductInitial()) {
    on<FetchAllProducts>((event, emit) async {
      emit(ProductLoading());
      final failureOrProducts = await getAllProducts.call();
      failureOrProducts.fold(
            (failure) => emit(const ProductError('Gagal memuat data')),
            (products) => emit(ProductLoaded(products)),
      );
    });

    on<AddNewProduct>((event, emit) async {
      emit(ProductAdding());
      final failureOrSuccess = await addProduct.call(event.product);

      failureOrSuccess.fold(
            (failure) => emit(const ProductAddError('Gagal menyimpan produk')),
            (_) {
          emit(ProductAdded());
          // PENTING: Setelah berhasil menambah, panggil lagi event fetch
          // agar daftar produk di halaman utama ter-update.
          add(FetchAllProducts());
        },
      );
    });

    on<UpdateExistingProduct>((event, emit) async {
      emit(ProductUpdating());
      final result = await updateProduct.call(event.product);
      result.fold(
            (failure) => emit(const ProductUpdateError('Gagal memperbarui produk')),
            (_) {
          emit(ProductUpdated(event.product));
          add(FetchAllProducts()); // Refresh list
        },
      );
    });

    on<DeleteProductById>((event, emit) async {
      emit(ProductDeleting());
      final result = await deleteProduct.call(event.id);
      result.fold(
            (failure) => emit(const ProductDeleteError('Gagal menghapus produk')),
            (_) {
          emit(ProductDeleted());
          add(FetchAllProducts()); // Refresh list
        },
      );
    });
  }
}