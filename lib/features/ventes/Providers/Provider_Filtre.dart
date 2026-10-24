import 'package:flutter_riverpod/flutter_riverpod.dart';

enum SortOption { priceAsc, priceDesc }

class SortNotifier extends Notifier<SortOption> {
  @override
  SortOption build() => SortOption.priceAsc;

  @override
  set state(SortOption value) => super.state = value;
}

final sortProvider = NotifierProvider<SortNotifier, SortOption>(
  SortNotifier.new,
);

class CategoryFilterNotifier extends Notifier<String?> {
  @override
  String? build() => null;

  @override
  set state(String? value) => super.state = value;
}

final categoryFilterProvider = NotifierProvider<CategoryFilterNotifier, String?>(
  CategoryFilterNotifier.new,
);

class SearchQueryNotifier extends Notifier<String> {
  @override
  String build() => '';

  @override
  set state(String value) => super.state = value;
}

final searchQueryProvider = NotifierProvider<SearchQueryNotifier, String>(
  SearchQueryNotifier.new,
);
