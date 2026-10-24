import 'package:dio/dio.dart';
import '../models/user_model.dart';
import '../../../../core/error/exceptions.dart';

abstract class AuthRemoteDataSource {
  Future<UserModel> login(String usernameOrEmail, String password);
  Future<UserModel> register(String email, String password, {String username});
  Future<UserModel?> getCurrentUser(String token);
  Future<void> logout();
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final Dio dio;

  AuthRemoteDataSourceImpl({required this.dio});

  @override
  Future<UserModel> login(String usernameOrEmail, String password) async {
    try {
      // DummyJSON login uses username, e.g. 'emilys' or 'kminchelle' or custom
      final response = await dio.post(
        '/auth/login',
        data: {
          'username': usernameOrEmail.trim(),
          'password': password.trim(),
          'expiresInMins': 60,
        },
      );

      if (response.statusCode == 200 && response.data != null) {
        return UserModel.fromJson(response.data);
      } else {
        throw ServerException('Échec de la connexion');
      }
    } on DioException catch (e) {
      if (e.response?.statusCode == 400 || e.response?.statusCode == 401) {
        throw UnauthorizedException('Identifiants incorrects');
      }
      throw ServerException(e.message ?? 'Erreur lors de la connexion REST API');
    } catch (e) {
      if (e is Exception) rethrow;
      throw ServerException(e.toString());
    }
  }

  @override
  Future<UserModel> register(String email, String password, {String username = ''}) async {
    try {
      final uname = username.isNotEmpty ? username : email.split('@').first;
      final response = await dio.post(
        '/users/add',
        data: {
          'email': email.trim(),
          'username': uname,
          'password': password.trim(),
          'firstName': uname,
          'lastName': 'User',
        },
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        final data = Map<String, dynamic>.from(response.data);
        // Simulate JWT return on register for test/DummyJSON APIs
        data['accessToken'] = data['accessToken'] ?? 'mock_jwt_access_token_${data['id']}';
        data['refreshToken'] = data['refreshToken'] ?? 'mock_jwt_refresh_token_${data['id']}';
        return UserModel.fromJson(data);
      } else {
        throw ServerException('Échec de la création de compte');
      }
    } on DioException catch (e) {
      throw ServerException(e.message ?? 'Erreur lors de l\'inscription');
    } catch (e) {
      if (e is Exception) rethrow;
      throw ServerException(e.toString());
    }
  }

  @override
  Future<UserModel?> getCurrentUser(String token) async {
    try {
      final response = await dio.get(
        '/auth/me',
        options: Options(headers: {'Authorization': 'Bearer $token'}),
      );

      if (response.statusCode == 200 && response.data != null) {
        return UserModel.fromJson(response.data);
      }
      return null;
    } on DioException catch (e) {
      if (e.response?.statusCode == 401) {
        throw UnauthorizedException('Token expiré');
      }
      throw ServerException(e.message ?? 'Erreur profil');
    } catch (e) {
      if (e is Exception) rethrow;
      throw ServerException(e.toString());
    }
  }

  @override
  Future<void> logout() async {
    // REST API logout stateless or endpoint call
    return;
  }
}
