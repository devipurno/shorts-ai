import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';

import '../../../shared/models/project.dart';
import '../../../shared/repositories/providers.dart';
import '../../auth/providers/current_user_provider.dart';

const _fallbackUserId = 'user_1';

final libraryFilterProvider =
    StateNotifierProvider<LibraryFilterNotifier, LibraryFilterState>((ref) {
  return LibraryFilterNotifier();
});

final libraryDataProvider = FutureProvider<LibraryData>((ref) async {
  final user = ref.watch(currentUserProvider);
  final filter = ref.watch(libraryFilterProvider);
  final projectRepository = ref.watch(projectRepositoryProvider);
  final projects = await projectRepository.getAll(
    userId: user?.id ?? _fallbackUserId,
  );

  final filtered = _applyFilter(projects, filter);

  return LibraryData(
    projects: filtered,
    totalCount: projects.length,
    draftCount: projects
        .where((project) => project.status == ProjectStatus.draft)
        .length,
    processingCount: projects
        .where((project) => project.status == ProjectStatus.processing)
        .length,
    readyCount: projects
        .where((project) => project.status == ProjectStatus.ready)
        .length,
    publishedCount: projects
        .where((project) => project.status == ProjectStatus.published)
        .length,
  );
});

class LibraryFilterNotifier extends StateNotifier<LibraryFilterState> {
  LibraryFilterNotifier() : super(const LibraryFilterState());

  void setSearchQuery(String value) {
    state = state.copyWith(searchQuery: value.trim());
  }

  void setStatus(LibraryStatusFilter value) {
    state = state.copyWith(status: value);
  }

  void setSort(LibrarySortOrder value) {
    state = state.copyWith(sortOrder: value);
  }

  void clear() {
    state = const LibraryFilterState();
  }
}

class LibraryFilterState {
  const LibraryFilterState({
    this.searchQuery = '',
    this.status = LibraryStatusFilter.all,
    this.sortOrder = LibrarySortOrder.updatedNewest,
  });

  final String searchQuery;
  final LibraryStatusFilter status;
  final LibrarySortOrder sortOrder;

  LibraryFilterState copyWith({
    String? searchQuery,
    LibraryStatusFilter? status,
    LibrarySortOrder? sortOrder,
  }) {
    return LibraryFilterState(
      searchQuery: searchQuery ?? this.searchQuery,
      status: status ?? this.status,
      sortOrder: sortOrder ?? this.sortOrder,
    );
  }
}

enum LibraryStatusFilter {
  all('Semua'),
  draft('Draft'),
  processing('Proses'),
  ready('Siap'),
  published('Live');

  const LibraryStatusFilter(this.label);

  final String label;
}

enum LibrarySortOrder {
  updatedNewest('Terbaru diupdate'),
  createdNewest('Terbaru dibuat'),
  titleAsc('Judul A-Z'),
  durationDesc('Durasi terpanjang');

  const LibrarySortOrder(this.label);

  final String label;
}

class LibraryData {
  const LibraryData({
    required this.projects,
    required this.totalCount,
    required this.draftCount,
    required this.processingCount,
    required this.readyCount,
    required this.publishedCount,
  });

  final List<Project> projects;
  final int totalCount;
  final int draftCount;
  final int processingCount;
  final int readyCount;
  final int publishedCount;
}

List<Project> _applyFilter(
  List<Project> projects,
  LibraryFilterState filter,
) {
  Iterable<Project> result = projects;

  if (filter.status != LibraryStatusFilter.all) {
    final status = switch (filter.status) {
      LibraryStatusFilter.all => null,
      LibraryStatusFilter.draft => ProjectStatus.draft,
      LibraryStatusFilter.processing => ProjectStatus.processing,
      LibraryStatusFilter.ready => ProjectStatus.ready,
      LibraryStatusFilter.published => ProjectStatus.published,
    };
    result = result.where((project) => project.status == status);
  }

  final query = filter.searchQuery.toLowerCase();
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
    case LibrarySortOrder.updatedNewest:
      sorted.sort((a, b) => b.updatedAt.compareTo(a.updatedAt));
    case LibrarySortOrder.createdNewest:
      sorted.sort((a, b) => b.createdAt.compareTo(a.createdAt));
    case LibrarySortOrder.titleAsc:
      sorted.sort((a, b) => a.title.compareTo(b.title));
    case LibrarySortOrder.durationDesc:
      sorted.sort((a, b) => b.duration.compareTo(a.duration));
  }

  return List<Project>.unmodifiable(sorted);
}
