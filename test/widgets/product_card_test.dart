import 'package:e_commerce/Models/Produit.dart';
import 'package:e_commerce/Widgets/Carte_Produit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  final product = Product(
    id: '1',
    name: 'T-shirt',
    price: 19.99,
    imageUrl: 'url',
    category: 'Vêtements',
  );

  testWidgets('Ajout au panier affiche SnackBar', (tester) async {
    await tester.pumpWidget(
      ProviderScope(
        child: MaterialApp(
          home: Scaffold(body: ProductCard(product: product)),
        ),
      ),
    );

    await tester.tap(find.byIcon(Icons.add_shopping_cart));
    await tester.pump(); // laisse le temps au SnackBar d’apparaître

    expect(find.textContaining('ajouté au panier'), findsOneWidget);
  });
}
