import 'package:e_commerce/features/ventes/domain/entities/product_entity.dart';
import 'package:e_commerce/features/ventes/Providers/Provider_Filtre.dart';
import 'package:e_commerce/features/ventes/Providers/Provider_Produit.dart';
import 'package:e_commerce/features/ventes/Providers/Provider_catalogue.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PriceAscSortNotifier extends SortNotifier {
  @override
  SortOption build() => SortOption.priceAsc;
}

void main() {
  test('Tri prix croissant', () async {
    final products = [
      const Product(id: '1', name: 'A', price: 100, imageUrl: 'url', category: 'Chaussures'),
      const Product(id: '2', name: 'B', price: 50, imageUrl: 'url', category: 'Chaussures'),
    ];

    final container = ProviderContainer(
      overrides: [
        productProvider.overrideWith((ref) async => products),
        sortProvider.overrideWith(PriceAscSortNotifier.new),
      ],
    );

    await container.read(productProvider.future);

    final result = container.read(catalogProvider);
    expect(result.first.price, 50);
  });

  test('Erreur réseau simulée', () async {
    final container = ProviderContainer(
      overrides: [
        productProvider.overrideWith((ref) async => throw Exception('Erreur réseau')),
      ],
    );

    final result = container.read(catalogProvider);
    expect(result.isEmpty, true);
  });
}
