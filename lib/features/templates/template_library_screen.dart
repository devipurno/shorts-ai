import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../core/theme/app_colors.dart';
import '../../core/theme/app_radius.dart';
import '../../core/theme/app_spacing.dart';
import '../../core/theme/app_typography.dart';
import '../../routing/routes.dart';
import '../../shared/models/template.dart';
import '../../shared/widgets/display/app_chip.dart';
import '../../shared/widgets/feedback/app_shimmer.dart';
import '../../shared/widgets/feedback/empty_state.dart';
import '../../shared/widgets/feedback/error_state.dart';
import '../../shared/widgets/inputs/search_input.dart';
import '../../shared/widgets/layout/page_scaffold.dart';
import '../../shared/widgets/navigation/app_appbar.dart';
import 'providers/template_library_provider.dart';
import 'widgets/template_marketplace_card.dart';

class TemplateLibraryScreen extends ConsumerStatefulWidget {
  const TemplateLibraryScreen({super.key});

  @override
  ConsumerState<TemplateLibraryScreen> createState() =>
      _TemplateLibraryScreenState();
}

class _TemplateLibraryScreenState extends ConsumerState<TemplateLibraryScreen> {
  late final TextEditingController _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final templates = ref.watch(templateLibraryProvider);
    final categories = ref.watch(templateCategoriesProvider);
    final filter = ref.watch(templateLibraryFilterProvider);

    return PageScaffold(
      key: const Key('template-library-screen'),
      title: 'Templates',
      padding: EdgeInsets.zero,
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
                      hint: 'Cari template, niche, atau hook',
                      onChanged: (value) => ref
                          .read(templateSearchQueryProvider.notifier)
                          .state = value,
                    ),
                    const SizedBox(height: AppSpacing.lg),
                    _FeaturedTemplateBanner(
                      onTap: () => context
                          .go(AppRoutes.templateDetailPath('template_16')),
                    ),
                    const SizedBox(height: AppSpacing.lg),
                    _CategoryFilter(
                      categories: categories.value ?? const [],
                      selectedCategory: filter.category,
                      onSelected: (value) => ref
                          .read(templateLibraryFilterProvider.notifier)
                          .setCategory(value),
                    ),
                    const SizedBox(height: AppSpacing.md),
                    _FilterRow(
                      filter: filter,
                      onTierChanged: (value) => ref
                          .read(templateLibraryFilterProvider.notifier)
                          .setTier(value),
                      onSortChanged: (value) => ref
                          .read(templateLibraryFilterProvider.notifier)
                          .setSort(value),
                      onClear: filter.hasActiveFilters ||
                              ref.watch(templateSearchQueryProvider).isNotEmpty
                          ? _clearFilters
                          : null,
                    ),
                    const SizedBox(height: AppSpacing.lg),
                    Text(
                      'Marketplace',
                      style: AppTypography.headlineSmall,
                    ),
                    const SizedBox(height: AppSpacing.xs),
                    Text(
                      '22 blueprint siap pakai untuk format Shorts yang berbeda.',
                      style: AppTypography.bodySmall.copyWith(
                        color: AppColors.textSecondary,
                      ),
                    ),
                    const SizedBox(height: AppSpacing.lg),
                  ],
                ),
              ),
            ),
            templates.when(
              loading: () => const _TemplateLoadingGrid(),
              error: (error, stackTrace) => SliverFillRemaining(
                hasScrollBody: false,
                child: ErrorState(
                  title: 'Template belum bisa dimuat.',
                  message: 'Coba refresh atau ulangi beberapa saat lagi.',
                  onRetry: () => ref.invalidate(templateLibraryProvider),
                ),
              ),
              data: (items) => _TemplateGrid(templates: items),
            ),
            const SliverToBoxAdapter(child: SizedBox(height: 100)),
          ],
        ),
      ),
    );
  }

  Future<void> _refresh() async {
    ref
      ..invalidate(templateLibraryProvider)
      ..invalidate(templateCategoriesProvider);
    await Future<void>.delayed(const Duration(milliseconds: 250));
  }

  void _clearFilters() {
    _searchController.clear();
    ref.read(templateSearchQueryProvider.notifier).state = '';
    ref.read(templateLibraryFilterProvider.notifier).clear();
  }
}

class TemplateDetailScreen extends ConsumerWidget {
  const TemplateDetailScreen({
    super.key,
    required this.templateId,
  });

  final String templateId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final template = ref.watch(templateDetailProvider(templateId));

    return Scaffold(
      key: const Key('template-detail-screen'),
      backgroundColor: AppColors.obsidian,
      appBar: AppAppBar(
        title: 'Template Detail',
        showBackButton: true,
        onBack: () => context.pop(),
      ),
      body: template.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stackTrace) => ErrorState(
          title: 'Template tidak bisa dibuka.',
          message: 'Coba kembali ke marketplace.',
          onRetry: () => ref.invalidate(templateDetailProvider(templateId)),
        ),
        data: (item) {
          if (item == null) {
            return const EmptyState(
              title: 'Template tidak ditemukan',
              message: 'Template ini mungkin sudah tidak tersedia.',
            );
          }

          return _TemplateDetailContent(template: item);
        },
      ),
    );
  }
}

