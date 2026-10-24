import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/network/dio_client.dart';
import '../../../core/network/network_info.dart';
import '../data/datasources/product_remote_datasource.dart';
import '../data/datasources/product_local_datasource.dart';
import '../data/repositories/product_repository_impl.dart';
import '../domain/entities/product_entity.dart';
import '../domain/repositories/product_repository.dart';

final networkInfoProvider = Provider<NetworkInfo>((ref) {
  return NetworkInfoImpl();
});

final productRemoteDataSourceProvider = Provider<ProductRemoteDataSource>((ref) {
  return ProductRemoteDataSourceImpl(dio: DioClient.instance);
});

final productLocalDataSourceProvider = Provider<ProductLocalDataSource>((ref) {
  return ProductLocalDataSourceImpl();
});

final productRepositoryProvider = Provider<ProductRepository>((ref) {
  return ProductRepositoryImpl(
    remote: ref.watch(productRemoteDataSourceProvider),
    local: ref.watch(productLocalDataSourceProvider),
    networkInfo: ref.watch(networkInfoProvider),
  );
});

final productProvider = FutureProvider<List<Product>>((ref) async {
  final repository = ref.watch(productRepositoryProvider);
  return await repository.getProducts();
});
