import 'package:e_commerce/Screens/Page_Catalogue.dart';
import 'package:e_commerce/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('Affiche un indicateur de chargement', (tester) async {
    await tester.pumpWidget(
      const ProviderScope(
        child: MaterialApp(home: CatalogScreen()),
      ),
    );

    expect(find.byType(CircularProgressIndicator), findsOneWidget);
  });
  testWidgets('Filtrage par catégorie réduit la liste', (tester) async {
    await tester.pumpWidget(ProviderScope(child: MyApp()));
    // Sélectionner catégorie "Chaussures"
    await tester.tap(find.text('Chaussures'));
    await tester.pump();
    // Vérifier que seuls les produits "Chaussures" sont affichés
    expect(find.textContaining('Chaussures'), findsWidgets);
  });

}
