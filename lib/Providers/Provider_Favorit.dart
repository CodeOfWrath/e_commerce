import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FavoritesNotifier extends StateNotifier<Set<String>> {
  FavoritesNotifier() : super({}) {
    // On lance le chargement mais on ne peut pas await dans un constructeur
    _init();
  }

  Future<void> _init() async {
    await _loadFavorites();
  }

  Future<void> _loadFavorites() async {
    final prefs = await SharedPreferences.getInstance();
    final saved = prefs.getStringList('favorites');
    if (saved != null) {
      state = saved.toSet();
    }
  }

  Future<void> toggleFavorite(String productId) async {
    final newState = {...state};
    if (newState.contains(productId)) {
      newState.remove(productId);
    } else {
      newState.add(productId);
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
