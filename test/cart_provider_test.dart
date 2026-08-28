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

  test('Suppression du produit', () {
    final notifier = CartNotifier();
    notifier.add(product);
    notifier.removeProduct(product);
    expect(notifier.state.containsKey(product), false);
  });
}
