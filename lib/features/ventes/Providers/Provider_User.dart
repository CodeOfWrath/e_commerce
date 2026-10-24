import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserProfile {
  final String id;
  final String name;
  final String email;
  final String city;

  UserProfile({
    required this.id,
    required this.name,
    required this.email,
    required this.city,
  });

  UserProfile copyWith({String? name, String? email, String? city}) {
    return UserProfile(
      id: id,
      name: name ?? this.name,
      email: email ?? this.email,
      city: city ?? this.city,
    );
  }
}

class UserNotifier extends Notifier<UserProfile> {
  @override
  UserProfile build() {
    loadUser();
    return UserProfile(
      id: 'u1',
      name: 'Jean Dupont',
      email: 'jean.dupont@example.com',
      city: 'Paris',
    );
  }

  Future<void> loadUser() async {
    try {
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
    } catch (_) {}
  }

  Future<void> updateName(String newName) async {
    state = state.copyWith(name: newName);
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('user_name', newName);
    } catch (_) {}
  }

  Future<void> updateEmail(String newEmail) async {
    state = state.copyWith(email: newEmail);
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('user_email', newEmail);
    } catch (_) {}
  }

  Future<void> updateCity(String newCity) async {
    state = state.copyWith(city: newCity);
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('user_city', newCity);
    } catch (_) {}
  }

  Future<void> clearProfile() async {
    state = UserProfile(
      id: 'u1',
      name: 'Jean Dupont',
      email: 'jean.dupont@example.com',
      city: 'Paris',
    );
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.remove('user_name');
      await prefs.remove('user_email');
      await prefs.remove('user_city');
    } catch (_) {}
  }
}

final userProvider = NotifierProvider<UserNotifier, UserProfile>(
  UserNotifier.new,
);