class _TemplateDetailContent extends ConsumerWidget {
  const _TemplateDetailContent({required this.template});

  final Template template;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final premium = template.tier == TemplateTier.premium;

    return ListView(
      padding: const EdgeInsets.all(AppSpacing.lg),
      children: [
        SizedBox(
          height: 420,
          child: TemplateMarketplaceCard(template: template),
        ),
        const SizedBox(height: AppSpacing.lg),
        Row(
          children: [
            Expanded(
              child: Text(template.name, style: AppTypography.headlineLarge),
            ),
            _DetailMetric(
              icon: Icons.star_rounded,
              label: template.rating.toStringAsFixed(1),
            ),
          ],
        ),
        const SizedBox(height: AppSpacing.sm),
        Text(
          template.description,
          style: AppTypography.bodyMedium.copyWith(
            color: AppColors.textSecondary,
          ),
        ),
        const SizedBox(height: AppSpacing.lg),
        Wrap(
          spacing: AppSpacing.sm,
          runSpacing: AppSpacing.sm,
          children: [
            AppChip(label: templateCategoryLabel(template.category)),
            AppChip(label: premium ? 'Premium' : 'Free'),
            AppChip(label: template.difficulty.name),
            AppChip(label: '${template.structure.duration}s'),
          ],
        ),
        const SizedBox(height: AppSpacing.lg),
        _BlueprintSection(template: template),
        const SizedBox(height: AppSpacing.lg),
        if (premium)
          _PremiumNotice(onUpgrade: () => context.go(AppRoutes.pricing))
        else
          _ApplyTemplateButton(template: template),
      ],
    );
  }
}

class _TemplateGrid extends StatelessWidget {
  const _TemplateGrid({required this.templates});

  final List<Template> templates;

  @override
  Widget build(BuildContext context) {
    if (templates.isEmpty) {
      return const SliverFillRemaining(
        hasScrollBody: false,
        child: EmptyState(
          title: 'Template tidak ditemukan',
          message: 'Coba kata kunci atau filter lain.',
          icon: Icons.search_off_rounded,
        ),
      );
    }

    return SliverPadding(
      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
      sliver: SliverGrid(
        key: const Key('template-library-grid'),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 0.58,
          crossAxisSpacing: AppSpacing.md,
          mainAxisSpacing: AppSpacing.md,
        ),
        delegate: SliverChildBuilderDelegate(
          (context, index) {
            final template = templates[index];
            return TemplateMarketplaceCard(
              template: template,
              onTap: () =>
                  context.go(AppRoutes.templateDetailPath(template.id)),
            );
          },
          childCount: templates.length,
        ),
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
          childAspectRatio: 0.58,
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

class _CategoryFilter extends StatelessWidget {
  const _CategoryFilter({
    required this.categories,
    required this.selectedCategory,
    required this.onSelected,
  });

  final List<String> categories;
  final String selectedCategory;
  final ValueChanged<String> onSelected;

  @override
  Widget build(BuildContext context) {
    final items = [allTemplateCategories, ...categories];

    return SizedBox(
      height: 42,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          final category = items[index];
          return AppChip(
            key: Key('template-category-$category'),
            label: templateCategoryLabel(category),
            variant: AppChipVariant.selectable,
            selected: selectedCategory == category,
            onSelected: (_) => onSelected(category),
          );
        },
        separatorBuilder: (context, index) =>
            const SizedBox(width: AppSpacing.sm),
        itemCount: items.length,
      ),
    );
  }
}

class _FilterRow extends StatelessWidget {
  const _FilterRow({
    required this.filter,
    required this.onTierChanged,
    required this.onSortChanged,
    this.onClear,
  });

  final TemplateLibraryFilterState filter;
  final ValueChanged<TemplateTierFilter> onTierChanged;
  final ValueChanged<TemplateSortOrder> onSortChanged;
  final VoidCallback? onClear;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Wrap(
          spacing: AppSpacing.sm,
          runSpacing: AppSpacing.sm,
          children: [
            for (final tier in TemplateTierFilter.values)
              AppChip(
                key: Key('template-tier-${tier.name}'),
                label: tier.label,
                variant: AppChipVariant.selectable,
                selected: filter.tier == tier,
                onSelected: (_) => onTierChanged(tier),
              ),
          ],
        ),
        const SizedBox(height: AppSpacing.md),
        Row(
          children: [
            Expanded(
              child: DropdownButtonFormField<TemplateSortOrder>(
                key: const Key('template-sort-dropdown'),
                initialValue: filter.sort,
                decoration: const InputDecoration(
                  labelText: 'Sort',
                  prefixIcon: Icon(Icons.sort_rounded),
                ),
                items: [
                  for (final sort in TemplateSortOrder.values)
                    DropdownMenuItem(
                      value: sort,
                      child: Text(sort.label),
                    ),
                ],
                onChanged: (value) {
                  if (value != null) {
                    onSortChanged(value);
                  }
                },
              ),
            ),
            const SizedBox(width: AppSpacing.sm),
            TextButton(
              key: const Key('template-clear-filter'),
              onPressed: onClear,
              child: const Text('Reset'),
            ),
          ],
        ),
      ],
    );
  }
}

