import 'package:hive/hive.dart';
import '../models/product_model.dart';
import '../../domain/entities/product_entity.dart';
import '../../../../core/error/exceptions.dart';

abstract class ProductLocalDataSource {
  Future<void> cacheProducts(List<Product> products);
  Future<List<ProductModel>> getCachedProducts();
  Future<void> clearCache();
}

class ProductLocalDataSourceImpl implements ProductLocalDataSource {
  static const String boxName = 'products_box';

  Box get _box {
    if (!Hive.isBoxOpen(boxName)) {
      throw CacheException('Box Hive $boxName non ouverte.');
    }
    return Hive.box(boxName);
  }

  @override
  Future<void> cacheProducts(List<Product> products) async {
    try {
      final jsonList = products.map((p) {
        if (p is ProductModel) return p.toJson();
        return ProductModel(
          id: p.id,
          name: p.name,
          description: p.description,
          price: p.price,
          imageUrl: p.imageUrl,
          category: p.category,
          rating: p.rating,
        ).toJson();
      }).toList();

      await _box.put('cached_products_list', jsonList);
    } catch (e) {
      throw CacheException('Erreur lors de la sauvegarde du cache produits: $e');
    }
  }

  @override
  Future<List<ProductModel>> getCachedProducts() async {
    try {
      final data = _box.get('cached_products_list');
      if (data == null) {
        throw CacheException('Aucun produit en cache');
      }

      final List<dynamic> jsonList = data as List<dynamic>;
      return jsonList.map((json) {
        return ProductModel.fromJson(Map<String, dynamic>.from(json as Map));
      }).toList();
    } catch (e) {
      if (e is CacheException) rethrow;
      throw CacheException('Erreur de lecture du cache local: $e');
    }
  }

  @override
  Future<void> clearCache() async {
    try {
      await _box.delete('cached_products_list');
    } catch (e) {
      throw CacheException('Erreur lors de la suppression du cache: $e');
    }
  }
}
