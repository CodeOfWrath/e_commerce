import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../Providers/Provider_catalogue.dart';
import '../Widgets/barre_filtre.dart';
import '../Widgets/carte_produit.dart';
import 'page_favorit.dart';
import 'pages_carte.dart';

class CatalogScreen extends ConsumerWidget {
  const CatalogScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final products = ref.watch(catalogProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Catalogue'),
        actions: [
          IconButton(
            icon: const Icon(Icons.shopping_cart),
            tooltip: 'Voir mon panier',
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const CartScreen()),
              );
            },
          ),
          IconButton(
            icon: const Icon(Icons.favorite),
            tooltip: 'Voir mes favoris',
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const FavoritesScreen()),
              );
            },
          ),
        ],
      ),
      body: Column(
        children: [
          const FilterBar(),
          Expanded(
            child: products.isEmpty
                ? const Center(child: CircularProgressIndicator())
                : ListView.builder(
              itemCount: products.length,
              itemBuilder: (context, index) =>
                  ProductCard(product: products[index]),
            ),
          ),
        ],
      ),
    );
  }
}
