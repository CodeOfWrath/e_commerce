import 'package:dio/dio.dart';
import '../../domain/entities/product.dart';

abstract class ProductRemoteDataSource {
  Future<List<Product>> fetchProducts();
}

class ProductRemoteDataSourceImpl implements ProductRemoteDataSource {
  final Dio client;

  ProductRemoteDataSourceImpl({required this.client});

  @override
  Future<List<Product>> fetchProducts() async {
    final response = await client.get('/products'); // ex: /products

    if (response.statusCode == 200) {
      final data = response.data as List;
      return data.map((json) {
        return Product(
          id: json['id'].toString(),
          title: json['title'] ?? '',
          description: json['description'] ?? '',
          price: (json['price'] as num).toDouble(),
          imageUrl: json['image'] ?? '',
          category: json['category'] ?? '',
        );
      }).toList();
    } else {
      throw Exception('Erreur API produits');
    }
  }
}
