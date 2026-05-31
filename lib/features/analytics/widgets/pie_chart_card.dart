import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_radius.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/theme/app_typography.dart';
import '../../../shared/widgets/cards/app_card.dart';
import '../providers/analytics_provider.dart';

class EngagementPieChartCard extends StatelessWidget {
  const EngagementPieChartCard({
    super.key,
    required this.breakdown,
  });

  final EngagementBreakdown breakdown;

  @override
  Widget build(BuildContext context) {
    return AppCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Engagement breakdown', style: AppTypography.headlineSmall),
          const SizedBox(height: AppSpacing.lg),
          SizedBox(
            key: const Key('analytics-pie-chart'),
            height: 220,
            child: PieChart(
              PieChartData(
                sectionsSpace: 3,
                centerSpaceRadius: 54,
                startDegreeOffset: -90,
                borderData: FlBorderData(show: false),
                sections: [
                  for (final segment in breakdown.segments)
                    PieChartSectionData(
                      value: segment.value.toDouble(),
                      title:
                          '${(segment.value / breakdown.total * 100).round()}%',
                      color: segment.color,
                      radius: 72,
                      titleStyle: AppTypography.labelSmall.copyWith(
                        color: AppColors.textInverse,
                      ),
                    ),
                ],
              ),
            ),
          ),
          const SizedBox(height: AppSpacing.md),
          Wrap(
            spacing: AppSpacing.sm,
            runSpacing: AppSpacing.sm,
            children: [
              for (final segment in breakdown.segments)
                DecoratedBox(
                  decoration: BoxDecoration(
                    color: AppColors.surface2,
                    borderRadius: BorderRadius.circular(AppRadius.pill),
                    border: Border.all(color: AppColors.surface3),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: AppSpacing.sm,
                      vertical: AppSpacing.xs,
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        DecoratedBox(
                          decoration: BoxDecoration(
                            color: segment.color,
                            borderRadius: BorderRadius.circular(AppRadius.pill),
                          ),
                          child: const SizedBox.square(dimension: 8),
                        ),
                        const SizedBox(width: AppSpacing.xs),
                        Text(
                          segment.label,
                          style: AppTypography.labelSmall.copyWith(
                            color: AppColors.textSecondary,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
            ],
          ),
        ],
      ),
    );
  }
}
