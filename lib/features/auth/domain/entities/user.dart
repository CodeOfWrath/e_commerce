

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

class User {
  final String id;
  final String email;

  User({required this.id, required this.email});
}
