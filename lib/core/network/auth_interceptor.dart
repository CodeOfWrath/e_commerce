import 'package:dio/dio.dart';
import 'package:hive/hive.dart';

class AuthInterceptor extends Interceptor {
  static const String authBoxName = 'auth_box';

  Future<Box> _openBox() async {
    return Hive.openBox(authBoxName);
  }

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) async {
    final box = await _openBox();
    final token = box.get('access_token') as String?;
    if (token != null) {
      options.headers['Authorization'] = 'Bearer $token';
    }
    super.onRequest(options, handler);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    // Si 401 → tentative de refresh
    if (err.response?.statusCode == 401) {
      final box = await _openBox();
      final refreshToken = box.get('refresh_token') as String?;

      if (refreshToken == null) {
        // Pas de refresh → on nettoie et on laisse l’erreur remonter
        await box.delete('access_token');
        await box.delete('refresh_token');
        handler.next(err);
        return;
      }

      try {
        final dio = Dio(BaseOptions(baseUrl: 'https://ton-api.com')); // à adapter
        final response = await dio.post('/auth/refresh', data: {
          'refresh_token': refreshToken,
        });

        final newAccessToken = response.data['access_token'] as String?;
        final newRefreshToken = response.data['refresh_token'] as String?;

        if (newAccessToken != null) {
          await box.put('access_token', newAccessToken);
        }
        if (newRefreshToken != null) {
          await box.put('refresh_token', newRefreshToken);
        }

        // On rejoue la requête originale avec le nouveau token
        final req = err.requestOptions;
        req.headers['Authorization'] = 'Bearer $newAccessToken';

        final retryDio = Dio(BaseOptions(baseUrl: req.baseUrl));
        final retryResponse = await retryDio.fetch(req);

        handler.resolve(retryResponse);
        return;
      } catch (e) {
        // Refresh échoué → on nettoie et on laisse l’erreur remonter
        await box.delete('access_token');
        await box.delete('refresh_token');
        handler.next(err);
        return;
      }
    }

    super.onError(err, handler);
  }
}
