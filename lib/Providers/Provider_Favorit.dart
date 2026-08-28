import 'package:flutter_riverpod/legacy.dart';

import '../Models/Produit.dart';

class FavoritesNotifier extends StateNotifier<Set<String>> {
  FavoritesNotifier() : super({});

  void toggleFavorite(Product product) {
    if (state.contains(product.id)) {
      state = {...state}..remove(product.id);
    } else {
      state = {...state, product.id};
    }
  }
}

final favoritesProvider = StateNotifierProvider<FavoritesNotifier, Set<String>>((ref) => FavoritesNotifier());
