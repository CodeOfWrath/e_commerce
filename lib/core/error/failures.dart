abstract class Failure {
  final String message;
  const Failure(this.message);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Failure && runtimeType == other.runtimeType && message == other.message;

  @override
  int get hashCode => message.hashCode;

  @override
  String toString() => message;
}

class ServerFailure extends Failure {
  const ServerFailure([super.message = 'Erreur lors de la communication avec le serveur']);
}

class CacheFailure extends Failure {
  const CacheFailure([super.message = 'Aucune donnée en cache disponible']);
}

class NetworkFailure extends Failure {
  const NetworkFailure([super.message = 'Veuillez vérifier votre connexion Internet']);
}

class UnauthorizedFailure extends Failure {
  const UnauthorizedFailure([super.message = 'Session expirée ou identifiants invalides']);
}
