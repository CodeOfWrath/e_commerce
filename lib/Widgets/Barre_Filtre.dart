import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../Providers/Provider_Filtre.dart';

class FilterBar extends ConsumerWidget {
  const FilterBar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final sortOption = ref.watch(sortProvider);

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        DropdownButton<SortOption>(
          value: sortOption,
          items: const [
            DropdownMenuItem(value: SortOption.priceAsc, child: Text('Prix croissant')),
            DropdownMenuItem(value: SortOption.priceDesc, child: Text('Prix décroissant')),
          ],
          onChanged: (value) {
            if (value != null) {
              ref.read(sortProvider.notifier).state = value;
            }
          },
        ),
      ],
    );
  }
}
