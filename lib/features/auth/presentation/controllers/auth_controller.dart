import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/usecases/login.dart';
import '../../domain/usecases/register.dart';
import '../../domain/usecases/logout.dart';
import '../../domain/repositories/auth_repository.dart';
import '../../domain/entities/user.dart';
import '../../../../core/utils/providers.dart';

class AuthController extends Notifier<AuthState> {
  Login? _loginUsecase;
  Register? _registerUsecase;
  Logout? _logoutUsecase;
  AuthRepository? _authRepository;
  StreamSubscription<User?>? _authSubscription;

  @override
  AuthState build() {
    _loginUsecase = ref.watch(loginUsecaseProvider);
    _registerUsecase = ref.watch(registerUsecaseProvider);
    _logoutUsecase = ref.watch(logoutUsecaseProvider);
    _authRepository = ref.watch(authRepositoryProvider);

    _init();

    ref.onDispose(() {
      _authSubscription?.cancel();
    });

    return const AuthState(isLoading: false, user: null, error: null);
  }

  Future<void> _init() async {
    if (_authRepository == null) return;

    _authSubscription = _authRepository!.authStateChanges().listen((user) {
      state = state.copyWith(user: user, isLoading: false);
    });

    try {
      final currentUser = await _authRepository!.getCurrentUser();
      if (currentUser != null) {
        state = state.copyWith(user: currentUser);
      }
    } catch (_) {}
  }

  Future<void> login(String usernameOrEmail, String password) async {
    state = state.copyWith(isLoading: true, error: null);

    try {
      final loginFn = _loginUsecase ?? Login(ref.read(authRepositoryProvider));
      final user = await loginFn(usernameOrEmail, password);
      state = state.copyWith(isLoading: false, user: user, error: null);
    } catch (e) {
      final errorMessage = e
          .toString()
          .replaceAll('Exception: ', '')
          .replaceAll('ServerFailure: ', '')
          .replaceAll('UnauthorizedFailure: ', '');
      state = state.copyWith(isLoading: false, error: errorMessage);
    }
  }

  Future<void> register(String email, String password, {String username = ''}) async {
    state = state.copyWith(isLoading: true, error: null);

    try {
      final regFn = _registerUsecase ?? Register(ref.read(authRepositoryProvider));
      final user = await regFn(email, password, username: username);
      state = state.copyWith(isLoading: false, user: user, error: null);
    } catch (e) {
      final errorMessage = e.toString().replaceAll('Exception: ', '').replaceAll('ServerFailure: ', '');
      state = state.copyWith(isLoading: false, error: errorMessage);
    }
  }

  Future<void> logout() async {
    state = state.copyWith(isLoading: true);
    final logoutFn = _logoutUsecase ?? Logout(ref.read(authRepositoryProvider));
    await logoutFn();
    state = const AuthState(isLoading: false, user: null, error: null);
  }
}

final authControllerProvider = NotifierProvider<AuthController, AuthState>(
  AuthController.new,
);
