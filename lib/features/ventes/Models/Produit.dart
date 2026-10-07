import 'package:flutter/foundation.dart';

@immutable
class Product {
  final String id;
  final String name;
  final double price;
  final String imageUrl;
  final String category;

  const Product({
    required this.id,
    required this.name,
    required this.price,
    required this.imageUrl,
    required this.category,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    final id = json['id']?.toString() ?? 'unknown';
    final name = json['name']?.toString() ?? 'Produit inconnu';
    final imageUrl = json['imageUrl']?.toString() ?? '';
    final category = json['category']?.toString() ?? 'Divers';

    double price;
    final rawPrice = json['price'];
    if (rawPrice is num) {
      price = rawPrice.toDouble();
    } else if (rawPrice is String) {
      price = double.tryParse(rawPrice) ?? 0.0;
    } else {
      price = 0.0;
    }

    return Product(
      id: id,
      name: name,
      price: price,
      imageUrl: imageUrl,
      category: category,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          other is Product && runtimeType == other.runtimeType && id == other.id;

  @override
  int get hashCode => id.hashCode;
}
