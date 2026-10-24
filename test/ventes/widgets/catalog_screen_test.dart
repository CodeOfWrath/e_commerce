import 'package:e_commerce/features/ventes/domain/entities/product_entity.dart';
import 'package:e_commerce/features/ventes/Providers/Provider_Produit.dart';
import 'package:e_commerce/features/ventes/Screens/Page_Catalogue.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('Affiche le catalogue et filtre les produits', (tester) async {
    final products = [
      const Product(id: '1', name: 'Chaussures Sport', price: 50, imageUrl: '', category: 'Chaussures'),
      const Product(id: '2', name: 'T-Shirt Bleu', price: 20, imageUrl: '', category: 'Vêtements'),
    ];

    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          productProvider.overrideWith((ref) async => products),
        ],
        child: const MaterialApp(
          home: CatalogScreen(),
        ),
      ),
    );

    await tester.pumpAndSettle();

    expect(find.text('Catalogue REST API'), findsOneWidget);
    expect(find.text('Chaussures Sport'), findsOneWidget);
    expect(find.text('T-Shirt Bleu'), findsOneWidget);
  });
}
