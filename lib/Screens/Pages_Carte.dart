import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../Providers/Provider_Carte.dart';
import '../widgets/cart_item.dart';

class CartScreen extends ConsumerWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cart = ref.watch(cartProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Panier')),
      body: cart.isEmpty
          ? const Center(child: Text('Votre panier est vide'))
          : ListView(
        children: cart.entries
            .map((entry) => CartItem(product: entry.key, quantity: entry.value))
            .toList(),
      ),
    );
  }
}
