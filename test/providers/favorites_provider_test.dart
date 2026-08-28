import 'package:e_commerce/Models/Produit.dart';
import 'package:e_commerce/Providers/Provider_Favorit.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  final product = Product(
    id: '1',
    name: 'Sac à dos',
    price: 39.99,
    imageUrl: 'url',
    category: 'Accessoires',
  );

  test('Ajout aux favoris', () async {
    final notifier = FavoritesNotifier();
    await notifier.toggleFavorite(product.id);
    expect(notifier.state.contains(product.id), true);
  });

  test('Retrait des favoris', () async {
    final notifier = FavoritesNotifier();
    await notifier.toggleFavorite(product.id);
    await notifier.toggleFavorite(product.id);
    expect(notifier.state.contains(product.id), false);
  });

  test('Chargement des favoris depuis SharedPreferences', () async {
    SharedPreferences.setMockInitialValues({
      'favorites': ['p1', 'p2'],
    });

    final notifier = FavoritesNotifier();
    await Future.delayed(const Duration(milliseconds: 100)); // attendre _init

    expect(notifier.state.contains('p1'), true);
    expect(notifier.state.contains('p2'), true);
  });
}
