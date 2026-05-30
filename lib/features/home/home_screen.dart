import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../core/theme/app_colors.dart';
import '../../core/theme/app_spacing.dart';
import '../../core/theme/app_typography.dart';
import '../../routing/routes.dart';
import '../../shared/widgets/buttons/app_button.dart';
import '../../shared/widgets/cards/app_card.dart';
import '../../shared/widgets/feedback/app_shimmer.dart';
import '../../shared/widgets/feedback/empty_state.dart';
import '../../shared/widgets/feedback/error_state.dart';
import '../../shared/widgets/layout/page_scaffold.dart';
import '../auth/models/user.dart';
import '../auth/providers/current_user_provider.dart';
import 'providers/home_provider.dart';
import 'widgets/greeting_header.dart';
import 'widgets/project_card.dart';
import 'widgets/streak_card.dart';
import 'widgets/template_card.dart';
import 'widgets/tip_card.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(currentUserProvider);
    final homeData = ref.watch(homeDataProvider);

    return PageScaffold(
      key: const Key('home-screen'),
      safeArea: false,
      padding: EdgeInsets.zero,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            pinned: true,
            backgroundColor: AppColors.obsidian.withValues(alpha: 0.94),
            surfaceTintColor: Colors.transparent,
            expandedHeight: 112,
            automaticallyImplyLeading: false,
            flexibleSpace: FlexibleSpaceBar(
              background: SafeArea(
                bottom: false,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(
                    AppSpacing.lg,
                    AppSpacing.md,
                    AppSpacing.lg,
                    AppSpacing.sm,
                  ),
                  child: GreetingHeader(
                    name: user?.name ?? 'Creator',
                    avatarUrl: user?.avatarUrl,
                    tier: user?.tier ?? SubscriptionTier.free,
                    hasUnreadNotifications:
                        homeData.asData?.value.hasUnreadNotifications ?? false,
                    onProfileTap: () => context.go(AppRoutes.profile),
                  ),
                ),
              ),
            ),
          ),
          homeData.when(
            loading: () => const SliverToBoxAdapter(child: _HomeLoading()),
            error: (error, stackTrace) => SliverFillRemaining(
              hasScrollBody: false,
              child: ErrorState(
                title: 'Home belum bisa dimuat.',
                message: 'Coba refresh koneksi dan ulangi sekali lagi.',
                onRetry: () => ref.invalidate(homeDataProvider),
              ),
            ),
            data: (data) => _HomeContent(data: data),
          ),
        ],
      ),
    );
  }
}

class _HomeContent extends StatelessWidget {
  const _HomeContent({required this.data});

  final HomeData data;

  @override
  Widget build(BuildContext context) {
    return SliverList.list(
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(
            AppSpacing.lg,
            AppSpacing.lg,
            AppSpacing.lg,
            0,
          ),
          child: StreakCard(streakCount: data.streakCount),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(
            AppSpacing.lg,
            AppSpacing.lg,
            AppSpacing.lg,
            0,
          ),
          child: _HeroCtaCard(
            onPressed: () => context.go(AppRoutes.create),
          ),
        ),
        const SizedBox(height: AppSpacing.xl),
        _SectionHeader(
          title: 'Project Terbaru',
          actionLabel: data.recentProjects.isEmpty ? null : 'Lihat Semua',
          onActionPressed: () => context.go(AppRoutes.library),
        ),
        if (data.recentProjects.isEmpty)
          Padding(
            key: const Key('home-empty-projects'),
            padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
            child: EmptyState(
              title: 'Belum ada project.',
              message: 'Buat shorts pertama kamu!',
              ctaLabel: 'Mulai Sekarang',
              onCtaPressed: () => context.go(AppRoutes.create),
            ),
          )
        else
          SizedBox(
            height: 226,
            child: ListView.separated(
              padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                final project = data.recentProjects[index];
                return ProjectCard(
                  project: project,
                  onTap: () => context.go(AppRoutes.miniEditorPath(project.id)),
                );
              },
              separatorBuilder: (context, index) =>
                  const SizedBox(width: AppSpacing.md),
              itemCount: data.recentProjects.length,
            ),
          ),
        const SizedBox(height: AppSpacing.xl),
        _SectionHeader(title: 'Template Spotlight'),
        SizedBox(
          height: 366,
          child: ListView.separated(
            padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) {
              final template = data.spotlightTemplates[index];
              return TemplateCard(
                template: template,
                onTap: () =>
                    context.go(AppRoutes.templateDetailPath(template.id)),
              );
            },
            separatorBuilder: (context, index) =>
                const SizedBox(width: AppSpacing.md),
            itemCount: data.spotlightTemplates.length,
          ),
        ),
        const SizedBox(height: AppSpacing.xl),
        const _SectionHeader(title: 'Tips Hari Ini'),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
          child: TipCard(tip: data.tipOfTheDay),
        ),
        const SizedBox(height: 100),
      ],
    );
  }
}

