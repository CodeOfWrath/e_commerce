import 'package:hive/hive.dart';
import '../models/user_model.dart';
import '../../../../core/error/exceptions.dart';

abstract class AuthLocalDataSource {
  Future<void> saveAuthData(UserModel user, String accessToken, String refreshToken);
  Future<UserModel?> getSavedUser();
  Future<String?> getAccessToken();
  Future<String?> getRefreshToken();
  Future<void> clearAuthData();
}

class AuthLocalDataSourceImpl implements AuthLocalDataSource {
  static const String boxName = 'auth';

  Box get _box {
    if (!Hive.isBoxOpen(boxName)) {
      throw CacheException('Le stockage local auth n\'est pas ouvert.');
    }
    return Hive.box(boxName);
  }

  @override
  Future<void> saveAuthData(UserModel user, String accessToken, String refreshToken) async {
    try {
      await _box.put('accessToken', accessToken);
      await _box.put('refreshToken', refreshToken);
      await _box.put('user', user.toJson());
    } catch (e) {
      throw CacheException('Impossible de sauvegarder les données utilisateur en cache: $e');
    }
  }

  @override
  Future<UserModel?> getSavedUser() async {
    try {
      final data = _box.get('user');
      if (data == null) return null;

      if (data is Map) {
        final map = Map<String, dynamic>.from(data);
        return UserModel.fromJson(map);
      }
      return null;
    } catch (e) {
      throw CacheException('Erreur lors de la lecture du profil utilisateur en cache');
    }
  }

  @override
  Future<String?> getAccessToken() async {
    return _box.get('accessToken')?.toString();
  }

  @override
  Future<String?> getRefreshToken() async {
    return _box.get('refreshToken')?.toString();
  }

  @override
  Future<void> clearAuthData() async {
    try {
      await _box.delete('accessToken');
      await _box.delete('refreshToken');
      await _box.delete('user');
    } catch (e) {
      throw CacheException('Erreur lors du nettoyage de la session locale');
    }
  }
}
