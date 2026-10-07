import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../Providers/provider_favorit.dart';
import '../Providers/provider_produit.dart';
import '../Widgets/Carte_Produit.dart';

class FavoritesScreen extends ConsumerWidget {
  const FavoritesScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final favorites = ref.watch(favoritesProvider);
    final productsAsync = ref.watch(productProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Favoris'),
        actions: [
          IconButton(
            icon: const Icon(Icons.delete),
            tooltip: 'Vider les favoris',
            onPressed: () {
              ref.read(favoritesProvider.notifier).clearFavorites();
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Favoris vidés')),
              );
            },
          ),
        ],
      ),
      body: productsAsync.when(
        data: (products) {
          final favProducts =
          products.where((p) => favorites.contains(p.id)).toList();

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
        error: (err, _) => Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.error, color: Colors.red, size: 48),
              const SizedBox(height: 12),
              Text(
                'Impossible de charger les favoris.\nErreur: $err',
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 12),
              ElevatedButton(
                onPressed: () => ref.refresh(productProvider),
                child: const Text('Réessayer'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