class _FeaturedTemplateBanner extends StatelessWidget {
  const _FeaturedTemplateBanner({required this.onTap});

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: AppColors.surface1,
        borderRadius: BorderRadius.circular(AppRadius.lg),
        border: Border.all(color: AppColors.gold),
        boxShadow: [
          BoxShadow(
            color: AppColors.gold.withValues(alpha: 0.18),
            blurRadius: 22,
          ),
        ],
      ),
      child: InkWell(
        key: const Key('template-featured-podcast'),
        borderRadius: BorderRadius.circular(AppRadius.lg),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.lg),
          child: Row(
            children: [
              const Icon(
                Icons.graphic_eq_rounded,
                color: AppColors.gold,
                size: 34,
              ),
              const SizedBox(width: AppSpacing.md),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Signature Premium', style: AppTypography.labelMedium),
                    const SizedBox(height: AppSpacing.xs),
                    Text(
                      'Podcast 2-Speaker Split',
                      style: AppTypography.headlineSmall,
                    ),
                    const SizedBox(height: AppSpacing.xs),
                    Text(
                      'Blueprint unik untuk klip podcast dua host.',
                      style: AppTypography.bodySmall.copyWith(
                        color: AppColors.textSecondary,
                      ),
                    ),
                  ],
                ),
              ),
              const Icon(Icons.chevron_right_rounded, color: AppColors.gold),
            ],
          ),
        ),
      ),
    );
  }
}

class _BlueprintSection extends StatelessWidget {
  const _BlueprintSection({required this.template});

  final Template template;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: AppColors.surface1,
        borderRadius: BorderRadius.circular(AppRadius.md),
        border: Border.all(color: AppColors.surface3),
      ),
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.lg),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Blueprint', style: AppTypography.headlineSmall),
            const SizedBox(height: AppSpacing.md),
            _BlueprintLine(
              label: 'Hooks',
              value: template.structure.hooks.join(', '),
            ),
            _BlueprintLine(
              label: 'Segments',
              value: template.structure.segments.join(' -> '),
            ),
            _BlueprintLine(
              label: 'Transitions',
              value: template.structure.transitions.join(', '),
            ),
            _BlueprintLine(
              label: 'Music',
              value: template.structure.music.join(', '),
            ),
          ],
        ),
      ),
    );
  }
}

class _BlueprintLine extends StatelessWidget {
  const _BlueprintLine({
    required this.label,
    required this.value,
  });

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: AppSpacing.sm),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 92,
            child: Text(
              label,
              style: AppTypography.labelMedium.copyWith(
                color: AppColors.gold,
              ),
            ),
          ),
          Expanded(
            child: Text(
              value.isEmpty ? '-' : value,
              style: AppTypography.bodySmall.copyWith(
                color: AppColors.textSecondary,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _PremiumNotice extends StatelessWidget {
  const _PremiumNotice({required this.onUpgrade});

  final VoidCallback onUpgrade;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: AppColors.goldGlow,
        borderRadius: BorderRadius.circular(AppRadius.md),
        border: Border.all(color: AppColors.gold),
      ),
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.lg),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text('Premium template', style: AppTypography.headlineSmall),
            const SizedBox(height: AppSpacing.sm),
            Text(
              'Upgrade untuk memakai signature template dan builder personal.',
              style: AppTypography.bodySmall.copyWith(
                color: AppColors.textSecondary,
              ),
            ),
            const SizedBox(height: AppSpacing.lg),
            ElevatedButton(
              key: const Key('template-upgrade-button'),
              onPressed: onUpgrade,
              child: const Text('Upgrade'),
            ),
          ],
        ),
      ),
    );
  }
}

class _ApplyTemplateButton extends StatelessWidget {
  const _ApplyTemplateButton({required this.template});

  final Template template;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      key: const Key('template-apply-button'),
      onPressed: () {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('${template.name} diterapkan')),
        );
        context.go(AppRoutes.create);
      },
      icon: const Icon(Icons.auto_awesome_rounded),
      label: const Text('Apply Template'),
    );
  }
}

class _DetailMetric extends StatelessWidget {
  const _DetailMetric({
    required this.icon,
    required this.label,
  });

  final IconData icon;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, color: AppColors.gold, size: 18),
        const SizedBox(width: AppSpacing.xs),
        Text(label, style: AppTypography.labelLarge),
      ],
    );
  }
}

String templateCategoryLabel(String value) {
  if (value == allTemplateCategories) {
    return 'All';
  }
  return value
      .split(RegExp(r'[_-]'))
      .where((part) => part.isNotEmpty)
      .map((part) => '${part[0].toUpperCase()}${part.substring(1)}')
      .join(' ');
}
