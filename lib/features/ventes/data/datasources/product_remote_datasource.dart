import 'package:dio/dio.dart';
import '../models/product_model.dart';
import '../../../../core/error/exceptions.dart';

abstract class ProductRemoteDataSource {
  Future<List<ProductModel>> fetchProducts();
  Future<ProductModel> getProductById(String id);
}

class ProductRemoteDataSourceImpl implements ProductRemoteDataSource {
  final Dio dio;

  ProductRemoteDataSourceImpl({required this.dio});

  @override
  Future<List<ProductModel>> fetchProducts() async {
    try {
      final response = await dio.get('/products?limit=100');

      if (response.statusCode == 200 && response.data != null) {
        final data = response.data;
        final List<dynamic> productsJson = data is Map ? (data['products'] ?? []) : data;

        return productsJson
            .map((json) => ProductModel.fromJson(Map<String, dynamic>.from(json)))
            .toList();
      } else {
        throw ServerException('Erreur de récupération des produits (${response.statusCode})');
      }
    } on DioException catch (e) {
      throw ServerException(e.message ?? 'Erreur réseau lors du chargement des produits');
    } catch (e) {
      if (e is Exception) rethrow;
      throw ServerException(e.toString());
    }
  }

  @override
  Future<ProductModel> getProductById(String id) async {
    try {
      final response = await dio.get('/products/$id');

      if (response.statusCode == 200 && response.data != null) {
        return ProductModel.fromJson(Map<String, dynamic>.from(response.data));
      } else {
        throw ServerException('Produit non trouvé ($id)');
      }
    } on DioException catch (e) {
      throw ServerException(e.message ?? 'Erreur lors du chargement du produit');
    } catch (e) {
      if (e is Exception) rethrow;
      throw ServerException(e.toString());
    }
  }
}
