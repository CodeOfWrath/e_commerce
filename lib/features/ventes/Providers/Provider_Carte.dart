import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../domain/entities/product_entity.dart';

class CartNotifier extends Notifier<Map<Product, int>> {
  @override
  Map<Product, int> build() => {};

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
      final newState = Map<Product, int>.from(state)..remove(product);
      state = newState;
    }
  }

  void removeProduct(Product product) {
    final newState = Map<Product, int>.from(state)..remove(product);
    state = newState;
  }

  void clearCart() {
    state = {};
  }

  double get totalPrice {
    double total = 0.0;
    state.forEach((product, quantity) {
      total += product.price * quantity;
    });
    return total;
  }
}

final cartProvider = NotifierProvider<CartNotifier, Map<Product, int>>(
  CartNotifier.new,
);
