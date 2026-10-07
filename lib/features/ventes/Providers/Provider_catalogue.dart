import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../Models/Produit.dart';
import 'Provider_Filtre.dart';
import 'Provider_Produit.dart';

final catalogProvider = Provider<List<Product>>((ref) {
  final productsAsync = ref.watch(productProvider);
  final sortOption = ref.watch(sortProvider);
  final categoryFilter = ref.watch(categoryFilterProvider);

  return productsAsync.maybeWhen(
    data: (products) {
      var filtered = products.where((p) {
        if (categoryFilter == null) return true;
        return p.category == categoryFilter;
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
