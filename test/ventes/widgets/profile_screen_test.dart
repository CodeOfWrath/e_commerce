import 'package:e_commerce/features/ventes/Screens/Page_Profil.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('Mise à jour du profil affiche SnackBar', (tester) async {
    SharedPreferences.setMockInitialValues({});

    await tester.pumpWidget(
      const ProviderScope(
        child: MaterialApp(
          home: ProfileScreen(),
        ),
      ),
    );

    await tester.pumpAndSettle();

    await tester.enterText(find.byType(TextField).first, 'Mica');
    await tester.tap(find.text('Enregistrer'));
    await tester.pumpAndSettle();

    expect(find.textContaining('Profil mis à jour'), findsOneWidget);
  });
}
