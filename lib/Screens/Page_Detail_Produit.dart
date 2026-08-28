import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../Models/Produit.dart';
import '../Providers/Provider_Carte.dart';
import '../Providers/Provider_Favorit.dart';

class ProductDetailScreen extends ConsumerWidget {
  final Product product;

  const ProductDetailScreen({super.key, required this.product});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final favorites = ref.watch(favoritesProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text(product.name),
        actions: [
          IconButton(
            icon: Icon(
              favorites.contains(product.id)
                  ? Icons.favorite
                  : Icons.favorite_border,
              color: favorites.contains(product.id) ? Colors.red : null,
            ),
            onPressed: () {
              ref.read(favoritesProvider.notifier).toggleFavorite(product);
            },
          ),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Hero(
            tag: product.id,
            child: Image.network(product.imageUrl,
                width: double.infinity, height: 250, fit: BoxFit.cover),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text('${product.price} € ',
                style: const TextStyle(fontSize: 18)),
          ),
          Center(
            child: ElevatedButton.icon(
              icon: const Icon(Icons.add_shopping_cart),
              label: const Text('Ajouter au panier'),
              onPressed: () {
                ref.read(cartProvider.notifier).add(product);
              },
            ),
          ),
        ],
      ),
    );
  }
}
