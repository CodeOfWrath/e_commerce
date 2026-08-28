import 'package:flutter_riverpod/legacy.dart';

enum SortOption { priceAsc, priceDesc }

final sortProvider = StateProvider<SortOption>((ref) => SortOption.priceAsc);
