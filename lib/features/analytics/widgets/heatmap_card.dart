import 'package:flutter/material.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_radius.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/theme/app_typography.dart';
import '../../../shared/widgets/cards/app_card.dart';
import '../providers/analytics_provider.dart';

class BestPostingHeatmapCard extends StatelessWidget {
  const BestPostingHeatmapCard({
    super.key,
    required this.cells,
  });

  final List<PostingTimeCell> cells;

  @override
  Widget build(BuildContext context) {
    return AppCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Best posting time', style: AppTypography.headlineSmall),
          const SizedBox(height: AppSpacing.xs),
          Text(
            '7 days x 24 hours heatmap',
            style: AppTypography.bodySmall.copyWith(
              color: AppColors.textSecondary,
            ),
          ),
          const SizedBox(height: AppSpacing.lg),
          SizedBox(
            key: const Key('analytics-heatmap'),
            height: 184,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  children: [
                    const SizedBox(height: 20),
                    for (final day in _days)
                      SizedBox(
                        height: 20,
                        width: 34,
                        child: Text(
                          day,
                          style: AppTypography.labelSmall.copyWith(
                            color: AppColors.textTertiary,
                          ),
                        ),
                      ),
                  ],
                ),
                const SizedBox(width: AppSpacing.sm),
                Expanded(
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            for (var hour = 0; hour < 24; hour += 3)
                              SizedBox(
                                width: 54,
                                child: Text(
                                  hour.toString().padLeft(2, '0'),
                                  style: AppTypography.labelSmall.copyWith(
                                    color: AppColors.textTertiary,
                                  ),
                                ),
                              ),
                          ],
                        ),
                        const SizedBox(height: AppSpacing.xs),
                        for (var day = 0; day < 7; day++)
                          Row(
                            children: [
                              for (var hour = 0; hour < 24; hour++)
                                _HeatCell(score: _score(day, hour)),
                            ],
                          ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  double _score(int day, int hour) {
    return cells
        .firstWhere(
          (cell) => cell.day == day && cell.hour == hour,
          orElse: () => PostingTimeCell(day: day, hour: hour, score: 0),
        )
        .score;
  }
}

class _HeatCell extends StatelessWidget {
  const _HeatCell({required this.score});

  final double score;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(2),
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: Color.lerp(AppColors.surface2, AppColors.gold, score),
          borderRadius: BorderRadius.circular(AppRadius.sm),
          border: Border.all(color: AppColors.surface3.withValues(alpha: 0.5)),
        ),
        child: const SizedBox.square(dimension: 16),
      ),
    );
  }
}

const _days = ['M', 'T', 'W', 'T', 'F', 'S', 'S'];
