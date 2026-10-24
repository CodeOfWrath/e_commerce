import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:e_commerce/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:e_commerce/features/auth/data/datasources/auth_remote_datasource.dart';
import 'package:e_commerce/features/auth/data/datasources/auth_local_datasource.dart';
import 'package:e_commerce/features/auth/data/models/user_model.dart';
import 'package:e_commerce/core/error/exceptions.dart';
import 'package:e_commerce/core/error/failures.dart';

class MockAuthRemoteDataSource extends Mock implements AuthRemoteDataSource {}
class MockAuthLocalDataSource extends Mock implements AuthLocalDataSource {}

void main() {
  late MockAuthRemoteDataSource mockRemote;
  late MockAuthLocalDataSource mockLocal;
  late AuthRepositoryImpl repository;

  setUp(() {
    mockRemote = MockAuthRemoteDataSource();
    mockLocal = MockAuthLocalDataSource();
    when(() => mockLocal.getSavedUser()).thenAnswer((_) async => null);

    repository = AuthRepositoryImpl(
      remote: mockRemote,
      local: mockLocal,
    );
  });

  const tUserModel = UserModel(
    id: '15',
    email: 'kminchelle@qq.com',
    username: 'kminchelle',
    firstName: 'Jeanne',
    lastName: 'Halvorson',
    accessToken: 'valid_access_token',
    refreshToken: 'valid_refresh_token',
  );

  group('login', () {
    test('should return User and save auth data when login is successful', () async {
      // arrange
      when(() => mockRemote.login('kminchelle', '0x8r5e'))
          .thenAnswer((_) async => tUserModel);
      when(() => mockLocal.saveAuthData(tUserModel, 'valid_access_token', 'valid_refresh_token'))
          .thenAnswer((_) async {});

      // act
      final result = await repository.login('kminchelle', '0x8r5e');

      // assert
      expect(result.id, equals('15'));
      expect(result.email, equals('kminchelle@qq.com'));
      verify(() => mockRemote.login('kminchelle', '0x8r5e')).called(1);
      verify(() => mockLocal.saveAuthData(tUserModel, 'valid_access_token', 'valid_refresh_token')).called(1);
    });

    test('should throw UnauthorizedFailure when credentials are invalid', () async {
      // arrange
      when(() => mockRemote.login('wrong', 'wrong'))
          .thenThrow(UnauthorizedException('Identifiants incorrects'));

      // act & assert
      expect(
        () => repository.login('wrong', 'wrong'),
        throwsA(isA<UnauthorizedFailure>()),
      );
    });
  });

  group('logout', () {
    test('should clear local auth data and return void', () async {
      // arrange
      when(() => mockRemote.logout()).thenAnswer((_) async {});
      when(() => mockLocal.clearAuthData()).thenAnswer((_) async {});

      // act
      await repository.logout();

      // assert
      verify(() => mockLocal.clearAuthData()).called(1);
    });
  });
}
