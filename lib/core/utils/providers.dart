import 'package:flutter_riverpod/flutter_riverpod.dart';

// Firebase User (alias)
import 'package:firebase_auth/firebase_auth.dart' as fb;

// DOMAIN
import 'package:e_commerce/features/auth/domain/entities/user.dart';
import 'package:e_commerce/features/auth/domain/repositories/auth_repository.dart';
import 'package:e_commerce/features/auth/domain/usecases/login.dart';
import 'package:e_commerce/features/auth/domain/usecases/register.dart';
import 'package:e_commerce/features/auth/domain/usecases/logout.dart';

// DATA
import 'package:e_commerce/features/auth/data/datasources/auth_remote_datasource.dart';
import 'package:e_commerce/features/auth/data/repositories/auth_repository_impl.dart';

// PRESENTATION
import 'package:e_commerce/features/auth/presentation/controllers/auth_controller.dart';
import 'package:flutter_riverpod/legacy.dart';


// ---------------------- AUTH ----------------------

// Remote datasource (Firebase)
final authRemoteDataSourceProvider = Provider<AuthRemoteDataSource>((ref) {
  return AuthRemoteDataSourceImpl(
    firebaseAuth: fb.FirebaseAuth.instance,
  );
});

// Repository
final authRepositoryProvider = Provider<AuthRepository>((ref) {
  return AuthRepositoryImpl(ref.read(authRemoteDataSourceProvider));
});

// Usecases
final loginUsecaseProvider = Provider<Login>((ref) {
  return Login(ref.read(authRepositoryProvider));
});

final registerUsecaseProvider = Provider<Register>((ref) {
  return Register(ref.read(authRepositoryProvider));
});

final logoutUsecaseProvider = Provider<Logout>((ref) {
  return Logout(ref.read(authRepositoryProvider));
});

// Controller
final authControllerProvider =
StateNotifierProvider<AuthController, AuthState>((ref) {
  return AuthController(
    loginUsecase: ref.read(loginUsecaseProvider),
    registerUsecase: ref.read(registerUsecaseProvider),
    logoutUsecase: ref.read(logoutUsecaseProvider),
    authRepository: ref.read(authRepositoryProvider),
  );
});

// Firebase Stream (firebase_auth.User)
final firebaseAuthStateProvider = StreamProvider<fb.User?>((ref) {
  return fb.FirebaseAuth.instance.authStateChanges();
});
