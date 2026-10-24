import '../entities/user.dart';

abstract class AuthRepository {
  Future<User> login(String usernameOrEmail, String password);
  Future<User> register(String email, String password, {String username});
  Future<void> logout();
  Future<User?> getCurrentUser();
  Stream<User?> authStateChanges();
}
