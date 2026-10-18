

import 'package:e_commerce/features/ventes/Providers/Provider_User.dart';

class AuthState {
  final bool isLoading;
  final User? user;
  final String? error;

  AuthState({
    required this.isLoading,
    required this.user,
    this.error,
  });

  AuthState copyWith({
    bool? isLoading,
    User? user,
    String? error,
  }) {
    return AuthState(
      isLoading: isLoading ?? this.isLoading,
      user: user ?? this.user,
      error: error,
    );
  }
}

