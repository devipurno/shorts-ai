import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';

import '../../../shared/models/project.dart';
import '../../../shared/repositories/providers.dart';
import '../../auth/providers/current_user_provider.dart';

const _fallbackUserId = 'user_1';
const _sentinel = Object();

final libraryFilterProvider =
    StateNotifierProvider<LibraryFilterNotifier, LibraryFilterState>((ref) {
  return LibraryFilterNotifier();
});

final librarySearchQueryProvider = StateProvider<String>((ref) => '');

final libraryProjectsProvider =
    StreamProvider.family<List<Project>, LibraryTab>((ref, tab) {
  final user = ref.watch(currentUserProvider);
  final filter = ref.watch(libraryFilterProvider);
  final searchQuery = ref.watch(librarySearchQueryProvider);
  final projectRepository = ref.watch(projectRepositoryProvider);

  return projectRepository.watch(userId: user?.id ?? _fallbackUserId).map(
        (projects) => _applyFilter(
          projects,
          tab: tab,
          filter: filter,
          searchQuery: searchQuery,
        ),
      );
});

final libraryCountsProvider = StreamProvider<LibraryCounts>((ref) {
  final user = ref.watch(currentUserProvider);
  final projectRepository = ref.watch(projectRepositoryProvider);

  return projectRepository
      .watch(userId: user?.id ?? _fallbackUserId)
      .map(LibraryCounts.fromProjects);
});

class LibraryFilterNotifier extends StateNotifier<LibraryFilterState> {
  LibraryFilterNotifier() : super(const LibraryFilterState());

  void setSort(LibrarySortOrder value) {
    state = state.copyWith(sortOrder: value);
  }

  void setDateRange(LibraryDateRangeFilter value) {
    state = state.copyWith(dateRange: value);
  }

  void setTemplateId(String? value) {
    state = state.copyWith(templateId: value);
  }

  void setTier(LibraryTierFilter value) {
    state = state.copyWith(tier: value);
  }

  void setFilter(LibraryFilterState value) {
    state = value;
  }

  void clear() {
    state = const LibraryFilterState();
  }
}

class LibraryFilterState {
  const LibraryFilterState({
    this.sortOrder = LibrarySortOrder.latest,
    this.dateRange = LibraryDateRangeFilter.all,
    this.templateId,
    this.tier = LibraryTierFilter.all,
  });

  final LibrarySortOrder sortOrder;
  final LibraryDateRangeFilter dateRange;
  final String? templateId;
  final LibraryTierFilter tier;

  bool get hasActiveFilters {
    return sortOrder != LibrarySortOrder.latest ||
        dateRange != LibraryDateRangeFilter.all ||
        (templateId != null && templateId!.isNotEmpty) ||
        tier != LibraryTierFilter.all;
  }

  LibraryFilterState copyWith({
    LibrarySortOrder? sortOrder,
    LibraryDateRangeFilter? dateRange,
    Object? templateId = _sentinel,
    LibraryTierFilter? tier,
  }) {
    return LibraryFilterState(
      sortOrder: sortOrder ?? this.sortOrder,
      dateRange: dateRange ?? this.dateRange,
      templateId: identical(templateId, _sentinel)
          ? this.templateId
          : templateId as String?,
      tier: tier ?? this.tier,
    );
  }
}

enum LibraryTab {
  all('All'),
  drafts('Drafts'),
  processing('Processing'),
  published('Published');

  const LibraryTab(this.label);

  final String label;
}

enum LibrarySortOrder {
  latest('Latest'),
  oldest('Oldest'),
  titleAsc('Title A-Z'),
  mostViewed('Most viewed');

  const LibrarySortOrder(this.label);

  final String label;
}

enum LibraryDateRangeFilter {
  all('Any time'),
  last7Days('Last 7 days'),
  last30Days('Last 30 days');

  const LibraryDateRangeFilter(this.label);

  final String label;
}

enum LibraryTierFilter {
  all('Any tier'),
  free('Free'),
  premium('Premium');

  const LibraryTierFilter(this.label);

  final String label;
}

class LibraryCounts {
  const LibraryCounts({
    required this.all,
    required this.drafts,
    required this.processing,
    required this.published,
  });

  const LibraryCounts.empty()
      : all = 0,
        drafts = 0,
        processing = 0,
        published = 0;

  factory LibraryCounts.fromProjects(List<Project> projects) {
    return LibraryCounts(
      all: projects.length,
      drafts: projects
          .where((project) => project.status == ProjectStatus.draft)
          .length,
      processing: projects
          .where((project) => project.status == ProjectStatus.processing)
          .length,
      published: projects
          .where((project) => project.status == ProjectStatus.published)
          .length,
    );
  }

  final int all;
  final int drafts;
  final int processing;
  final int published;

  int countFor(LibraryTab tab) {
    return switch (tab) {
      LibraryTab.all => all,
      LibraryTab.drafts => drafts,
      LibraryTab.processing => processing,
      LibraryTab.published => published,
    };
  }
}

List<Project> _applyFilter(
  List<Project> projects, {
  required LibraryTab tab,
  required LibraryFilterState filter,
  required String searchQuery,
}) {
  Iterable<Project> result = projects;

  final tabStatus = switch (tab) {
    LibraryTab.all => null,
    LibraryTab.drafts => ProjectStatus.draft,
    LibraryTab.processing => ProjectStatus.processing,
    LibraryTab.published => ProjectStatus.published,
  };
  if (tabStatus != null) {
    result = result.where((project) => project.status == tabStatus);
  }

  result = switch (filter.dateRange) {
    LibraryDateRangeFilter.all => result,
    LibraryDateRangeFilter.last7Days => result.where(
        (project) => project.updatedAt.isAfter(
          DateTime.now().subtract(const Duration(days: 7)),
        ),
      ),
    LibraryDateRangeFilter.last30Days => result.where(
        (project) => project.updatedAt.isAfter(
          DateTime.now().subtract(const Duration(days: 30)),
        ),
      ),
  };

  if (filter.templateId != null && filter.templateId!.isNotEmpty) {
    result = result.where((project) => project.templateId == filter.templateId);
  }

  result = switch (filter.tier) {
    LibraryTierFilter.all => result,
    LibraryTierFilter.free =>
      result.where((project) => project.brandKitId == null),
    LibraryTierFilter.premium =>
      result.where((project) => project.brandKitId != null),
  };

  final query = searchQuery.toLowerCase().trim();
  if (query.isNotEmpty) {
    result = result.where((project) {
      final searchable = [
        project.title,
        project.description,
        ...project.tags,
      ].join(' ').toLowerCase();
      return searchable.contains(query);
    });
  }

  final sorted = result.toList();
  switch (filter.sortOrder) {
    case LibrarySortOrder.latest:
      sorted.sort((a, b) => b.updatedAt.compareTo(a.updatedAt));
    case LibrarySortOrder.oldest:
      sorted.sort((a, b) => a.updatedAt.compareTo(b.updatedAt));
    case LibrarySortOrder.titleAsc:
      sorted.sort((a, b) => a.title.compareTo(b.title));
    case LibrarySortOrder.mostViewed:
      // Project has no view-count field yet. Use published recency as a stable
      // proxy until analytics-backed sorting is available.
      sorted.sort((a, b) {
        final bSignal = b.publishedAt ?? b.updatedAt;
        final aSignal = a.publishedAt ?? a.updatedAt;
        return bSignal.compareTo(aSignal);
      });
  }

  return List<Project>.unmodifiable(sorted);
}
