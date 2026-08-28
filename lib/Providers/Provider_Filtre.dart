import 'package:flutter_riverpod/legacy.dart';

/// Options de tri disponibles
enum SortOption { priceAsc, priceDesc }

/// Provider pour gérer le tri
final sortProvider = StateProvider<SortOption>((ref) => SortOption.priceAsc);

/// Provider pour gérer le filtre par catégorie
final categoryFilterProvider = StateProvider<String?>((ref) => null);
