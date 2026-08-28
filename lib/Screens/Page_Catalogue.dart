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

    return Scaffold(
      appBar: AppBar(title: const Text('Catalogue')),
      body: Column(
        children: [
          const FilterBar(), // barre de tri/filtre
          Expanded(
            child: productsAsync.when(
              data: (products) {
                final sortOption = ref.watch(sortProvider);
                final categoryFilter = ref.watch(categoryFilterProvider);

                // ✅ Filtrage par catégorie
                final filteredProducts = products.where((p) {
                  if (categoryFilter == null) return true;
                  return p.category == categoryFilter;
                }).toList();

                // ✅ Tri appliqué sur la liste filtrée
                if (sortOption == SortOption.priceAsc) {
                  filteredProducts.sort((a, b) => a.price.compareTo(b.price));
                } else {
                  filteredProducts.sort((a, b) => b.price.compareTo(a.price));
                }

                return ListView.builder(
                  itemCount: filteredProducts.length,
                  itemBuilder: (context, index) =>
                      ProductCard(product: filteredProducts[index]),
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
