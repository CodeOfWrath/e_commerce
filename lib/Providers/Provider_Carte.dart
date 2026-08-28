import 'package:flutter_riverpod/legacy.dart';

import '../Models/Produit.dart';

class CartNotifier extends StateNotifier<Map<Product, int>> {
  CartNotifier() : super({});

  void add(Product product) {
    state = {...state, product: (state[product] ?? 0) + 1};
  }

  void remove(Product product) {
    final newState = {...state};
    if (newState[product] != null) {
      newState[product] = newState[product]! - 1;
      if (newState[product]! <= 0) newState.remove(product);
    }
    state = newState;
  }
}

final cartProvider = StateNotifierProvider<CartNotifier, Map<Product, int>>((ref) => CartNotifier());
