// lib/features/auth/domain/usecases/register.dart
import '../entities/user.dart';
import '../repositories/auth_repository.dart';

class Register {
  final AuthRepository repository;
  Register(this.repository);

  Future<User> call(String email, String password) {
    return repository.register(email, password);
  }
}
