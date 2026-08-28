import 'package:e_commerce/Models/Produit.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('Product est immutable et fromJson est robuste', () {
    final json = {
      'id': 123,
      'name': 'Chaussures',
      'price': '59.99',
    };

    final product = Product.fromJson(json);

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
      // imageUrl manquant
      // category manquant
    };

    final product = Product.fromJson(json);

    expect(product.id, '123'); // converti en String
    expect(product.name, 'Chaussures');
    expect(product.price, 59.99);
    expect(product.imageUrl, ''); // fallback
    expect(product.category, 'Divers'); // fallback
  });
}
