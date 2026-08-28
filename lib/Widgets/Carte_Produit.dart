import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../Models/Produit.dart';
import '../Providers/Provider_Carte.dart';
import '../Providers/Provider_Favorit.dart';
import '../screens/page_detail_produit.dart';

class ProductCard extends ConsumerStatefulWidget {
  final Product product;
  const ProductCard({super.key, required this.product});

  @override
  ConsumerState<ProductCard> createState() => _ProductCardState();
}

class _ProductCardState extends ConsumerState<ProductCard>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    _scaleAnimation = Tween<double>(begin: 1.0, end: 1.3).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOut),
    );
  }

  void _animateCart() async {
    await _controller.forward();
    await _controller.reverse();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final favorites = ref.watch(favoritesProvider);

    return Card(
      child: ListTile(
        leading: Hero(
          tag: widget.product.id,
          child: Image.network(widget.product.imageUrl, width: 60, height: 60),
        ),
        title: Text(widget.product.name),
        subtitle: Text('${widget.product.price} € • ${widget.product.category}'),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              icon: Icon(
                favorites.contains(widget.product.id)
                    ? Icons.favorite
                    : Icons.favorite_border,
                color: favorites.contains(widget.product.id) ? Colors.red : null,
              ),
              onPressed: () => ref
                  .read(favoritesProvider.notifier)
                  .toggleFavorite(widget.product.id),
            ),
            IconButton(
              icon: const Icon(Icons.add_shopping_cart),
              onPressed: () {
                ref.read(cartProvider.notifier).add(widget.product);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('${widget.product.name} ajouté au panier')),
                );
              },
            ),
          ],
        ),
        // ✅ Navigation vers la page détail
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => PageDetailProduit(product: widget.product),
            ),
          );
        },
      )
      ,
    );
  }
}
