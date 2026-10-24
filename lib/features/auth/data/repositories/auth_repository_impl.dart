import 'dart:async';
import '../../domain/entities/user.dart';
import '../../domain/repositories/auth_repository.dart';
import '../datasources/auth_remote_datasource.dart';
import '../datasources/auth_local_datasource.dart';
import '../../../../core/error/exceptions.dart';
import '../../../../core/error/failures.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource remote;
  final AuthLocalDataSource local;
  final _authStateController = StreamController<User?>.broadcast();

  AuthRepositoryImpl({
    required this.remote,
    required this.local,
  }) {
    _initAuthState();
  }

  Future<void> _initAuthState() async {
    try {
      final savedUser = await local.getSavedUser();
      _authStateController.add(savedUser);
    } catch (_) {
      _authStateController.add(null);
    }
  }

  @override
  Future<User> login(String usernameOrEmail, String password) async {
    try {
      final model = await remote.login(usernameOrEmail, password);
      final accessToken = model.accessToken ?? '';
      final refreshToken = model.refreshToken ?? '';

      await local.saveAuthData(model, accessToken, refreshToken);
      _authStateController.add(model);
      return model;
    } on UnauthorizedException catch (e) {
      throw UnauthorizedFailure(e.message);
    } on ServerException catch (e) {
      throw ServerFailure(e.message);
    } catch (e) {
      throw ServerFailure('Erreur inattendue lors de la connexion: $e');
    }
  }

  @override
  Future<User> register(String email, String password, {String username = ''}) async {
    try {
      final model = await remote.register(email, password, username: username);
      final accessToken = model.accessToken ?? 'mock_access_token';
      final refreshToken = model.refreshToken ?? 'mock_refresh_token';

      await local.saveAuthData(model, accessToken, refreshToken);
      _authStateController.add(model);
      return model;
    } on ServerException catch (e) {
      throw ServerFailure(e.message);
    } catch (e) {
      throw ServerFailure('Erreur inattendue lors de l\'inscription: $e');
    }
  }

  @override
  Future<void> logout() async {
    try {
      await remote.logout();
    } catch (_) {}
    await local.clearAuthData();
    _authStateController.add(null);
  }

  @override
  Future<User?> getCurrentUser() async {
    try {
      final token = await local.getAccessToken();
      if (token != null && token.isNotEmpty) {
        final remoteUser = await remote.getCurrentUser(token);
        if (remoteUser != null) {
          return remoteUser;
        }
      }
      return await local.getSavedUser();
    } catch (_) {
      return await local.getSavedUser();
    }
  }

  @override
  Stream<User?> authStateChanges() => _authStateController.stream;
}
