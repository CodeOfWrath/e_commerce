import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../Models/Produit.dart';

final productProvider = FutureProvider<List<Product>>((ref) async {
  await Future.delayed(const Duration(seconds: 1));
  return [
    Product(
      id: '1',
      name: 'Chaussures',
      price: 59.99,
      imageUrl: 'https://via.placeholder.com/150',
      category: 'Chaussures',
    ),
    Product(
      id: '2',
      name: 'T-shirt',
      price: 19.99,
      imageUrl: 'https://via.placeholder.com/150',
      category: 'Vêtements',
    ),
    Product(
      id: '3',
      name: 'Sac à dos',
      price: 39.99,
      imageUrl: 'https://via.placeholder.com/150',
      category: 'Accessoires',
    ),
  ];
});
