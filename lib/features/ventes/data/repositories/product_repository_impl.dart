import '../../domain/entities/product_entity.dart';
import '../../domain/repositories/product_repository.dart';
import '../datasources/product_remote_datasource.dart';
import '../datasources/product_local_datasource.dart';
import '../../../../core/network/network_info.dart';
import '../../../../core/error/exceptions.dart';
import '../../../../core/error/failures.dart';

class ProductRepositoryImpl implements ProductRepository {
  final ProductRemoteDataSource remote;
  final ProductLocalDataSource local;
  final NetworkInfo networkInfo;

  ProductRepositoryImpl({
    required this.remote,
    required this.local,
    required this.networkInfo,
  });

  @override
  Future<List<Product>> getProducts() async {
    final isConnected = await networkInfo.isConnected;

    if (isConnected) {
      try {
        final remoteProducts = await remote.fetchProducts();
        await local.cacheProducts(remoteProducts);
        return remoteProducts;
      } on ServerException catch (e) {
        return await _getFallbackCache(e.message);
      } catch (e) {
        return await _getFallbackCache(e.toString());
      }
    } else {
      return await _getFallbackCache('Mode hors-ligne : pas de connexion réseau');
    }
  }

  Future<List<Product>> _getFallbackCache(String originalError) async {
    try {
      final cachedProducts = await local.getCachedProducts();
      if (cachedProducts.isNotEmpty) {
        return cachedProducts;
      } else {
        throw const CacheFailure('Aucune donnée en cache disponible');
      }
    } on CacheException catch (e) {
      throw CacheFailure(e.message);
    } catch (_) {
      throw const CacheFailure('Aucune donnée en cache disponible');
    }
  }

  @override
  Future<Product> getProductById(String id) async {
    final isConnected = await networkInfo.isConnected;

    if (isConnected) {
      try {
        return await remote.getProductById(id);
      } catch (_) {
        return await _getFallbackProductFromCache(id);
      }
    } else {
      return await _getFallbackProductFromCache(id);
    }
  }

  Future<Product> _getFallbackProductFromCache(String id) async {
    try {
      final cached = await local.getCachedProducts();
      final match = cached.firstWhere((p) => p.id == id);
      return match;
    } catch (_) {
      throw const CacheFailure('Produit non trouvé en cache');
    }
  }
}
