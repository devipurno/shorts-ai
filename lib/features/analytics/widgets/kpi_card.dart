import 'package:flutter/material.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_radius.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/theme/app_typography.dart';
import '../../../shared/widgets/cards/app_card.dart';
import '../providers/analytics_provider.dart';

class KpiCard extends StatelessWidget {
  const KpiCard({
    super.key,
    required this.metric,
  });

  final KpiMetric metric;

  @override
  Widget build(BuildContext context) {
    final trendColor = metric.isPositive ? AppColors.success : AppColors.error;

    return SizedBox(
      width: 176,
      child: AppCard(
        variant: AppCardVariant.elevated,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                DecoratedBox(
                  decoration: BoxDecoration(
                    color: AppColors.goldGlow,
                    borderRadius: BorderRadius.circular(AppRadius.md),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(AppSpacing.sm),
                    child: Icon(metric.icon, color: AppColors.gold, size: 20),
                  ),
                ),
                const Spacer(),
                Icon(
                  metric.isPositive
                      ? Icons.arrow_upward_rounded
                      : Icons.arrow_downward_rounded,
                  color: trendColor,
                  size: 16,
                ),
                const SizedBox(width: AppSpacing.xs),
                Text(
                  '${metric.trendPercent.abs().toStringAsFixed(1)}%',
                  style: AppTypography.labelSmall.copyWith(color: trendColor),
                ),
              ],
            ),
            const SizedBox(height: AppSpacing.lg),
            Text(
              _formatNumber(metric.value),
              style: AppTypography.headlineMedium.copyWith(
                color: AppColors.goldLight,
              ),
            ),
            const SizedBox(height: AppSpacing.xs),
            Text(
              metric.label,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: AppTypography.bodySmall.copyWith(
                color: AppColors.textSecondary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

String _formatNumber(int value) {
  if (value >= 1000000) {
    return '${(value / 1000000).toStringAsFixed(1)}M';
  }
  if (value >= 1000) {
    return '${(value / 1000).toStringAsFixed(1)}K';
  }
  return value.toString();
}
