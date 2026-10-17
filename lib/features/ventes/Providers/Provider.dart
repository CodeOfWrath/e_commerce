import 'package:e_commerce/features/ventes/Models/Produit.dart';
import 'package:e_commerce/features/ventes/data/datasourses/product_remote_datasource.dart';
import 'package:e_commerce/features/ventes/data/repositories/product_repository_impl.dart';
import 'package:e_commerce/features/ventes/domain/repositories/product_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

// Firestore
final firestoreProvider = Provider<FirebaseFirestore>((ref) {
  return FirebaseFirestore.instance;
});

// Remote datasource
final productRemoteDataSourceProvider =
Provider<ProductRemoteDataSource>((ref) {
  return ProductRemoteDataSourceImpl(
    firestore: ref.read(firestoreProvider),
  );
});

// Repository
final productRepositoryProvider = Provider<ProductRepository>((ref) {
  return ProductRepositoryImpl(
    remote: ref.read(productRemoteDataSourceProvider),
  );
});

// FutureProvider pour le catalogue
final productsFutureProvider = FutureProvider<List<Product>>((ref) async {
  final repo = ref.read(productRepositoryProvider);
  return repo.getProducts();
});
