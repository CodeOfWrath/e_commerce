import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:e_commerce/core/network/dio_client.dart';
import 'package:e_commerce/core/network/network_info.dart';

// AUTH
import 'package:e_commerce/features/auth/domain/repositories/auth_repository.dart';
import 'package:e_commerce/features/auth/domain/usecases/login.dart';
import 'package:e_commerce/features/auth/domain/usecases/register.dart';
import 'package:e_commerce/features/auth/domain/usecases/logout.dart';
import 'package:e_commerce/features/auth/domain/usecases/get_current_user.dart';
import 'package:e_commerce/features/auth/data/datasources/auth_remote_datasource.dart';
import 'package:e_commerce/features/auth/data/datasources/auth_local_datasource.dart';
import 'package:e_commerce/features/auth/data/repositories/auth_repository_impl.dart';

// RE-EXPORTS
export 'package:e_commerce/features/ventes/Providers/Provider_Produit.dart';
export 'package:e_commerce/features/ventes/Providers/Provider_catalogue.dart';
export 'package:e_commerce/features/ventes/Providers/Provider_Carte.dart';
export 'package:e_commerce/features/ventes/Providers/Provider_Favorit.dart';
export 'package:e_commerce/features/ventes/Providers/Provider_Filtre.dart';
export 'package:e_commerce/features/ventes/Providers/Provider_User.dart';
export 'package:e_commerce/features/auth/presentation/controllers/auth_controller.dart';

// ---------------------- AUTH PROVIDERS ----------------------

final networkInfoProvider = Provider<NetworkInfo>((ref) => NetworkInfoImpl());

final authRemoteDataSourceProvider = Provider<AuthRemoteDataSource>((ref) {
  return AuthRemoteDataSourceImpl(dio: DioClient.instance);
});

final authLocalDataSourceProvider = Provider<AuthLocalDataSource>((ref) {
  return AuthLocalDataSourceImpl();
});

final authRepositoryProvider = Provider<AuthRepository>((ref) {
  return AuthRepositoryImpl(
    remote: ref.watch(authRemoteDataSourceProvider),
    local: ref.watch(authLocalDataSourceProvider),
  );
});

final loginUsecaseProvider = Provider<Login>((ref) {
  return Login(ref.watch(authRepositoryProvider));
});

final registerUsecaseProvider = Provider<Register>((ref) {
  return Register(ref.watch(authRepositoryProvider));
});

final logoutUsecaseProvider = Provider<Logout>((ref) {
  return Logout(ref.watch(authRepositoryProvider));
});

final getCurrentUserUsecaseProvider = Provider<GetCurrentUser>((ref) {
  return GetCurrentUser(ref.watch(authRepositoryProvider));
});
