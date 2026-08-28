import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../Providers/Provider_Carte.dart';
import '../Widgets/Cart_Item.dart';

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
        children: cart.entries.map((entry) {
          final product = entry.key;
          final quantity = entry.value;
          return CartItem(
            product: product,
            quantity: quantity,
            onIncrease: () {
              ref.read(cartProvider.notifier).add(product);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('${product.name} ajouté (+1)')),
              );
            },
            onDecrease: () {
              ref.read(cartProvider.notifier).remove(product);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('${product.name} retiré (-1)')),
              );
            },
            onRemove: () {
              ref.read(cartProvider.notifier).removeProduct(product);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('${product.name} supprimé du panier')),
              );
            },
          )
          ;
        }).toList(),
      ),
    );
  }
}
