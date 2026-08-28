import 'package:flutter_riverpod/legacy.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../Models/Produit.dart';

class FavoritesNotifier extends StateNotifier<Set<String>> {
  FavoritesNotifier() : super({}) {
    _loadFavorites();
  }

  Future<void> _loadFavorites() async {
    final prefs = await SharedPreferences.getInstance();
    state = prefs.getStringList('favorites')?.toSet() ?? {};
  }

  Future<void> toggleFavorite(Product product) async {
    final newState = {...state};
    if (newState.contains(product.id)) {
      newState.remove(product.id);
    } else {
      newState.add(product.id);
    }
    state = newState;

    final prefs = await SharedPreferences.getInstance();
    await prefs.setStringList('favorites', state.toList());
  }

  Future<void> clearFavorites() async {
    state = {};
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('favorites');
  }
}

final favoritesProvider =
StateNotifierProvider<FavoritesNotifier, Set<String>>((ref) {
  return FavoritesNotifier();
});
