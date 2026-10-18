
import '../../Models/Produit.dart';
import '../../domain/repositories/product_repository.dart';
import '../datasourses/product_local_datasource.dart';
import '../datasourses/product_remote_datasource.dart';

class ProductRepositoryImpl implements ProductRepository {
  final ProductRemoteDataSource remote;
  final ProductLocalDataSource local;

  ProductRepositoryImpl({
    required this.remote,
    required this.local,
  });

  @override
  Future<List<Product>> getProducts() async {
    try {
      final products = await remote.fetchProducts();   // ✔ Future
      //await local.cacheProducts(products);             // ✔ Future
      return products;                                 // ✔ OK
    } catch (_) {
      //final cached = await local.getCachedProducts();  // ✔ Future
      // if (cached.isNotEmpty) {
      //   return cached;                                 // ✔ OK
      // }
      rethrow;
    }
  }
}
