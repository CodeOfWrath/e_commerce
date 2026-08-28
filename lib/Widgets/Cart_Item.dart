import 'package:flutter/material.dart';
import '../Models/Produit.dart';

class CartItem extends StatelessWidget {
  final Product product;
  final int quantity;
  final VoidCallback onIncrease;
  final VoidCallback onDecrease;
  final VoidCallback onRemove; // ✅ nouveau paramètre

  const CartItem({
    super.key,
    required this.product,
    required this.quantity,
    required this.onIncrease,
    required this.onDecrease,
    required this.onRemove, // ✅ ajouté
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Image.network(product.imageUrl, width: 50, height: 50),
      title: Text(product.name),
      subtitle: Text('Prix: ${product.price} €'),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          IconButton(icon: const Icon(Icons.remove), onPressed: onDecrease),
          Text('$quantity'),
          IconButton(icon: const Icon(Icons.add), onPressed: onIncrease),
          IconButton(
            icon: const Icon(Icons.delete, color: Colors.red),
            onPressed: onRemove,
          ),
        ],
      ),
    );
  }
}
