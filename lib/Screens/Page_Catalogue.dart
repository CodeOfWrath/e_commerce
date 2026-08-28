import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../Providers/Provider_Filtre.dart';
import '../Providers/Provider_Produit.dart';
import '../Widgets/Barre_Filtre.dart';
import '../Widgets/Carte_Produit.dart';

class CatalogScreen extends ConsumerWidget {
  const CatalogScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final productsAsync = ref.watch(productProvider);
    final sortOption = ref.watch(sortProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Catalogue')),
      body: Column(
        children: [
          const FilterBar(), // barre de tri/filtre
          Expanded(
            child: productsAsync.when(
              data: (products) {
                // copie pour tri
                final sortedProducts = [...products];
                if (sortOption == SortOption.priceAsc) {
                  sortedProducts.sort((a, b) => a.price.compareTo(b.price));
                } else {
                  sortedProducts.sort((a, b) => b.price.compareTo(a.price));
                }

                return ListView.builder(
                  itemCount: sortedProducts.length,
                  itemBuilder: (context, index) =>
                      ProductCard(product: sortedProducts[index]),
                );
              },
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (err, _) => Center(child: Text('Erreur: $err')),
            ),
          ),
        ],
      ),
    );
  }
}
