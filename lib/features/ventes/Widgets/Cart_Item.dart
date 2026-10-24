import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../domain/entities/product_entity.dart';
import '../Providers/Provider_Carte.dart';

class CartItemWidget extends ConsumerWidget {
  final Product product;
  final int quantity;
  const CartItemWidget({super.key, required this.product, required this.quantity});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ListTile(
      leading: SizedBox(
        width: 45,
        height: 45,
        child: product.imageUrl.startsWith('http')
            ? Image.network(
                product.imageUrl,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) => const Icon(Icons.shopping_bag),
              )
            : const Icon(Icons.shopping_bag),
      ),
      title: Text(product.name),
      subtitle: Text('${product.price.toStringAsFixed(2)} € x $quantity = ${(product.price * quantity).toStringAsFixed(2)} €'),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          IconButton(
            icon: const Icon(Icons.remove_circle_outline),
            onPressed: () => ref.read(cartProvider.notifier).remove(product),
          ),
          Text('$quantity', style: const TextStyle(fontWeight: FontWeight.bold)),
          IconButton(
            icon: const Icon(Icons.add_circle_outline),
            onPressed: () => ref.read(cartProvider.notifier).add(product),
          ),
        ],
      ),
    );
  }
}
