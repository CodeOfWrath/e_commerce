import 'package:flutter_riverpod/legacy.dart';
import '../Models/Produit.dart';

class CartNotifier extends StateNotifier<Map<Product, int>> {
  CartNotifier() : super({});

  /// Ajouter un produit (+1)
  void add(Product product) {
    state = {...state, product: (state[product] ?? 0) + 1};
  }

  /// Retirer un produit (-1)
  void remove(Product product) {
    final newState = {...state};
    if (newState[product] != null) {
      newState[product] = newState[product]! - 1;
      if (newState[product]! <= 0) {
        newState.remove(product);
      }
    }
    state = newState;
  }

  /// Supprimer complètement un produit du panier
  void removeProduct(Product product) {
    final newState = {...state};
    newState.remove(product);
    state = newState;
  }

  /// Vider totalement le panier
  void clearCart() {
    state = {};
  }
}

final cartProvider =
StateNotifierProvider<CartNotifier, Map<Product, int>>((ref) {
  return CartNotifier();
});
