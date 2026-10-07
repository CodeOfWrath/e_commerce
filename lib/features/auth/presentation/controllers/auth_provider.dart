import 'package:e_commerce/features/auth/data/datasources/auth_remote_datasource.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:firebase_auth/firebase_auth.dart';

// Remote datasource Firebase
final authRemoteDataSourceProvider = Provider<AuthRemoteDataSource>((ref) {
  return AuthRemoteDataSourceImpl(
    firebaseAuth: FirebaseAuth.instance,
  );
});

// Stream Firebase User (firebase_auth.User)
final firebaseAuthStateProvider = StreamProvider<User?>((ref) {
  return FirebaseAuth.instance.authStateChanges();
});
