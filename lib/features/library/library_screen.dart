import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:share_plus/share_plus.dart';

import '../../core/theme/app_colors.dart';
import '../../core/theme/app_radius.dart';
import '../../core/theme/app_spacing.dart';
import '../../core/theme/app_typography.dart';
import '../../routing/routes.dart';
import '../../shared/models/project.dart';
import '../../shared/repositories/providers.dart';
import '../../shared/widgets/buttons/fab.dart';
import '../../shared/widgets/buttons/icon_button.dart';
import '../../shared/widgets/feedback/app_shimmer.dart';
import '../../shared/widgets/feedback/empty_state.dart';
import '../../shared/widgets/feedback/error_state.dart';
import '../../shared/widgets/layout/page_scaffold.dart';
import '../../shared/widgets/modals/app_bottom_sheet.dart';
import '../../shared/widgets/modals/app_dialog.dart';
import '../../shared/widgets/navigation/app_tabs.dart';
import 'providers/library_provider.dart';
import 'widgets/filter_bottom_sheet.dart';
import 'widgets/library_project_card.dart';
import 'widgets/search_overlay.dart';

class LibraryScreen extends ConsumerStatefulWidget {
  const LibraryScreen({super.key});

  @override
  ConsumerState<LibraryScreen> createState() => _LibraryScreenState();
}

class _LibraryScreenState extends ConsumerState<LibraryScreen>
    with SingleTickerProviderStateMixin {
  late final TabController _tabController;
  LibraryTab _selectedTab = LibraryTab.all;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(
      length: LibraryTab.values.length,
      vsync: this,
    );
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final counts = ref.watch(libraryCountsProvider);
    final projects = ref.watch(libraryProjectsProvider(_selectedTab));
    final filter = ref.watch(libraryFilterProvider);
    final tabCounts = counts.when(
      data: (value) => value,
      error: (error, stackTrace) => const LibraryCounts.empty(),
      loading: () => const LibraryCounts.empty(),
    );

    return PageScaffold(
      key: const Key('library-screen'),
      title: 'Library',
      actions: [
        AppIconButton(
          key: const Key('library-search-action'),
          tooltip: 'Search library',
          icon: const Icon(Icons.search_rounded),
          onPressed: _openSearch,
        ),
        AppIconButton(
          key: const Key('library-filter-action'),
          tooltip: 'Filter library',
          icon: Icon(
            filter.hasActiveFilters
                ? Icons.filter_alt_rounded
                : Icons.filter_alt_outlined,
          ),
          onPressed: _openFilter,
        ),
      ],
      floatingActionButton: AppFab(
        label: 'Buat',
        icon: const Icon(Icons.add_rounded),
        onPressed: () => context.go(AppRoutes.create),
      ),
      body: RefreshIndicator(
        color: AppColors.gold,
        backgroundColor: AppColors.surface1,
        onRefresh: _refresh,
        child: CustomScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          slivers: [
            SliverToBoxAdapter(
              child: AppTabs(
                key: const Key('library-tabs'),
                tabs: _tabLabels(tabCounts),
                controller: _tabController,
                variant: AppTabsVariant.segmented,
                onTap: (index) {
                  setState(() => _selectedTab = LibraryTab.values[index]);
                },
              ),
            ),
            const SliverToBoxAdapter(child: SizedBox(height: AppSpacing.lg)),
            projects.when(
              loading: () => const _LibraryLoadingGrid(),
              error: (error, stackTrace) => SliverFillRemaining(
                hasScrollBody: false,
                child: ErrorState(
                  title: 'Library belum bisa dimuat.',
                  message: 'Coba refresh atau ulangi beberapa saat lagi.',
                  onRetry: () =>
                      ref.invalidate(libraryProjectsProvider(_selectedTab)),
                ),
              ),
              data: (items) => _LibraryProjectGrid(
                tab: _selectedTab,
                projects: items,
                onProjectTap: (project) =>
                    context.go(AppRoutes.miniEditorPath(project.id)),
                onProjectLongPress: _showProjectActions,
              ),
            ),
            const SliverToBoxAdapter(child: SizedBox(height: 100)),
          ],
        ),
      ),
    );
  }

  List<String> _tabLabels(LibraryCounts? counts) {
    final currentCounts = counts ?? const LibraryCounts.empty();
    return [
      for (final tab in LibraryTab.values)
        '${tab.label} ${currentCounts.countFor(tab)}',
    ];
  }

  Future<void> _refresh() async {
    for (final tab in LibraryTab.values) {
      ref.invalidate(libraryProjectsProvider(tab));
    }
    ref.invalidate(libraryCountsProvider);
    await Future<void>.delayed(const Duration(milliseconds: 250));
  }

  void _openSearch() {
    Navigator.of(context).push(
      MaterialPageRoute<void>(
        fullscreenDialog: true,
        builder: (context) => const SearchOverlay(),
      ),
    );
  }

  Future<void> _openFilter() async {
    final result = await showLibraryFilterBottomSheet(
      context,
      initialFilter: ref.read(libraryFilterProvider),
    );
    if (!mounted || result == null) {
      return;
    }

    ref.read(libraryFilterProvider.notifier).setFilter(result);
  }

  Future<void> _showProjectActions(Project project) async {
    await AppBottomSheet.show<void>(
      context,
      child: _ProjectActionSheet(
        project: project,
        onEdit: () {
          Navigator.of(context).pop();
          context.go(AppRoutes.miniEditorPath(project.id));
        },
        onDuplicate: () async {
          Navigator.of(context).pop();
          await _duplicateProject(project);
        },
        onShare: () async {
          Navigator.of(context).pop();
          await SharePlus.instance.share(
            ShareParams(
              text: 'https://app.autoshort.local/project/${project.id}',
            ),
          );
        },
        onDelete: () async {
          Navigator.of(context).pop();
          await _confirmDelete(project);
        },
      ),
    );
  }

  Future<void> _duplicateProject(Project project) async {
    final now = DateTime.now().toUtc();
    final duplicate = project.copyWith(
      id: 'project_${now.microsecondsSinceEpoch}',
      title: '${project.title} Copy',
      status: ProjectStatus.draft,
      createdAt: now,
      updatedAt: now,
      publishedAt: null,
    );
    await ref.read(projectRepositoryProvider).create(duplicate);
  }

  Future<void> _confirmDelete(Project project) async {
    final confirmed = await AppDialog.showConfirm(
      context,
      title: 'Hapus project?',
      message: 'Project "${project.title}" akan dihapus dari library.',
      confirmLabel: 'Hapus',
      cancelLabel: 'Batal',
    );
    if (!mounted || confirmed != true) {
      return;
    }

    await ref.read(projectRepositoryProvider).delete(project.id);
  }
}

