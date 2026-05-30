import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../core/theme/app_colors.dart';
import '../../core/theme/app_spacing.dart';
import '../../core/theme/app_typography.dart';
import '../../routing/routes.dart';
import '../../shared/widgets/buttons/fab.dart';
import '../../shared/widgets/feedback/app_shimmer.dart';
import '../../shared/widgets/feedback/empty_state.dart';
import '../../shared/widgets/feedback/error_state.dart';
import '../../shared/widgets/inputs/search_input.dart';
import '../../shared/widgets/layout/page_scaffold.dart';
import 'providers/library_provider.dart';
import 'widgets/library_filter_bar.dart';
import 'widgets/library_project_card.dart';
import 'widgets/library_summary_card.dart';

class LibraryScreen extends ConsumerWidget {
  const LibraryScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final filter = ref.watch(libraryFilterProvider);
    final libraryData = ref.watch(libraryDataProvider);

    return PageScaffold(
      key: const Key('library-screen'),
      title: 'Library',
      floatingActionButton: AppFab(
        label: 'Buat',
        icon: const Icon(Icons.add_rounded),
        onPressed: () => context.go(AppRoutes.create),
      ),
      body: RefreshIndicator(
        color: AppColors.gold,
        backgroundColor: AppColors.surface1,
        onRefresh: () async => ref.invalidate(libraryDataProvider),
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  AppSearchInput(
                    key: const Key('library-search'),
                    hint: 'Cari project, tag, atau deskripsi...',
                    onChanged:
                        ref.read(libraryFilterProvider.notifier).setSearchQuery,
                  ),
                  const SizedBox(height: AppSpacing.md),
                  LibraryFilterBar(
                    selected: filter.status,
                    onSelected:
                        ref.read(libraryFilterProvider.notifier).setStatus,
                  ),
                  const SizedBox(height: AppSpacing.md),
                  _SortRow(
                    selected: filter.sortOrder,
                    onChanged: ref.read(libraryFilterProvider.notifier).setSort,
                  ),
                  const SizedBox(height: AppSpacing.lg),
                ],
              ),
            ),
            libraryData.when(
              loading: () => const SliverToBoxAdapter(child: _LibraryLoading()),
              error: (error, stackTrace) => SliverFillRemaining(
                hasScrollBody: false,
                child: ErrorState(
                  title: 'Library belum bisa dimuat.',
                  message: 'Coba refresh atau ulangi beberapa saat lagi.',
                  onRetry: () => ref.invalidate(libraryDataProvider),
                ),
              ),
              data: (data) => _LibraryContent(data: data),
            ),
            const SliverToBoxAdapter(child: SizedBox(height: 100)),
          ],
        ),
      ),
    );
  }
}

class _LibraryContent extends StatelessWidget {
  const _LibraryContent({required this.data});

  final LibraryData data;

  @override
  Widget build(BuildContext context) {
    if (data.totalCount == 0) {
      return SliverFillRemaining(
        hasScrollBody: false,
        child: EmptyState(
          title: 'Belum ada project.',
          message: 'Mulai dari video pertama dan simpan hasilnya di library.',
          ctaLabel: 'Buat Shorts Baru',
          onCtaPressed: () => context.go(AppRoutes.create),
        ),
      );
    }

    if (data.projects.isEmpty) {
      return const SliverFillRemaining(
        hasScrollBody: false,
        child: EmptyState(
          title: 'Project tidak ditemukan.',
          message: 'Coba hapus filter atau cari kata lain.',
          icon: Icons.search_off_rounded,
        ),
      );
    }

    return SliverList.separated(
      itemBuilder: (context, index) {
        if (index == 0) {
          return LibrarySummaryCard(data: data);
        }

        final project = data.projects[index - 1];
        return LibraryProjectCard(
          project: project,
          onTap: () => context.go(AppRoutes.miniEditorPath(project.id)),
        );
      },
      separatorBuilder: (context, index) =>
          const SizedBox(height: AppSpacing.md),
      itemCount: data.projects.length + 1,
    );
  }
}

class _SortRow extends StatelessWidget {
  const _SortRow({
    required this.selected,
    required this.onChanged,
  });

  final LibrarySortOrder selected;
  final ValueChanged<LibrarySortOrder> onChanged;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          'Urutkan',
          style: AppTypography.labelMedium.copyWith(
            color: AppColors.textSecondary,
          ),
        ),
        const Spacer(),
        DropdownButtonHideUnderline(
          child: DropdownButton<LibrarySortOrder>(
            key: const Key('library-sort'),
            value: selected,
            dropdownColor: AppColors.surface2,
            iconEnabledColor: AppColors.gold,
            style: AppTypography.labelMedium.copyWith(color: AppColors.gold),
            onChanged: (value) {
              if (value != null) {
                onChanged(value);
              }
            },
            items: [
              for (final sort in LibrarySortOrder.values)
                DropdownMenuItem(
                  value: sort,
                  child: Text(sort.label),
                ),
            ],
          ),
        ),
      ],
    );
  }
}

class _LibraryLoading extends StatelessWidget {
  const _LibraryLoading();

  @override
  Widget build(BuildContext context) {
    return Column(
      key: const Key('library-loading'),
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        AppShimmer.box(height: 132),
        const SizedBox(height: AppSpacing.md),
        AppShimmer.box(height: 112),
        const SizedBox(height: AppSpacing.md),
        AppShimmer.box(height: 112),
        const SizedBox(height: AppSpacing.md),
        AppShimmer.box(height: 112),
      ],
    );
  }
}
