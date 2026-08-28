import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../Providers/Provider_Filtre.dart';

class FilterBar extends ConsumerWidget {
  const FilterBar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final sortOption = ref.watch(sortProvider);
    final categoryFilter = ref.watch(categoryFilterProvider);

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // Tri par prix
        DropdownButton<SortOption>(
          value: sortOption,
          items: const [
            DropdownMenuItem(
              value: SortOption.priceAsc,
              child: Text('Prix croissant'),
            ),
            DropdownMenuItem(
              value: SortOption.priceDesc,
              child: Text('Prix décroissant'),
            ),
          ],
          onChanged: (value) {
            if (value != null) {
              ref.read(sortProvider.notifier).state = value;
            }
          },
        ),
        const SizedBox(width: 20),
        // Filtre par catégorie
        DropdownButton<String?>(
          value: categoryFilter,
          hint: const Text('Catégorie'),
          items: const [
            DropdownMenuItem(value: null, child: Text('Toutes')),
            DropdownMenuItem(value: 'Chaussures', child: Text('Chaussures')),
            DropdownMenuItem(value: 'Vêtements', child: Text('Vêtements')),
            DropdownMenuItem(value: 'Accessoires', child: Text('Accessoires')),
          ],
          onChanged: (value) {
            ref.read(categoryFilterProvider.notifier).state = value;
          },
        ),
      ],
    );
  }
}
