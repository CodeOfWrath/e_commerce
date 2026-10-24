class User {
  final String id;
  final String email;
  final String username;
  final String firstName;
  final String lastName;
  final String image;
  final String? accessToken;
  final String? refreshToken;

  const User({
    required this.id,
    required this.email,
    this.username = '',
    this.firstName = '',
    this.lastName = '',
    this.image = '',
    this.accessToken,
    this.refreshToken,
  });

  String get fullName {
    if (firstName.isEmpty && lastName.isEmpty) return username.isNotEmpty ? username : email;
    return '$firstName $lastName'.trim();
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is User &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          email == other.email;

  @override
  int get hashCode => id.hashCode ^ email.hashCode;
}

class AuthState {
  final bool isLoading;
  final User? user;
  final String? error;

  const AuthState({
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
