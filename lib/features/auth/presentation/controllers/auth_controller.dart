import 'package:flutter_riverpod/legacy.dart';
import '../../domain/usecases/login.dart';
import '../../domain/usecases/register.dart';
import '../../domain/usecases/logout.dart';
import '../../domain/repositories/auth_repository.dart';
import '../../domain/entities/user.dart';

class AuthController extends StateNotifier<AuthState> {
  final Login loginUsecase;
  final Register registerUsecase;
  final Logout logoutUsecase;
  final AuthRepository authRepository;

  AuthController({
    required this.loginUsecase,
    required this.registerUsecase,
    required this.logoutUsecase,
    required this.authRepository,
  }) : super(AuthState(isLoading: false, user: null, error: null)) {
    authRepository.authStateChanges().listen((user) {
      state = state.copyWith(user: user);
    });
  }

  Future<void> login(String email, String password) async {
    state = state.copyWith(isLoading: true, error: null);

    try {
      final user = await loginUsecase(email, password);
      state = state.copyWith(isLoading: false, user: user);
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString());
    }
  }

  Future<void> register(String email, String password) async {
    state = state.copyWith(isLoading: true, error: null);

    try {
      final user = await registerUsecase(email, password);
      state = state.copyWith(isLoading: false, user: user);
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString());
    }
  }

  Future<void> logout() async {
    await logoutUsecase();
    state = state.copyWith(user: null);
  }
}
