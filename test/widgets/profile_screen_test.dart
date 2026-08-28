import 'package:e_commerce/Screens/Page_Profil.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() {
  testWidgets('Mise à jour du profil affiche SnackBar', (tester) async {
    await tester.pumpWidget(ProviderScope(child: MaterialApp(home: ProfileScreen())));
    await tester.enterText(find.byType(TextField).first, 'Mica');
    await tester.tap(find.text('Enregistrer'));
    await tester.pump();
    expect(find.textContaining('Profil mis à jour'), findsOneWidget);
  });
}
