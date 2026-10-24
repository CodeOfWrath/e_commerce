import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../Widgets/Barre_Filtre.dart';
import '../Widgets/Carte_Produit.dart';
import '../Providers/Provider_catalogue.dart';
import '../Providers/Provider_Produit.dart';
import 'Page_Favorit.dart';
import 'Pages_Carte.dart';
import 'Page_Profil.dart';

class CatalogScreen extends ConsumerWidget {
  const CatalogScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final productsAsync = ref.watch(productProvider);
    final filteredProducts = ref.watch(catalogProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Catalogue REST API'),
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
          IconButton(
            icon: const Icon(Icons.person),
            tooltip: 'Profil',
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const ProfileScreen()),
              );
            },
          ),
        ],
      ),
      body: productsAsync.when(
        data: (_) {
          return Column(
            children: [
              const FilterBar(),
              Expanded(
                child: RefreshIndicator(
                  onRefresh: () async {
                    ref.invalidate(productProvider);
                  },
                  child: filteredProducts.isEmpty
                      ? ListView(
                          children: const [
                            SizedBox(height: 100),
                            Center(
                              child: Text(
                                'Aucun produit ne correspond à la recherche.',
                                style: TextStyle(fontSize: 16, color: Colors.grey),
                              ),
                            ),
                          ],
                        )
                      : ListView.builder(
                          itemCount: filteredProducts.length,
                          itemBuilder: (context, index) =>
                              ProductCard(product: filteredProducts[index]),
                        ),
                ),
              ),
            ],
          );
        },
        loading: () => const Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircularProgressIndicator(),
              SizedBox(height: 16),
              Text('Chargement des produits depuis REST API...'),
            ],
          ),
        ),
        error: (err, stack) {
          final errorMessage = err.toString().replaceAll('Exception: ', '').replaceAll('ServerFailure: ', '');
          return Center(
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.wifi_off, size: 64, color: Colors.orange),
                  const SizedBox(height: 16),
                  const Text(
                    'Erreur de chargement',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    errorMessage,
                    textAlign: TextAlign.center,
                    style: const TextStyle(color: Colors.grey),
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton.icon(
                    icon: const Icon(Icons.refresh),
                    label: const Text('Réessayer'),
                    onPressed: () {
                      ref.invalidate(productProvider);
                    },
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
