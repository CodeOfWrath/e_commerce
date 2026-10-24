import 'package:e_commerce/features/ventes/data/models/product_model.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('ProductModel.fromJson est robuste', () {
    final json = {
      'id': 123,
      'name': 'Chaussures',
      'price': '59.99',
    };

    final product = ProductModel.fromJson(json);

    expect(product.id, '123');
    expect(product.name, 'Chaussures');
    expect(product.price, 59.99);
    expect(product.imageUrl, '');
    expect(product.category, 'Divers');
  });

  test('fromJson gère les types et clés manquantes', () {
    final json = {
      'id': 123,
      'name': 'Chaussures',
      'price': '59.99',
    };

    final product = ProductModel.fromJson(json);

    expect(product.id, '123');
    expect(product.name, 'Chaussures');
    expect(product.price, 59.99);
    expect(product.imageUrl, '');
    expect(product.category, 'Divers');
  });
}
