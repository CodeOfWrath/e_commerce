class Product {
  final String id;
  final String name;
  final double price;
  final String imageUrl;

  Product({required this.id, required this.name, required this.price, required this.imageUrl});

  factory Product.fromJson(Map<String, dynamic> json) => Product(
    id: json['id'],
    name: json['name'],
    price: json['price'],
    imageUrl: json['imageUrl'],
  );
}
