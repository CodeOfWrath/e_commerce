import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../Models/Produit.dart';
import '../Providers/Provider_Carte.dart';
import '../Providers/Provider_Favorit.dart';

class PageDetailProduit extends ConsumerWidget {
  final Product product;

  const PageDetailProduit({super.key, required this.product});

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
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    favorites.contains(product.id)
                        ? '${product.name} retiré des favoris'
                        : '${product.name} ajouté aux favoris',
                  ),
                  duration: const Duration(milliseconds: 800),
                ),
              );
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Hero(
              tag: product.id, // animation entre liste et détail
              child: Image.network(
                product.imageUrl,
                width: double.infinity,
                height: 250,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(height: 16),

            // Nom et prix
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                product.name,
                style: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                '${product.price} € • ${product.category}',
                style: const TextStyle(fontSize: 18, color: Colors.grey),
              ),
            ),
            const SizedBox(height: 20),

            // Bouton ajouter au panier
            Center(
              child: ElevatedButton.icon(
                icon: const Icon(Icons.add_shopping_cart),
                label: const Text('Ajouter au panier'),
                onPressed: () {
                  ref.read(cartProvider.notifier).add(product);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('${product.name} ajouté au panier'),
                      duration: const Duration(milliseconds: 800),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 20),

            // Description fictive
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                'Description du produit :\n'
                    'Ce produit est fabriqué avec des matériaux de haute qualité. '
                    'Idéal pour un usage quotidien et durable dans le temps.',
                style: TextStyle(fontSize: 16),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
