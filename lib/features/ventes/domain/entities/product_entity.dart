class Product {
  final String id;
  final String name;
  final String description;
  final double price;
  final String imageUrl;
  final String category;
  final double rating;

  const Product({
    required this.id,
    required this.name,
    this.description = '',
    required this.price,
    required this.imageUrl,
    required this.category,
    this.rating = 0.0,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Product &&
          runtimeType == other.runtimeType &&
          id == other.id;

  @override
  int get hashCode => id.hashCode;
}
