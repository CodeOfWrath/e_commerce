import 'package:e_commerce/Models/Produit.dart';
import 'package:e_commerce/Providers/Provider_Carte.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  final product = Product(
    id: '1',
    name: 'Chaussures',
    price: 59.99,
    imageUrl: 'url',
    category: 'Chaussures',
  );

  test('Ajout au panier', () {
    final notifier = CartNotifier();
    notifier.add(product);
    expect(notifier.state[product], 1);
  });

  test('Retrait du produit (quantité)', () {
    final notifier = CartNotifier();
    notifier.add(product);
    notifier.add(product);
    notifier.remove(product);
    expect(notifier.state[product], 1);
  });

  test('Suppression complète du produit', () {
    final notifier = CartNotifier();
    notifier.add(product);
    notifier.removeProduct(product);
    expect(notifier.state.containsKey(product), false);
  });

  test('Vider le panier', () {
    final notifier = CartNotifier();
    notifier.add(product);
    notifier.clearCart();
    expect(notifier.state.isEmpty, true);
  });
}
