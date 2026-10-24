import 'package:e_commerce/features/ventes/domain/entities/product_entity.dart';
import 'package:e_commerce/features/ventes/Providers/Provider_Carte.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() {
  const product = Product(
    id: '1',
    name: 'Chaussures',
    price: 59.99,
    imageUrl: 'url',
    category: 'Chaussures',
  );

  test('Ajout au panier', () {
    final container = ProviderContainer();
    final notifier = container.read(cartProvider.notifier);
    notifier.add(product);
    expect(container.read(cartProvider)[product], 1);
  });

  test('Retrait du produit (quantité)', () {
    final container = ProviderContainer();
    final notifier = container.read(cartProvider.notifier);
    notifier.add(product);
    notifier.add(product);
    notifier.remove(product);
    expect(container.read(cartProvider)[product], 1);
  });

  test('Suppression complète du produit', () {
    final container = ProviderContainer();
    final notifier = container.read(cartProvider.notifier);
    notifier.add(product);
    notifier.removeProduct(product);
    expect(container.read(cartProvider).containsKey(product), false);
  });

  test('Vider le panier', () {
    final container = ProviderContainer();
    final notifier = container.read(cartProvider.notifier);
    notifier.add(product);
    notifier.clearCart();
    expect(container.read(cartProvider).isEmpty, true);
  });

  test('Ajout multiple incrémente la quantité', () {
    final container = ProviderContainer();
    final notifier = container.read(cartProvider.notifier);
    notifier.add(product);
    notifier.add(product);
    expect(container.read(cartProvider)[product], 2);
  });

  test('Suppression d’un produit absent ne plante pas', () {
    final container = ProviderContainer();
    final notifier = container.read(cartProvider.notifier);
    notifier.remove(product);
    expect(container.read(cartProvider).isEmpty, true);
  });
}
