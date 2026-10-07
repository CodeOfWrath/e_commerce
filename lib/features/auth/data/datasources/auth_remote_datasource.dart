import 'package:firebase_auth/firebase_auth.dart';
import '../models/user_model.dart';
import '../../../../core/error/exceptions.dart';

abstract class AuthRemoteDataSource {
  Future<UserModel> login(String email, String password);
  Future<UserModel> register(String email, String password);
  Future<void> logout();
  Stream<UserModel?> authStateChanges();
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final FirebaseAuth firebaseAuth;

  AuthRemoteDataSourceImpl({required this.firebaseAuth});

  @override
  Future<UserModel> login(String email, String password) async {
    final cred = await firebaseAuth.signInWithEmailAndPassword(
      email: email.trim(),
      password: password.trim(),
    );
    final user = cred.user;
    if (user == null) throw ServerException();

    return UserModel(id: user.uid, email: user.email ?? '');
  }

  @override
  Future<UserModel> register(String email, String password) async {
    final cred = await firebaseAuth.createUserWithEmailAndPassword(
      email: email.trim(),
      password: password.trim(),
    );
    final user = cred.user;
    if (user == null) throw ServerException();

    return UserModel(id: user.uid, email: user.email ?? '');
  }

  @override
  Future<void> logout() async {
    await firebaseAuth.signOut();
  }

  @override
  Stream<UserModel?> authStateChanges() {
    return firebaseAuth.authStateChanges().map((user) {
      if (user == null) return null;
      return UserModel(id: user.uid, email: user.email ?? '');
    });
  }
}
