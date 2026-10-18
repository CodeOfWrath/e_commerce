import '../../Models/Produit.dart';

abstract class ProductRepository {
  Future<List<Product>> getProducts();
}
