import 'package:e_commerce/Screens/Page_Catalogue.dart';
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
}
