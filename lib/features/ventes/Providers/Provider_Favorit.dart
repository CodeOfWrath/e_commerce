import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FavoritesNotifier extends Notifier<Set<String>> {
  @override
  Set<String> build() {
    loadFavorites();
    return {};
  }

  Future<void> loadFavorites() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final saved = prefs.getStringList('favorites');
      if (saved != null) {
        state = saved.toSet();
      }
    } catch (_) {}
  }

  Future<void> toggleFavorite(String productId) async {
    final newState = {...state};
    if (newState.contains(productId)) {
      newState.remove(productId);
    } else {
      newState.add(productId);
    }
    state = newState;

    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setStringList('favorites', state.toList());
    } catch (_) {}
  }

  Future<void> clearFavorites() async {
    state = {};
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.remove('favorites');
    } catch (_) {}
  }
}

final favoritesProvider = NotifierProvider<FavoritesNotifier, Set<String>>(
  FavoritesNotifier.new,
);
