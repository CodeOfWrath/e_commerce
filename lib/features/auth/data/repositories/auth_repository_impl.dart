import '../../domain/entities/user.dart';
import '../../domain/repositories/auth_repository.dart';
import '../datasources/auth_remote_datasource.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource remote;

  AuthRepositoryImpl(this.remote);

  @override
  Future<User> login(String email, String password) async {
    final model = await remote.login(email, password);
    return User(id: model.id, email: model.email);
  }

  @override
  Future<User> register(String email, String password) async {
    final model = await remote.register(email, password);
    return User(id: model.id, email: model.email);
  }

  @override
  Future<void> logout() => remote.logout();

  @override
  Stream<User?> authStateChanges() {
    return remote.authStateChanges().map((model) {
      if (model == null) return null;
      return User(id: model.id, email: model.email);
    });
  }
}
