import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pos_app/features/2_produk_manajemen/presentation/pages/product_detail_page.dart';
import '../../data/datasources/product_remote_data_source.dart';
import '../../data/repositories/product_repository_impl.dart';
import '../../domain/usecases/add_product.dart';
import '../../domain/usecases/delete_product.dart';
import '../../domain/usecases/get_all_products.dart';
import '../../domain/usecases/update_product.dart';
import '../bloc/product_bloc.dart';
import '../bloc/product_event.dart';
import '../bloc/product_state.dart';
import 'add_product_page.dart';

class ProdukPage extends StatelessWidget {
  const ProdukPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ProductBloc(
        getAllProducts: GetAllProducts(
          ProductRepositoryImpl(
            remoteDataSource: ProductRemoteDataSourceImpl(
              firestore: FirebaseFirestore.instance,
            ),
          ),
        ),
        addProduct: AddProduct(
          ProductRepositoryImpl(
            remoteDataSource: ProductRemoteDataSourceImpl(
              firestore: FirebaseFirestore.instance,
            ),
          ),
        ),
        updateProduct: UpdateProduct(
          ProductRepositoryImpl(
            remoteDataSource: ProductRemoteDataSourceImpl(
              firestore: FirebaseFirestore.instance,
            ),
          ),
        ),
        deleteProduct: DeleteProduct(
          ProductRepositoryImpl(
            remoteDataSource: ProductRemoteDataSourceImpl(
              firestore: FirebaseFirestore.instance,
            ),
          ),
        ),
      )..add(FetchAllProducts()),
      // 1. Bungkus Scaffold dengan widget Builder
      child: Builder(
          builder: (context) { // 2. 'context' ini sekarang berada di bawah BlocProvider dan valid
            return Scaffold(
              appBar: AppBar(
                title: const Text('Manajemen Produk'),
              ),
              body: BlocBuilder<ProductBloc, ProductState>(
                builder: (context, state) {
                  if (state is ProductLoading) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  if (state is ProductLoaded) {
                    if (state.products.isEmpty) {
                      return const Center(child: Text('Belum ada produk.'));
                    }
                    return ListView.builder(
                      itemCount: state.products.length,
                      itemBuilder: (context, index) {
                        final product = state.products[index];
                        return ListTile(
                          title: Text(product.name),
                          subtitle: Text('Stok: ${product.stock}'),
                          trailing: Text('Rp ${product.price}'),
                          onTap: () { // <-- Tambahkan onTap
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => BlocProvider.value(
                                  value: BlocProvider.of<ProductBloc>(context),
                                  child: ProductDetailPage(product: product),
                                ),
                              ),
                            );
                          },
                        );
                      },
                    );
                  }
                  if (state is ProductError) {
                    return Center(child: Text(state.message));
                  }
                  return const Center(child: Text('Silakan mulai dengan memuat data.'));
                },
              ),
              floatingActionButton: FloatingActionButton(
                onPressed: () {
                  Navigator.push(
                    context, // Sekarang context ini valid karena berasal dari Builder
                    MaterialPageRoute(
                      builder: (_) => BlocProvider.value(
                        value: BlocProvider.of<ProductBloc>(context),
                        child: const AddProductPage(),
                      ),
                    ),
                  );
                },
                child: const Icon(Icons.add),
              ),
            );
          }
      ),
    );
  }
}