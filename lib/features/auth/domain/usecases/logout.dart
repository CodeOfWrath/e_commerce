// lib/features/auth/domain/usecases/logout.dart
import '../repositories/auth_repository.dart';

class Logout {
  final AuthRepository repository;
  Logout(this.repository);

  Future<void> call() => repository.logout();
}
