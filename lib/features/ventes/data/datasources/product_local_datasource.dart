import 'package:hive/hive.dart';
import '../../domain/entities/product_entity.dart';

abstract class ProductLocalDataSource {
  Future<void> cacheProducts(List<Product> products);
  Future<List<Product>> getCachedProducts();
}

class ProductLocalDataSourceImpl implements ProductLocalDataSource {
  static const String boxName = 'products_box';

  @override
  Future<void> cacheProducts(List<Product> products) async {
    final box = await Hive.openBox(boxName);
    await box.put(
      'products',
      products
          .map((p) => {
        'id': p.id,
        'name': p.name,
        'price': p.price,
        'imageUrl': p.imageUrl,
        'category': p.category,
      })
          .toList(),
    );
  }

  @override
  Future<List<Product>> getCachedProducts() async {
    final box = await Hive.openBox(boxName);
    final data = box.get('products') as List<dynamic>?;

    if (data == null) return [];

    return data.map((json) {
      return Product(
        id: json['id'] as String,
        name: json['name'] as String,
        price: (json['price'] as num).toDouble(),
        imageUrl: json['imageUrl'] as String,
        category: json['category'] as String,
      );
    }).toList();
  }
}
