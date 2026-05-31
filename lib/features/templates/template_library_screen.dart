import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../core/theme/app_colors.dart';
import '../../core/theme/app_radius.dart';
import '../../core/theme/app_spacing.dart';
import '../../core/theme/app_typography.dart';
import '../../routing/routes.dart';
import '../../shared/models/template.dart';
import '../../shared/widgets/buttons/fab.dart';
import '../../shared/widgets/buttons/icon_button.dart';
import '../../shared/widgets/display/app_chip.dart';
import '../../shared/widgets/feedback/app_shimmer.dart';
import '../../shared/widgets/feedback/empty_state.dart';
import '../../shared/widgets/feedback/error_state.dart';
import '../../shared/widgets/inputs/search_input.dart';
import '../../shared/widgets/layout/page_scaffold.dart';
import '../../shared/widgets/modals/app_bottom_sheet.dart';
import '../auth/providers/current_user_provider.dart';
import 'providers/template_provider.dart';
import 'widgets/podcast_split_card.dart';
import 'widgets/template_card.dart';

class TemplateLibraryScreen extends ConsumerStatefulWidget {
  const TemplateLibraryScreen({super.key});

  @override
  ConsumerState<TemplateLibraryScreen> createState() =>
      _TemplateLibraryScreenState();
}

class _TemplateLibraryScreenState extends ConsumerState<TemplateLibraryScreen> {
  late final TextEditingController _searchController = TextEditingController();
  int _page = 0;

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final category = ref.watch(templateCategoryProvider);
    final query = ref.watch(templateSearchQueryProvider);
    final filter =
        TemplateFilter(category: category, query: query, page: _page);
    final page = ref.watch(templateListProvider(filter));
    final user = ref.watch(currentUserProvider);
    final premiumUser =
        user?.tier.name == 'premium' || user?.tier.name == 'lifetime';

