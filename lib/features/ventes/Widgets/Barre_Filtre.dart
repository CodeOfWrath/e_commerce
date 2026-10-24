import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../Providers/Provider_Filtre.dart';

class FilterBar extends ConsumerWidget {
  const FilterBar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final sortOption = ref.watch(sortProvider);
    final categoryFilter = ref.watch(categoryFilterProvider);

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 6.0),
          child: TextField(
            decoration: InputDecoration(
              hintText: 'Rechercher un produit...',
              prefixIcon: const Icon(Icons.search),
              isDense: true,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            onChanged: (value) {
              ref.read(searchQueryProvider.notifier).state = value;
            },
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 4.0),
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                DropdownButton<SortOption>(
                  value: sortOption,
                  onChanged: (value) {
                    if (value != null) {
                      ref.read(sortProvider.notifier).state = value;
                    }
                  },
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
                ),
                const SizedBox(width: 16),
                DropdownButton<String?>(
                  value: categoryFilter,
                  hint: const Text('Toutes catégories'),
                  onChanged: (value) {
                    ref.read(categoryFilterProvider.notifier).state = value;
                  },
                  items: const [
                    DropdownMenuItem(value: null, child: Text('Toutes')),
                    DropdownMenuItem(value: 'beauty', child: Text('Beauté')),
                    DropdownMenuItem(value: 'fragrances', child: Text('Parfums')),
                    DropdownMenuItem(value: 'furniture', child: Text('Meubles')),
                    DropdownMenuItem(value: 'groceries', child: Text('Épicerie')),
                    DropdownMenuItem(value: 'Chaussures', child: Text('Chaussures')),
                    DropdownMenuItem(value: 'Vêtements', child: Text('Vêtements')),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
