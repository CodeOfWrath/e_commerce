import 'package:e_commerce/Models/Produit.dart';
import 'package:e_commerce/Providers/Provider_Filtre.dart';
import 'package:e_commerce/Providers/Provider_Produit.dart';
import 'package:e_commerce/Providers/Provider_catalogue.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() {
  test('Tri prix croissant', () async {
    final container = ProviderContainer();

    final products = [
      Product(id: '1', name: 'A', price: 100, imageUrl: 'url', category: 'Chaussures'),
      Product(id: '2', name: 'B', price: 50, imageUrl: 'url', category: 'Chaussures'),
    ];

    // ✅ overrideWith pour FutureProvider
    container.updateOverrides([
      productProvider.overrideWith((ref) async => products),
      sortProvider.overrideWith((ref) => SortOption.priceAsc),
    ]);

    final result = container.read(catalogProvider);
    expect(result.first.price, 50);
  });

  test('Erreur réseau simulée', () async {
    final container = ProviderContainer();

    // ✅ AsyncValue.error avec 2 arguments
    container.updateOverrides([
      productProvider.overrideWith((ref) async => throw Exception('Erreur réseau')),
    ]);

    final result = container.read(catalogProvider);
    expect(result.isEmpty, true); // catalogue vide en cas d’erreur
  });
}
