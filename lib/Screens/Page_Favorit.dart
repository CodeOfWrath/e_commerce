import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../Providers/Provider_Favorit.dart';
import '../Providers/Provider_Produit.dart';
import '../Widgets/Carte_Produit.dart';

class FavoritesScreen extends ConsumerWidget {
  const FavoritesScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final favorites = ref.watch(favoritesProvider);
    final productsAsync = ref.watch(productProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Favoris')),
      body: productsAsync.when(
        data: (products) {
          // Filtrer les produits favoris
          final favProducts = products
              .where((p) => favorites.contains(p.id))
              .toList();

          if (favProducts.isEmpty) {
            return const Center(child: Text('Aucun favori'));
          }

          return ListView.builder(
            itemCount: favProducts.length,
            itemBuilder: (context, index) =>
                ProductCard(product: favProducts[index]),
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, _) => Center(child: Text('Erreur: $err')),
      ),
    );
  }
}