class _HeroCtaCard extends StatelessWidget {
  const _HeroCtaCard({required this.onPressed});

  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return AppCard(
      key: const Key('home-hero-cta-card'),
      variant: AppCardVariant.premiumGold,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(Icons.movie_creation_rounded, color: AppColors.gold),
              const SizedBox(width: AppSpacing.sm),
              Text('Buat Shorts Baru', style: AppTypography.headlineSmall),
            ],
          ),
          const SizedBox(height: AppSpacing.sm),
          Text(
            'Upload bahan mentah, pilih gaya, lalu biarkan AutoShort '
            'menyiapkan versi paling tajam untuk review.',
            style: AppTypography.bodyMedium.copyWith(
              color: AppColors.textSecondary,
            ),
          ),
          const SizedBox(height: AppSpacing.lg),
          AppButton(
            key: const Key('home-create-cta'),
            label: 'Mulai Sekarang',
            fullWidth: true,
            onPressed: onPressed,
          ),
        ],
      ),
    );
  }
}

class _SectionHeader extends StatelessWidget {
  const _SectionHeader({
    required this.title,
    this.actionLabel,
    this.onActionPressed,
  });

  final String title;
  final String? actionLabel;
  final VoidCallback? onActionPressed;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(
        AppSpacing.lg,
        0,
        AppSpacing.lg,
        AppSpacing.md,
      ),
      child: Row(
        children: [
          Expanded(
            child: Text(title, style: AppTypography.headlineSmall),
          ),
          if (actionLabel != null)
            TextButton(
              onPressed: onActionPressed,
              child: Text(
                actionLabel!,
                style: AppTypography.labelMedium.copyWith(
                  color: AppColors.gold,
                ),
              ),
            ),
        ],
      ),
    );
  }
}

class _HomeLoading extends StatelessWidget {
  const _HomeLoading();

  @override
  Widget build(BuildContext context) {
    return Padding(
      key: const Key('home-loading'),
      padding: const EdgeInsets.all(AppSpacing.lg),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AppShimmer.box(height: 132),
          const SizedBox(height: AppSpacing.lg),
          AppShimmer.box(height: 164),
          const SizedBox(height: AppSpacing.xl),
          AppShimmer.box(width: 160, height: 22),
          const SizedBox(height: AppSpacing.md),
          Row(
            children: [
              Expanded(child: AppShimmer.box(height: 176)),
              const SizedBox(width: AppSpacing.md),
              Expanded(child: AppShimmer.box(height: 176)),
            ],
          ),
          const SizedBox(height: AppSpacing.xl),
          AppShimmer.box(width: 180, height: 22),
          const SizedBox(height: AppSpacing.md),
          Row(
            children: [
              Expanded(child: AppShimmer.box(height: 260)),
              const SizedBox(width: AppSpacing.md),
              Expanded(child: AppShimmer.box(height: 260)),
            ],
          ),
        ],
      ),
    );
  }
}
