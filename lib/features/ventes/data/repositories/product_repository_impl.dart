import 'package:e_commerce/features/ventes/data/datasourses/product_remote_datasource.dart';

import '../../domain/entities/product.dart';
import '../../domain/repositories/product_repository.dart';

class ProductRepositoryImpl implements ProductRepository {
  final ProductRemoteDataSource remote;

  ProductRepositoryImpl({required this.remote});

  @override
  Future<List<Product>> getProducts() async {
    return remote.fetchProducts();
  }
}
