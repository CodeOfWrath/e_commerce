import 'package:flutter_riverpod/legacy.dart';
import '../Models/Produit.dart';

class CartNotifier extends StateNotifier<Map<Product, int>> {
  CartNotifier() : super({});

  void add(Product product) {
    state = {
      ...state,
      product: (state[product] ?? 0) + 1,
    };
  }

  void remove(Product product) {
    if (!state.containsKey(product)) return;
    final qty = state[product]!;
    if (qty > 1) {
      state = {...state, product: qty - 1};
    } else {
      final newState = {...state}..remove(product);
      state = newState;
    }
  }

  void removeProduct(Product product) {
    final newState = {...state}..remove(product);
    state = newState;
  }

  void clearCart() {
    state = {};
  }
}

final cartProvider = StateNotifierProvider<CartNotifier, Map<Product, int>>(
      (ref) => CartNotifier(),
);
