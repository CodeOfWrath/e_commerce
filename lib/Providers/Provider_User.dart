import 'package:flutter_riverpod/legacy.dart';
import 'package:shared_preferences/shared_preferences.dart';

class User {
  final String id;
  final String name;
  final String email;
  final String city;

  User({
    required this.id,
    required this.name,
    required this.email,
    required this.city,
  });

  User copyWith({String? name, String? email, String? city}) {
    return User(
      id: id,
      name: name ?? this.name,
      email: email ?? this.email,
      city: city ?? this.city,
    );
  }
}

class UserNotifier extends StateNotifier<User> {
  UserNotifier() : super(User(id: 'u1', name: 'Utilisateur Mock', email: 'user@example.com', city: 'Yaoundé')) {
    _loadUser();
  }

  Future<void> _loadUser() async {
    final prefs = await SharedPreferences.getInstance();
    final name = prefs.getString('user_name');
    final email = prefs.getString('user_email');
    final city = prefs.getString('user_city');

    if (name != null || email != null || city != null) {
      state = state.copyWith(
        name: name ?? state.name,
        email: email ?? state.email,
        city: city ?? state.city,
      );
    }
  }

  Future<void> updateName(String newName) async {
    state = state.copyWith(name: newName);
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('user_name', newName);
  }

  Future<void> updateEmail(String newEmail) async {
    state = state.copyWith(email: newEmail);
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('user_email', newEmail);
  }

  Future<void> updateCity(String newCity) async {
    state = state.copyWith(city: newCity);
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('user_city', newCity);
  }
}

final userProvider = StateNotifierProvider<UserNotifier, User>((ref) {
  return UserNotifier();
});
