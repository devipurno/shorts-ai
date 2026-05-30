import 'package:flutter/material.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_radius.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/theme/app_typography.dart';
import '../../../shared/widgets/buttons/app_button.dart';
import '../../../shared/widgets/cards/app_card.dart';
import '../providers/thumbnail_provider.dart';
import '../widgets/ab_comparison_view.dart';

class CtrPredictTab extends StatelessWidget {
  const CtrPredictTab({
    super.key,
    required this.state,
    required this.notifier,
  });

  final ThumbnailState state;
  final ThumbnailNotifier notifier;

  @override
  Widget build(BuildContext context) {
    final a = state.ctrPredictionA;
    final b = state.ctrPredictionB;
    final winner = a == null || b == null
        ? null
        : a >= b
            ? 'A'
            : 'B';

    return ListView(
      key: const Key('thumbnail-tab-ctr'),
      padding: const EdgeInsets.all(AppSpacing.lg),
      children: [
        AppButton(
          key: const Key('thumbnail-predict-ctr'),
          label: 'Prediksi CTR',
          isLoading: state.isPredictingCtr,
          icon: const Icon(Icons.insights_rounded),
          onPressed: notifier.predictCTR,
        ),
        const SizedBox(height: AppSpacing.lg),
        Row(
          children: [
            Expanded(
              child: _ScoreCard(label: 'A', score: a, winner: winner == 'A'),
            ),
            const SizedBox(width: AppSpacing.md),
            Expanded(
              child: _ScoreCard(label: 'B', score: b, winner: winner == 'B'),
            ),
          ],
        ),
        const SizedBox(height: AppSpacing.md),
        AppButton(
          label: 'Compare A/B',
          variant: AppButtonVariant.secondary,
          onPressed: () => AbComparisonView.show(context, state),
        ),
        if (state.ctrTips.isNotEmpty) ...[
          const SizedBox(height: AppSpacing.lg),
          AppCard(
            variant: AppCardVariant.glass,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Tips improvement', style: AppTypography.labelLarge),
                const SizedBox(height: AppSpacing.sm),
                for (final tip in state.ctrTips)
                  Padding(
                    padding: const EdgeInsets.only(bottom: AppSpacing.xs),
                    child: Text('- $tip', style: AppTypography.bodySmall),
                  ),
              ],
            ),
          ),
        ],
      ],
    );
  }
}

class _ScoreCard extends StatelessWidget {
  const _ScoreCard({
    required this.label,
    required this.score,
    required this.winner,
  });

  final String label;
  final double? score;
  final bool winner;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: AppColors.surface1,
        borderRadius: BorderRadius.circular(AppRadius.md),
        border: Border.all(color: winner ? AppColors.gold : AppColors.surface3),
        boxShadow: winner
            ? [
                BoxShadow(
                  color: AppColors.gold.withValues(alpha: 0.24),
                  blurRadius: 22,
                ),
              ]
            : null,
      ),
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.lg),
        child: Column(
          children: [
            Text('Variant $label', style: AppTypography.labelLarge),
            const SizedBox(height: AppSpacing.sm),
            Text(
              score == null ? '--' : '${(score! * 100).round()}%',
              style: AppTypography.headlineLarge.copyWith(
                color: winner ? AppColors.gold : AppColors.textPrimary,
              ),
            ),
            if (winner)
              Text(
                'Winner',
                style: AppTypography.labelSmall.copyWith(
                  color: AppColors.gold,
                ),
              ),
          ],
        ),
      ),
    );
  }
}
