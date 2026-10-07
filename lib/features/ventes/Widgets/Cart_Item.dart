import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../Models/Produit.dart';
import '../Providers/Provider_Carte.dart';

class CartItem extends ConsumerWidget {
  final Product product;
  final int quantity;
  const CartItem({super.key, required this.product, required this.quantity});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ListTile(
      leading: Image.network(product.imageUrl),
      title: Text(product.name),
      subtitle: Text('Quantité: $quantity'),
      trailing: IconButton(
        icon: const Icon(Icons.remove_circle),
        onPressed: () => ref.read(cartProvider.notifier).remove(product),
      ),
    );
  }
}
