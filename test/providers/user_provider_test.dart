import 'package:e_commerce/Providers/Provider_User.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('Mise à jour du nom utilisateur', () {
    final notifier = UserNotifier();
    notifier.updateName('Mica');
    expect(notifier.state.name, 'Mica');
  });

  test('Mise à jour de l’email utilisateur', () {
    final notifier = UserNotifier();
    notifier.updateEmail('mica@example.com');
    expect(notifier.state.email, 'mica@example.com');
  });

  test('Mise à jour de la ville utilisateur', () {
    final notifier = UserNotifier();
    notifier.updateCity('Yaoundé');
    expect(notifier.state.city, 'Yaoundé');
  });
}