class _LibraryProjectGrid extends StatelessWidget {
  const _LibraryProjectGrid({
    required this.tab,
    required this.projects,
    required this.onProjectTap,
    required this.onProjectLongPress,
  });

  final LibraryTab tab;
  final List<Project> projects;
  final ValueChanged<Project> onProjectTap;
  final ValueChanged<Project> onProjectLongPress;

  @override
  Widget build(BuildContext context) {
    if (projects.isEmpty) {
      return SliverFillRemaining(
        hasScrollBody: false,
        child: _LibraryEmptyState(tab: tab),
      );
    }

    return SliverGrid(
      key: const Key('library-project-grid'),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 9 / 16,
        crossAxisSpacing: AppSpacing.md,
        mainAxisSpacing: AppSpacing.md,
      ),
      delegate: SliverChildBuilderDelegate(
        (context, index) {
          final project = projects[index];
          return LibraryProjectCard(
            project: project,
            onTap: () => onProjectTap(project),
            onLongPress: () => onProjectLongPress(project),
          );
        },
        childCount: projects.length,
      ),
    );
  }
}

class _LibraryEmptyState extends StatelessWidget {
  const _LibraryEmptyState({required this.tab});

  final LibraryTab tab;

  @override
  Widget build(BuildContext context) {
    final config = switch (tab) {
      LibraryTab.all => (
          title: 'Belum ada project.',
          message: 'Buat shorts pertama kamu!',
          cta: 'Buat Shorts Baru',
          icon: Icons.movie_creation_outlined,
        ),
      LibraryTab.drafts => (
          title: 'Tidak ada draft tersimpan',
          message: 'Draft akan muncul setelah kamu menyimpan project.',
          cta: null,
          icon: Icons.drafts_outlined,
        ),
      LibraryTab.processing => (
          title: 'Tidak ada video diproses',
          message: 'Video yang sedang diproses akan tampil di sini.',
          cta: null,
          icon: Icons.hourglass_empty_rounded,
        ),
      LibraryTab.published => (
          title: 'Belum ada video published',
          message: 'Video yang sudah publish akan terkumpul di sini.',
          cta: null,
          icon: Icons.public_rounded,
        ),
    };

    return EmptyState(
      title: config.title,
      message: config.message,
      icon: config.icon,
      ctaLabel: config.cta,
      onCtaPressed:
          config.cta == null ? null : () => context.go(AppRoutes.create),
    );
  }
}

class _LibraryLoadingGrid extends StatelessWidget {
  const _LibraryLoadingGrid();

  @override
  Widget build(BuildContext context) {
    return SliverGrid(
      key: const Key('library-loading-grid'),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 9 / 16,
        crossAxisSpacing: AppSpacing.md,
        mainAxisSpacing: AppSpacing.md,
      ),
      delegate: SliverChildBuilderDelegate(
        (context, index) => AppShimmer.box(
          height: double.infinity,
          radius: AppRadius.md,
        ),
        childCount: 4,
      ),
    );
  }
}

class _ProjectActionSheet extends StatelessWidget {
  const _ProjectActionSheet({
    required this.project,
    required this.onEdit,
    required this.onDuplicate,
    required this.onShare,
    required this.onDelete,
  });

  final Project project;
  final VoidCallback onEdit;
  final VoidCallback onDuplicate;
  final VoidCallback onShare;
  final VoidCallback onDelete;

  @override
  Widget build(BuildContext context) {
    return Column(
      key: const Key('library-action-sheet'),
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          project.title,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: AppTypography.headlineSmall,
        ),
        const SizedBox(height: AppSpacing.md),
        _ActionTile(
          icon: Icons.edit_rounded,
          label: 'Edit',
          onTap: onEdit,
        ),
        _ActionTile(
          icon: Icons.copy_rounded,
          label: 'Duplicate',
          onTap: onDuplicate,
        ),
        _ActionTile(
          icon: Icons.ios_share_rounded,
          label: 'Share',
          onTap: onShare,
        ),
        _ActionTile(
          icon: Icons.delete_outline_rounded,
          label: 'Delete',
          isDanger: true,
          onTap: onDelete,
        ),
      ],
    );
  }
}

class _ActionTile extends StatelessWidget {
  const _ActionTile({
    required this.icon,
    required this.label,
    required this.onTap,
    this.isDanger = false,
  });

  final IconData icon;
  final String label;
  final VoidCallback onTap;
  final bool isDanger;

  @override
  Widget build(BuildContext context) {
    final color = isDanger ? AppColors.error : AppColors.textPrimary;

    return ListTile(
      onTap: onTap,
      contentPadding: EdgeInsets.zero,
      leading: Icon(icon, color: color),
      title: Text(
        label,
        style: AppTypography.labelLarge.copyWith(color: color),
      ),
    );
  }
}