    return PageScaffold(
      key: const Key('template-library-screen'),
      title: 'Template Library',
      padding: EdgeInsets.zero,
      actions: [
        AppIconButton(
          key: const Key('template-search-action'),
          tooltip: 'Search templates',
          icon: const Icon(Icons.search_rounded),
          onPressed: () => FocusScope.of(context).requestFocus(FocusNode()),
        ),
        AppIconButton(
          key: const Key('template-filter-action'),
          tooltip: 'Filter templates',
          icon: const Icon(Icons.filter_alt_outlined),
          onPressed: () => _showCategorySheet(context),
        ),
      ],
      floatingActionButton: AppFab(
        key: const Key('template-custom-fab'),
        label: 'Custom Template',
        icon: Icon(premiumUser ? Icons.add_rounded : Icons.lock_rounded),
        onPressed: () {
          if (!premiumUser) {
            context.go(AppRoutes.pricing);
            return;
          }
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
                content: Text('Template builder siap di stage berikutnya')),
          );
        },
      ),
      body: RefreshIndicator(
        color: AppColors.gold,
        backgroundColor: AppColors.surface1,
        onRefresh: _refresh,
        child: CustomScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          slivers: [
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(
                  AppSpacing.lg,
                  AppSpacing.lg,
                  AppSpacing.lg,
                  0,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AppSearchInput(
                      key: const Key('template-search-input'),
                      controller: _searchController,
                      hint: 'Cari template atau niche',
                      onChanged: (value) {
                        setState(() => _page = 0);
                        ref.read(templateSearchQueryProvider.notifier).state =
                            value;
                      },
                    ),
                    const SizedBox(height: AppSpacing.lg),
                    _CategorySegmentedControl(
                      selected: category,
                      onSelected: (value) {
                        setState(() => _page = 0);
                        ref.read(templateCategoryProvider.notifier).state =
                            value;
                      },
                    ),
                    const SizedBox(height: AppSpacing.lg),
                    page.when(
                      data: (value) => _CountHeader(page: value),
                      loading: () => AppShimmer.box(width: 180, height: 18),
                      error: (error, stackTrace) => Text('Template unavailable',
                          style: AppTypography.bodySmall),
                    ),
                    const SizedBox(height: AppSpacing.lg),
                  ],
                ),
              ),
            ),
            if (category == TemplateCategory.podcastSplit)
              page.maybeWhen(
                data: (value) => SliverPadding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
                  sliver: SliverToBoxAdapter(
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: AppSpacing.lg),
                      child: PodcastSplitCard(
                        template: value.items.firstOrNull,
                        onTap: value.items.isEmpty
                            ? null
                            : () => _openPodcastSplit(value.items.first),
                      ),
                    ),
                  ),
                ),
                orElse: () => const SliverToBoxAdapter(),
              ),
            page.when(
              loading: () => const _TemplateLoadingGrid(),
              error: (error, stackTrace) => SliverFillRemaining(
                hasScrollBody: false,
                child: ErrorState(
                  title: 'Template belum bisa dimuat.',
                  message: 'Coba refresh atau ulangi beberapa saat lagi.',
                  onRetry: () => ref.invalidate(templateListProvider(filter)),
                ),
              ),
              data: (value) => _TemplateGrid(
                page: value,
                onOpen: _openTemplate,
                onPreview: _showPreview,
                onNextPage: value.hasMore
                    ? () => setState(() => _page = value.page + 1)
                    : null,
              ),
            ),
            const SliverToBoxAdapter(child: SizedBox(height: 110)),
          ],
        ),
      ),
    );
  }

  Future<void> _refresh() async {
    ref.invalidate(templateListProvider);
    await Future<void>.delayed(const Duration(milliseconds: 250));
  }

  void _openTemplate(Template template) {
    context.go(AppRoutes.templateDetailPath(template.id));
  }

  void _openPodcastSplit(Template template) {
    Navigator.of(context).push(
      MaterialPageRoute<void>(
        fullscreenDialog: true,
        builder: (context) => PodcastSplitMockScreen(template: template),
      ),
    );
  }

  Future<void> _showPreview(Template template) async {
    await AppBottomSheet.show<void>(
      context,
      child: _TemplatePreviewSheet(
        template: template,
        onUse: () {
          Navigator.of(context).pop();
          context.go(AppRoutes.templateDetailPath(template.id));
        },
      ),
    );
  }

  Future<void> _showCategorySheet(BuildContext context) {
    return AppBottomSheet.show<void>(
      context,
      child: Column(
        key: const Key('template-filter-sheet'),
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Filter category', style: AppTypography.headlineSmall),
          const SizedBox(height: AppSpacing.md),
          Wrap(
            spacing: AppSpacing.sm,
            runSpacing: AppSpacing.sm,
            children: [
              for (final category in TemplateCategory.values)
                AppChip(
                  label: category.label,
                  variant: AppChipVariant.selectable,
                  selected: ref.read(templateCategoryProvider) == category,
                  onSelected: (_) {
                    setState(() => _page = 0);
                    ref.read(templateCategoryProvider.notifier).state =
                        category;
                    Navigator.of(context).pop();
                  },
                ),
            ],
          ),
        ],
      ),
    );
  }
}

class _CategorySegmentedControl extends StatelessWidget {
  const _CategorySegmentedControl({
    required this.selected,
    required this.onSelected,
  });

  final TemplateCategory selected;
  final ValueChanged<TemplateCategory> onSelected;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      key: const Key('template-category-segments'),
      height: 42,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          final category = TemplateCategory.values[index];
          return AppChip(
            key: Key('template-category-${category.name}'),
            label: category.label,
            variant: AppChipVariant.selectable,
            selected: selected == category,
            onSelected: (_) => onSelected(category),
          );
        },
        separatorBuilder: (context, index) =>
            const SizedBox(width: AppSpacing.sm),
        itemCount: TemplateCategory.values.length,
      ),
    );
  }
}

