import 'package:e_commerce/features/ventes/Providers/Provider_User.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() {
    SharedPreferences.setMockInitialValues({});
  });

  test('Mise à jour du nom utilisateur', () async {
    final container = ProviderContainer();
    final notifier = container.read(userProvider.notifier);
    await notifier.updateName('Mica');
    expect(container.read(userProvider).name, 'Mica');
  });

  test('Mise à jour de l’email utilisateur', () async {
    final container = ProviderContainer();
    final notifier = container.read(userProvider.notifier);
    await notifier.updateEmail('mica@example.com');
    expect(container.read(userProvider).email, 'mica@example.com');
  });

  test('Mise à jour de la ville utilisateur', () async {
    final container = ProviderContainer();
    final notifier = container.read(userProvider.notifier);
    await notifier.updateCity('Yaoundé');
    expect(container.read(userProvider).city, 'Yaoundé');
  });
}
