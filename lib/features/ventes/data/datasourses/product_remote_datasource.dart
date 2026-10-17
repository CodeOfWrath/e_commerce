import 'package:cloud_firestore/cloud_firestore.dart';
import '../../domain/entities/product.dart';

abstract class ProductRemoteDataSource {
  Future<List<Product>> fetchProducts();
}

class ProductRemoteDataSourceImpl implements ProductRemoteDataSource {
  final FirebaseFirestore firestore;

  ProductRemoteDataSourceImpl({required this.firestore});

  @override
  Future<List<Product>> fetchProducts() async {
    final snapshot = await firestore.collection('products').get();
    return snapshot.docs.map((doc) {
      final data = doc.data();
      return Product(
        id: doc.id,
        title: data['title'] ?? '',
        description: data['description'] ?? '',
        price: (data['price'] as num).toDouble(),
        imageUrl: data['imageUrl'] ?? '',
        category: data['category'] ?? '',
      );
    }).toList();
  }
}
