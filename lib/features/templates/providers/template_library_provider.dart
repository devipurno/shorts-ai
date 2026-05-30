import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';

import '../../../shared/models/template.dart';
import '../../../shared/repositories/providers.dart';

final templateLibraryFilterProvider = StateNotifierProvider<
    TemplateLibraryFilterNotifier, TemplateLibraryFilterState>((ref) {
  return TemplateLibraryFilterNotifier();
});

final templateSearchQueryProvider = StateProvider<String>((ref) => '');

final templateLibraryProvider = StreamProvider<List<Template>>((ref) {
  final repository = ref.watch(templateRepositoryProvider);
  final filter = ref.watch(templateLibraryFilterProvider);
  final query = ref.watch(templateSearchQueryProvider);

  return repository.watchAll().map(
        (templates) => applyTemplateLibraryFilter(
          templates,
          filter: filter,
          query: query,
        ),
      );
});

final templateCategoriesProvider = StreamProvider<List<String>>((ref) {
  final repository = ref.watch(templateRepositoryProvider);

  return repository.watchAll().map((templates) {
    final categories = templates.map((template) => template.category).toSet()
      ..removeWhere((category) => category.trim().isEmpty);
    final sorted = categories.toList()
      ..sort((a, b) => a.toLowerCase().compareTo(b.toLowerCase()));
    return List<String>.unmodifiable(sorted);
  });
});

final templateDetailProvider = FutureProvider.family<Template?, String>((
  ref,
  templateId,
) {
  return ref.watch(templateRepositoryProvider).getById(templateId);
});

class TemplateLibraryFilterNotifier
    extends StateNotifier<TemplateLibraryFilterState> {
  TemplateLibraryFilterNotifier() : super(const TemplateLibraryFilterState());

  void setCategory(String value) {
    state = state.copyWith(category: value);
  }

  void setTier(TemplateTierFilter value) {
    state = state.copyWith(tier: value);
  }

  void setSort(TemplateSortOrder value) {
    state = state.copyWith(sort: value);
  }

  void clear() {
    state = const TemplateLibraryFilterState();
  }
}

class TemplateLibraryFilterState {
  const TemplateLibraryFilterState({
    this.category = allTemplateCategories,
    this.tier = TemplateTierFilter.all,
    this.sort = TemplateSortOrder.topRated,
  });

  final String category;
  final TemplateTierFilter tier;
  final TemplateSortOrder sort;

  bool get hasActiveFilters {
    return category != allTemplateCategories ||
        tier != TemplateTierFilter.all ||
        sort != TemplateSortOrder.topRated;
  }

  TemplateLibraryFilterState copyWith({
    String? category,
    TemplateTierFilter? tier,
    TemplateSortOrder? sort,
  }) {
    return TemplateLibraryFilterState(
      category: category ?? this.category,
      tier: tier ?? this.tier,
      sort: sort ?? this.sort,
    );
  }
}

const allTemplateCategories = 'all';

enum TemplateTierFilter {
  all('All'),
  free('Free'),
  premium('Premium');

  const TemplateTierFilter(this.label);

  final String label;
}

enum TemplateSortOrder {
  topRated('Top rated'),
  mostUsed('Most used'),
  easiest('Easy first'),
  nameAsc('Name A-Z');

  const TemplateSortOrder(this.label);

  final String label;
}

List<Template> applyTemplateLibraryFilter(
  List<Template> templates, {
  required TemplateLibraryFilterState filter,
  required String query,
}) {
  Iterable<Template> result = templates;

  if (filter.category != allTemplateCategories) {
    result = result.where((template) => template.category == filter.category);
  }

  result = switch (filter.tier) {
    TemplateTierFilter.all => result,
    TemplateTierFilter.free =>
      result.where((template) => template.tier == TemplateTier.free),
    TemplateTierFilter.premium =>
      result.where((template) => template.tier == TemplateTier.premium),
  };

  final normalizedQuery = query.trim().toLowerCase();
  if (normalizedQuery.isNotEmpty) {
    result = result.where((template) {
      final searchable = [
        template.name,
        template.description,
        template.category,
        ...template.structure.hooks,
        ...template.structure.segments,
      ].join(' ').toLowerCase();
      return searchable.contains(normalizedQuery);
    });
  }

  final sorted = result.toList();
  switch (filter.sort) {
    case TemplateSortOrder.topRated:
      sorted.sort((a, b) {
        final rating = b.rating.compareTo(a.rating);
        return rating == 0 ? b.timesUsed.compareTo(a.timesUsed) : rating;
      });
    case TemplateSortOrder.mostUsed:
      sorted.sort((a, b) => b.timesUsed.compareTo(a.timesUsed));
    case TemplateSortOrder.easiest:
      sorted.sort((a, b) {
        final difficulty = a.difficulty.index.compareTo(b.difficulty.index);
        return difficulty == 0 ? b.rating.compareTo(a.rating) : difficulty;
      });
    case TemplateSortOrder.nameAsc:
      sorted.sort((a, b) => a.name.compareTo(b.name));
  }

  return List<Template>.unmodifiable(sorted);
}