class _CountHeader extends StatelessWidget {
  const _CountHeader({required this.page});

  final TemplatePage page;

  @override
  Widget build(BuildContext context) {
    final showing = page.items.length + page.page * page.pageSize;

    return Row(
      children: [
        Expanded(
          child: Text(
            'Showing $showing of ${page.total}',
            style: AppTypography.labelLarge,
          ),
        ),
        Text(
          '20 per page',
          style: AppTypography.bodySmall.copyWith(
            color: AppColors.textSecondary,
          ),
        ),
      ],
    );
  }
}

class _TemplateGrid extends StatelessWidget {
  const _TemplateGrid({
    required this.page,
    required this.onOpen,
    required this.onPreview,
    this.onNextPage,
  });

  final TemplatePage page;
  final ValueChanged<Template> onOpen;
  final ValueChanged<Template> onPreview;
  final VoidCallback? onNextPage;

  @override
  Widget build(BuildContext context) {
    if (page.items.isEmpty) {
      return const SliverFillRemaining(
        hasScrollBody: false,
        child: EmptyState(
          title: 'Template tidak ditemukan',
          message: 'Coba kategori atau kata kunci lain.',
          icon: Icons.search_off_rounded,
        ),
      );
    }

    return SliverPadding(
      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
      sliver: SliverList(
        delegate: SliverChildListDelegate.fixed([
          GridView.builder(
            key: const Key('template-library-grid'),
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 9 / 16,
              crossAxisSpacing: AppSpacing.md,
              mainAxisSpacing: AppSpacing.md,
            ),
            itemBuilder: (context, index) {
              final template = page.items[index];
              return TemplateCard(
                template: template,
                onTap: () => onOpen(template),
                onLongPress: () => onPreview(template),
              );
            },
            itemCount: page.items.length,
          ),
          if (onNextPage != null) ...[
            const SizedBox(height: AppSpacing.lg),
            OutlinedButton.icon(
              key: const Key('template-next-page'),
              onPressed: onNextPage,
              icon: const Icon(Icons.expand_more_rounded),
              label: const Text('Load next 20'),
            ),
          ],
        ]),
      ),
    );
  }
}

class _TemplateLoadingGrid extends StatelessWidget {
  const _TemplateLoadingGrid();

  @override
  Widget build(BuildContext context) {
    return SliverPadding(
      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
      sliver: SliverGrid(
        key: const Key('template-loading-grid'),
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
          childCount: 6,
        ),
      ),
    );
  }
}

class _TemplatePreviewSheet extends StatelessWidget {
  const _TemplatePreviewSheet({
    required this.template,
    required this.onUse,
  });

  final Template template;
  final VoidCallback onUse;

  @override
  Widget build(BuildContext context) {
    return Column(
      key: const Key('template-preview-sheet'),
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        AspectRatio(
          aspectRatio: 9 / 16,
          child: DecoratedBox(
            decoration: BoxDecoration(
              color: AppColors.surface1,
              borderRadius: BorderRadius.circular(AppRadius.md),
              border: Border.all(color: AppColors.surface3),
            ),
            child: const Center(
              child: Icon(
                Icons.play_circle_fill_rounded,
                color: AppColors.gold,
                size: 62,
              ),
            ),
          ),
        ),
        const SizedBox(height: AppSpacing.lg),
        Text(template.name, style: AppTypography.headlineSmall),
        const SizedBox(height: AppSpacing.sm),
        Text(
          template.description,
          style: AppTypography.bodySmall.copyWith(
            color: AppColors.textSecondary,
          ),
        ),
        const SizedBox(height: AppSpacing.lg),
        ElevatedButton.icon(
          key: const Key('template-preview-use-button'),
          onPressed: onUse,
          icon: const Icon(Icons.auto_awesome_rounded),
          label: const Text('Use template'),
        ),
      ],
    );
  }
}
