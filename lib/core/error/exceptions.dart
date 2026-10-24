class ServerException implements Exception {
  final String message;
  ServerException([this.message = 'Erreur serveur']);

  @override
  String toString() => message;
}

class CacheException implements Exception {
  final String message;
  CacheException([this.message = 'Erreur de cache']);

  @override
  String toString() => message;
}

class NetworkException implements Exception {
  final String message;
  NetworkException([this.message = 'Pas de connexion réseau']);

  @override
  String toString() => message;
}

class UnauthorizedException implements Exception {
  final String message;
  UnauthorizedException([this.message = 'Non autorisé']);

  @override
  String toString() => message;
}
