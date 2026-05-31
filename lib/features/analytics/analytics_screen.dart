import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/theme/app_colors.dart';
import '../../core/theme/app_spacing.dart';
import '../../core/theme/app_typography.dart';
import '../../shared/widgets/buttons/app_button.dart';
import '../../shared/widgets/cards/app_card.dart';
import '../../shared/widgets/feedback/app_loader.dart';
import '../../shared/widgets/feedback/error_state.dart';
import '../../shared/widgets/navigation/app_appbar.dart';
import '../auth/models/user.dart';
import '../auth/providers/current_user_provider.dart';
import 'providers/analytics_provider.dart';
import 'widgets/bar_chart_card.dart';
import 'widgets/demographics_card.dart';
import 'widgets/heatmap_card.dart';
import 'widgets/kpi_card.dart';
import 'widgets/line_chart_card.dart';
import 'widgets/pie_chart_card.dart';

class AnalyticsScreen extends ConsumerWidget {
  const AnalyticsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final period = ref.watch(analyticsPeriodProvider);
    final analytics = ref.watch(analyticsProvider(period));
    final tier = ref.watch(currentUserProvider)?.tier ?? SubscriptionTier.free;

    return Scaffold(
      key: const Key('analytics-screen'),
      backgroundColor: AppColors.obsidian,
      appBar: AppAppBar(
        title: 'Analytics',
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: AppSpacing.sm),
            child: _PeriodToggle(
              value: period,
              onChanged: (value) {
                ref.read(analyticsPeriodProvider.notifier).state = value;
              },
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: analytics.when(
          loading: () => const Center(child: AppLoader()),
          error: (error, stackTrace) => ErrorState(
            title: 'Analytics belum bisa dimuat',
            message: 'Coba refresh beberapa saat lagi.',
            onRetry: () => ref.invalidate(analyticsProvider(period)),
          ),
          data: (data) {
            final fullCharts = hasFullAnalyticsCharts(tier);
            final demographics = hasAudienceDemographics(tier);
            return ListView(
              key: const Key('analytics-list'),
              padding: const EdgeInsets.fromLTRB(
                AppSpacing.lg,
                AppSpacing.md,
                AppSpacing.lg,
                AppSpacing.huge,
              ),
              children: [
                _TierSummary(tier: tier),
                const SizedBox(height: AppSpacing.md),
                SizedBox(
                  height: 148,
                  child: ListView.separated(
                    key: const Key('analytics-kpi-list'),
                    scrollDirection: Axis.horizontal,
                    itemCount: data.kpis.length,
                    separatorBuilder: (_, __) =>
                        const SizedBox(width: AppSpacing.md),
                    itemBuilder: (context, index) {
                      return KpiCard(metric: data.kpis[index]);
                    },
                  ),
                ),
                const SizedBox(height: AppSpacing.xl),
                ViewsLineChartCard(points: data.viewsOverTime),
                const SizedBox(height: AppSpacing.xl),
                if (fullCharts) ...[
                  TopVideosBarChartCard(videos: data.topVideos),
                  const SizedBox(height: AppSpacing.xl),
                  EngagementPieChartCard(
                    breakdown: data.engagementBreakdown,
                  ),
                  const SizedBox(height: AppSpacing.xl),
                  BestPostingHeatmapCard(cells: data.bestPostingTimes),
                ] else ...[
                  const _LockedAnalyticsCard(
                    title: 'Full charts locked',
                    message:
                        'Upgrade ke Standard untuk bar chart, engagement breakdown, dan heatmap.',
                  ),
                ],
                const SizedBox(height: AppSpacing.xl),
                if (demographics)
                  AudienceDemographicsCard(demographics: data.demographics)
                else
                  const _LockedAnalyticsCard(
                    title: 'Audience demographics locked',
                    message:
                        'Upgrade ke Premium untuk demographics dan export PDF.',
                  ),
                if (canExportAnalyticsPdf(tier)) ...[
                  const SizedBox(height: AppSpacing.lg),
                  AppButton(
                    key: const Key('analytics-export-pdf-button'),
                    label: 'Export PDF',
                    fullWidth: true,
                    icon: const Icon(Icons.picture_as_pdf_rounded),
                    onPressed: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('PDF export queued (mock).'),
                        ),
                      );
                    },
                  ),
                ],
              ],
            );
          },
        ),
      ),
    );
  }
}

class _PeriodToggle extends StatelessWidget {
  const _PeriodToggle({
    required this.value,
    required this.onChanged,
  });

  final AnalyticsPeriod value;
  final ValueChanged<AnalyticsPeriod> onChanged;

  @override
  Widget build(BuildContext context) {
    return SegmentedButton<AnalyticsPeriod>(
      key: const Key('analytics-period-toggle'),
      segments: [
        for (final period in AnalyticsPeriod.values)
          ButtonSegment(
            value: period,
            label: Text(period.label),
          ),
      ],
      selected: {value},
      showSelectedIcon: false,
      onSelectionChanged: (selection) => onChanged(selection.single),
      style: ButtonStyle(
        visualDensity: VisualDensity.compact,
        textStyle: WidgetStatePropertyAll(AppTypography.labelSmall),
        foregroundColor: WidgetStateProperty.resolveWith((states) {
          return states.contains(WidgetState.selected)
              ? AppColors.textInverse
              : AppColors.gold;
        }),
        backgroundColor: WidgetStateProperty.resolveWith((states) {
          return states.contains(WidgetState.selected)
              ? AppColors.gold
              : AppColors.surface2;
        }),
        side: const WidgetStatePropertyAll(BorderSide(color: AppColors.gold)),
      ),
    );
  }
}

class _TierSummary extends StatelessWidget {
  const _TierSummary({required this.tier});

  final SubscriptionTier tier;

  @override
  Widget build(BuildContext context) {
    final message = switch (tier) {
      SubscriptionTier.free => 'Basic metrics aktif',
      SubscriptionTier.standard => 'Full charts aktif',
      SubscriptionTier.premium ||
      SubscriptionTier.lifetime =>
        'Demographics dan PDF export aktif',
    };

    return AppCard(
      variant: tier == SubscriptionTier.free
          ? AppCardVariant.flat
          : AppCardVariant.premiumGold,
      child: Row(
        children: [
          const Icon(Icons.query_stats_rounded, color: AppColors.gold),
          const SizedBox(width: AppSpacing.sm),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Creator Analytics', style: AppTypography.labelLarge),
                const SizedBox(height: AppSpacing.xs),
                Text(
                  message,
                  style: AppTypography.bodySmall.copyWith(
                    color: AppColors.textSecondary,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _LockedAnalyticsCard extends StatelessWidget {
  const _LockedAnalyticsCard({
    required this.title,
    required this.message,
  });

  final String title;
  final String message;

  @override
  Widget build(BuildContext context) {
    return AppCard(
      key: Key('analytics-locked-${title.toLowerCase().replaceAll(' ', '-')}'),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Icon(Icons.lock_rounded, color: AppColors.gold),
          const SizedBox(width: AppSpacing.md),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: AppTypography.headlineSmall),
                const SizedBox(height: AppSpacing.xs),
                Text(
                  message,
                  style: AppTypography.bodyMedium.copyWith(
                    color: AppColors.textSecondary,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
