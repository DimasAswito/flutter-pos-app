// lib/features/2_produk_manajemen/domain/entities/product.dart

import 'package:equatable/equatable.dart';

// Equatable membantu untuk membandingkan objek tanpa harus override manual
class Product extends Equatable {
  final String id;
  final String name;
  final int price;
  final int stock;
  final String category; // Nanti bisa jadi objek tersendiri
  final String? imageUrl; // Opsional

  const Product({
    required this.id,
    required this.name,
    required this.price,
    required this.stock,
    required this.category,
    this.imageUrl,
  });

  // Ini diperlukan oleh Equatable untuk tahu properti mana yang harus dibandingkan
  @override
  List<Object?> get props => [id, name, price, stock, category, imageUrl];
}