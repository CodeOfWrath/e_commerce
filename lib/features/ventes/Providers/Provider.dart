import 'package:e_commerce/features/ventes/Models/Produit.dart';
import 'package:e_commerce/features/ventes/data/datasourses/product_local_datasource.dart';
import 'package:e_commerce/features/ventes/data/datasourses/product_remote_datasource.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:e_commerce/core/network/dio_client.dart';
import 'package:e_commerce/features/ventes/domain/repositories/product_repository.dart';
import 'package:e_commerce/features/ventes/data/repositories/product_repository_impl.dart';

// Datasources
final productRemoteDataSourceProvider =
Provider<ProductRemoteDataSource>((ref) {
  final dio = ref.read(dioProvider);
  return ProductRemoteDataSourceImpl(client: dio);
});

final productLocalDataSourceProvider =
Provider<ProductLocalDataSource>((ref) {
  return ProductLocalDataSourceImpl();
});

// Repository
final productRepositoryProvider = Provider<ProductRepository>((ref) {
  return ProductRepositoryImpl(
    remote: ref.read(productRemoteDataSourceProvider),
    local: ref.read(productLocalDataSourceProvider),
  );
});

// FutureProvider pour le catalogue
final productsFutureProvider = FutureProvider<List<Product>>((ref) async {
  final repo = ref.read(productRepositoryProvider);
  return repo.getProducts();
});
