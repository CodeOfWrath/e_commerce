import 'package:flutter_riverpod/flutter_riverpod.dart';

enum SortOption { priceAsc, priceDesc }

final sortProvider = StateProvider<SortOption>((ref) => SortOption.priceAsc);

final categoryFilterProvider = StateProvider<String?>((ref) => null);
