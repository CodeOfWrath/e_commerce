import 'package:e_commerce/features/ventes/Providers/Provider.dart';
import 'package:e_commerce/features/ventes/Screens/Page_Detail_Produit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ProductsListScreen extends ConsumerWidget {
  const ProductsListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final productsAsync = ref.watch(productsFutureProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Produits')),
      body: productsAsync.when(
        data: (products) => ListView.builder(
          itemCount: products.length,
          itemBuilder: (_, i) {
            final p = products[i];
            return ListTile(
              title: Text(p.name),
              subtitle: Text('${p.price.toStringAsFixed(2)} €'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => ProductDetailScreen(product: p),
                  ),
                );
              },
            );
          },
        ),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Erreur réseau. Affichage des données hors-ligne si disponibles.',
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 8),
              Text(e.toString(), style: const TextStyle(color: Colors.red)),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () => ref.refresh(productsFutureProvider),
                child: const Text('Réessayer'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
