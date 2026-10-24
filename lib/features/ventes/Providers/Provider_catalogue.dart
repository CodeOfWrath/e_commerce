import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../domain/entities/product_entity.dart';
import 'Provider_Filtre.dart';
import 'Provider_Produit.dart';

final catalogProvider = Provider<List<Product>>((ref) {
  final productsAsync = ref.watch(productProvider);
  final sortOption = ref.watch(sortProvider);
  final categoryFilter = ref.watch(categoryFilterProvider);
  final searchQuery = ref.watch(searchQueryProvider).toLowerCase();

  return productsAsync.maybeWhen(
    data: (products) {
      var filtered = products.where((p) {
        if (categoryFilter != null && categoryFilter.isNotEmpty) {
          if (p.category.toLowerCase() != categoryFilter.toLowerCase()) return false;
        }
        if (searchQuery.isNotEmpty) {
          final titleMatch = p.name.toLowerCase().contains(searchQuery);
          final descMatch = p.description.toLowerCase().contains(searchQuery);
          if (!titleMatch && !descMatch) return false;
        }
        return true;
      }).toList();

      if (sortOption == SortOption.priceAsc) {
        filtered.sort((a, b) => a.price.compareTo(b.price));
      } else {
        filtered.sort((a, b) => b.price.compareTo(a.price));
      }
      return filtered;
    },
    orElse: () => [],
  );
});
