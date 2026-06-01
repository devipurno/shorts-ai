import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../core/theme/app_colors.dart';
import '../../core/theme/app_radius.dart';
import '../../core/theme/app_spacing.dart';
import '../../core/theme/app_typography.dart';
import '../../routing/routes.dart';
import '../../shared/widgets/display/app_chip.dart';
import '../../shared/widgets/feedback/app_shimmer.dart';
import '../../shared/widgets/feedback/empty_state.dart';
import '../../shared/widgets/feedback/error_state.dart';
import '../../shared/widgets/layout/page_scaffold.dart';
import '../../shared/widgets/modals/app_bottom_sheet.dart';
import 'models/template_model.dart';
import 'providers/template_provider.dart';
import 'widgets/template_card.dart';

class TemplatesGalleryScreen extends ConsumerWidget {
  const TemplatesGalleryScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedCategory = ref.watch(selectedCategoryProvider);
    final templates = ref.watch(filteredTemplatesProvider);

    return PageScaffold(
      key: const Key('templates-gallery-screen'),
      title: 'Template',
      padding: EdgeInsets.zero,
      body: RefreshIndicator(
        key: const Key('templates-refresh-indicator'),
        color: AppColors.gold,
        backgroundColor: AppColors.surface1,
        onRefresh: () async {
          ref.invalidate(templatesProvider);
          await ref.read(templatesProvider.future);
        },
        child: CustomScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          slivers: [
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(
                  AppSpacing.lg,
                  AppSpacing.lg,
                  AppSpacing.lg,
                  AppSpacing.md,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const _StarterBanner(),
                    const SizedBox(height: AppSpacing.lg),
                    _CategoryChips(selectedCategory: selectedCategory),
                  ],
                ),
              ),
            ),
            templates.when(
              loading: () => const _TemplatesLoadingGrid(),
              error: (error, stackTrace) => SliverFillRemaining(
                hasScrollBody: false,
                child: ErrorState(
                  title: 'Template belum bisa dimuat.',
                  message: 'Tarik untuk refresh atau coba lagi nanti.',
                  onRetry: () => ref.invalidate(templatesProvider),
                ),
              ),
              data: (items) => _TemplatesGrid(
                templates: items,
                onOpen: (template) {
                  context.go(AppRoutes.templateDetailPath(template.id));
                },
                onInfo: (template) => _showTemplateInfo(context, template),
              ),
            ),
            const SliverToBoxAdapter(child: SizedBox(height: 110)),
          ],
        ),
      ),
    );
  }

  Future<void> _showTemplateInfo(
    BuildContext context,
    TemplateModel template,
  ) {
    return AppBottomSheet.show<void>(
      context,
      child: Column(
        key: const Key('template-info-sheet'),
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(template.name, style: AppTypography.headlineSmall),
          const SizedBox(height: AppSpacing.sm),
          Text(
            template.description,
            style: AppTypography.bodyMedium.copyWith(
              color: AppColors.textSecondary,
            ),
          ),
          const SizedBox(height: AppSpacing.md),
          Wrap(
            spacing: AppSpacing.sm,
            runSpacing: AppSpacing.sm,
            children: [
              AppChip(label: template.category),
              AppChip(label: '${template.duration.inSeconds}s'),
              for (final tag in template.tags) AppChip(label: tag),
            ],
          ),
        ],
      ),
    );
  }
}

class _StarterBanner extends StatelessWidget {
  const _StarterBanner();

  @override
  Widget build(BuildContext context) {
    return Container(
      key: const Key('templates-starter-banner'),
      padding: const EdgeInsets.all(AppSpacing.lg),
      decoration: BoxDecoration(
        color: AppColors.surface1,
        borderRadius: BorderRadius.circular(AppRadius.lg),
        border: Border.all(color: AppColors.goldGlow),
        boxShadow: const [
          BoxShadow(
            color: AppColors.goldGlow,
            blurRadius: 24,
            offset: Offset(0, 10),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Icon(Icons.movie_creation_outlined, color: AppColors.gold),
          const SizedBox(width: AppSpacing.md),
          Expanded(
            child: Text(
              '5 template starter, free untuk semua user. Premium templates coming v0.2.x',
              style: AppTypography.bodyMedium.copyWith(
                color: AppColors.textPrimary,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _CategoryChips extends ConsumerWidget {
  const _CategoryChips({required this.selectedCategory});

  final String? selectedCategory;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SizedBox(
      key: const Key('template-filter-chips'),
      height: 42,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          final category = templateGalleryCategories[index];
          final selected = (selectedCategory ?? 'All') == category;
          return AppChip(
            key: Key('template-filter-$category'),
            label: category,
            variant: AppChipVariant.selectable,
            selected: selected,
            onSelected: (_) {
              ref.read(selectedCategoryProvider.notifier).state =
                  category == 'All' ? null : category;
            },
          );
        },
        separatorBuilder: (context, index) =>
            const SizedBox(width: AppSpacing.sm),
        itemCount: templateGalleryCategories.length,
      ),
    );
  }
}

class _TemplatesGrid extends StatelessWidget {
  const _TemplatesGrid({
    required this.templates,
    required this.onOpen,
    required this.onInfo,
  });

  final List<TemplateModel> templates;
  final ValueChanged<TemplateModel> onOpen;
  final ValueChanged<TemplateModel> onInfo;

  @override
  Widget build(BuildContext context) {
    if (templates.isEmpty) {
      return const SliverFillRemaining(
        hasScrollBody: false,
        child: EmptyState(
          title: 'Belum ada template',
          message: 'Template untuk kategori ini belum tersedia.',
          icon: Icons.movie_filter_outlined,
        ),
      );
    }

    return SliverPadding(
      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
      sliver: SliverGrid(
        key: const Key('templates-gallery-grid'),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 9 / 16,
          crossAxisSpacing: AppSpacing.md,
          mainAxisSpacing: AppSpacing.md,
        ),
        delegate: SliverChildBuilderDelegate(
          (context, index) {
            final template = templates[index];
            return TemplateCard(
              template: template,
              onTap: () => onOpen(template),
              onLongPress: () => onInfo(template),
            );
          },
          childCount: templates.length,
        ),
      ),
    );
  }
}

class _TemplatesLoadingGrid extends StatelessWidget {
  const _TemplatesLoadingGrid();

  @override
  Widget build(BuildContext context) {
    return SliverPadding(
      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
      sliver: SliverGrid(
        key: const Key('templates-loading-grid'),
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
      ),
    );
  }
}
