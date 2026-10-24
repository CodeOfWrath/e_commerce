import 'package:e_commerce/features/ventes/domain/entities/product_entity.dart';
import 'package:e_commerce/features/ventes/Providers/Provider_Favorit.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  const product = Product(
    id: '1',
    name: 'Sac à dos',
    price: 39.99,
    imageUrl: 'url',
    category: 'Accessoires',
  );

  test('Ajout aux favoris', () async {
    SharedPreferences.setMockInitialValues({});
    final container = ProviderContainer();
    final notifier = container.read(favoritesProvider.notifier);
    await notifier.toggleFavorite(product.id);
    expect(container.read(favoritesProvider).contains(product.id), true);
  });

  test('Retrait des favoris', () async {
    SharedPreferences.setMockInitialValues({});
    final container = ProviderContainer();
    final notifier = container.read(favoritesProvider.notifier);
    await notifier.toggleFavorite(product.id);
    await notifier.toggleFavorite(product.id);
    expect(container.read(favoritesProvider).contains(product.id), false);
  });

  test('Chargement des favoris depuis SharedPreferences', () async {
    SharedPreferences.setMockInitialValues({
      'favorites': ['p1', 'p2'],
    });

    final container = ProviderContainer();
    final notifier = container.read(favoritesProvider.notifier);
    await notifier.loadFavorites();

    expect(container.read(favoritesProvider).contains('p1'), true);
    expect(container.read(favoritesProvider).contains('p2'), true);
  });
}
