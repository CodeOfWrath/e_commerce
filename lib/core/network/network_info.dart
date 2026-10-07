import 'dart:io';

class NetworkInfo {
  static Future<bool> get isConnected async {
    try {
      final result = await InternetAddress.lookup('google.com');
      return result.isNotEmpty;
    } catch (_) {
      return false;
    }
  }
}
