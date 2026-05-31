import 'package:flutter/material.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_radius.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/theme/app_typography.dart';
import '../../../shared/widgets/cards/app_card.dart';
import '../providers/analytics_provider.dart';

class AudienceDemographicsCard extends StatelessWidget {
  const AudienceDemographicsCard({
    super.key,
    required this.demographics,
  });

  final AudienceDemographics demographics;

  @override
  Widget build(BuildContext context) {
    return AppCard(
      key: const Key('analytics-demographics-card'),
      variant: AppCardVariant.premiumGold,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Audience demographics', style: AppTypography.headlineSmall),
          const SizedBox(height: AppSpacing.lg),
          _SegmentGroup(
            title: 'Age groups',
            segments: demographics.ageGroups,
          ),
          const SizedBox(height: AppSpacing.lg),
          _SegmentGroup(
            title: 'Gender split',
            segments: demographics.genderSplit,
          ),
          const SizedBox(height: AppSpacing.lg),
          _SegmentGroup(
            title: 'Top countries',
            segments: demographics.topCountries,
          ),
        ],
      ),
    );
  }
}

class _SegmentGroup extends StatelessWidget {
  const _SegmentGroup({
    required this.title,
    required this.segments,
  });

  final String title;
  final List<DemographicSegment> segments;

  @override
  Widget build(BuildContext context) {
    final maxValue = segments.fold<double>(
      0,
      (max, segment) => segment.value > max ? segment.value : max,
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: AppTypography.labelLarge.copyWith(
            color: AppColors.goldLight,
          ),
        ),
        const SizedBox(height: AppSpacing.sm),
        for (final segment in segments)
          Padding(
            padding: const EdgeInsets.only(bottom: AppSpacing.sm),
            child: Row(
              children: [
                SizedBox(
                  width: 92,
                  child: Text(
                    segment.label,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: AppTypography.bodySmall.copyWith(
                      color: AppColors.textSecondary,
                    ),
                  ),
                ),
                Expanded(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(AppRadius.pill),
                    child: LinearProgressIndicator(
                      value: maxValue == 0 ? 0 : segment.value / maxValue,
                      minHeight: 8,
                      backgroundColor: AppColors.surface3,
                      color: AppColors.gold,
                    ),
                  ),
                ),
                const SizedBox(width: AppSpacing.sm),
                SizedBox(
                  width: 42,
                  child: Text(
                    '${segment.value.round()}%',
                    textAlign: TextAlign.right,
                    style: AppTypography.labelSmall,
                  ),
                ),
              ],
            ),
          ),
      ],
    );
  }
}
