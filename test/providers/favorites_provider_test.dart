import 'package:e_commerce/Models/Produit.dart';
import 'package:e_commerce/Providers/Provider_Favorit.dart';
import 'package:flutter_test/flutter_test.dart';

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
    await notifier.toggleFavorite(product);
    expect(notifier.state.contains(product.id), true);
  });

  test('Retrait des favoris', () async {
    final notifier = FavoritesNotifier();
    await notifier.toggleFavorite(product);
    await notifier.toggleFavorite(product);
    expect(notifier.state.contains(product.id), false);
  });
}
