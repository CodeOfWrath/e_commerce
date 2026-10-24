import '../../domain/entities/product_entity.dart';

class ProductModel extends Product {
  const ProductModel({
    required super.id,
    required super.name,
    super.description = '',
    required super.price,
    required super.imageUrl,
    required super.category,
    super.rating = 0.0,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    final id = (json['id'] ?? json['_id'] ?? '').toString();
    final name = (json['title'] ?? json['name'] ?? 'Produit sans nom').toString();
    final description = (json['description'] ?? '').toString();
    final category = (json['category'] ?? 'Divers').toString();
    final imageUrl = (json['thumbnail'] ?? json['imageUrl'] ?? json['image'] ?? '').toString();

    double price = 0.0;
    final rawPrice = json['price'];
    if (rawPrice is num) {
      price = rawPrice.toDouble();
    } else if (rawPrice is String) {
      price = double.tryParse(rawPrice) ?? 0.0;
    }

    double rating = 0.0;
    final rawRating = json['rating'];
    if (rawRating is num) {
      rating = rawRating.toDouble();
    } else if (rawRating is Map && rawRating['rate'] is num) {
      rating = (rawRating['rate'] as num).toDouble();
    }

    return ProductModel(
      id: id,
      name: name,
      description: description,
      price: price,
      imageUrl: imageUrl,
      category: category,
      rating: rating,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': name,
      'name': name,
      'description': description,
      'price': price,
      'thumbnail': imageUrl,
      'imageUrl': imageUrl,
      'category': category,
      'rating': rating,
    };
  }
}
