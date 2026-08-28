import 'package:e_commerce/Providers/Provider_Produit.dart';
import 'package:e_commerce/Screens/Page_Catalogue.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() {
  testWidgets('Erreur réseau affiche message et bouton Réessayer', (tester) async {
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          // ✅ Utiliser overrideWith pour FutureProvider
          productProvider.overrideWith((ref) async {
            // Simuler une erreur réseau
            throw Exception('Erreur réseau');
          }),
        ],
        child: MaterialApp(home: CatalogScreen()),
      ),
    );

    // Pump pour laisser l’UI réagir
    await tester.pump();

    // Vérifier que le message d’erreur et le bouton apparaissent
    expect(find.textContaining('Impossible de charger'), findsOneWidget);
    expect(find.text('Réessayer'), findsOneWidget);
  });
}
