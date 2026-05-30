import 'package:flutter/material.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/theme/app_typography.dart';
import '../../../shared/widgets/cards/app_card.dart';

class StreakCard extends StatelessWidget {
  const StreakCard({
    super.key,
    required this.streakCount,
  });

  final int streakCount;

  @override
  Widget build(BuildContext context) {
    final milestone = _nextMilestone(streakCount);
    final progress = (streakCount / milestone).clamp(0.0, 1.0);

    return TweenAnimationBuilder<double>(
      duration: const Duration(milliseconds: 850),
      curve: Curves.easeInOut,
      tween: Tween<double>(
        begin: 1,
        end: streakCount > 0 ? 1.025 : 1,
      ),
      builder: (context, scale, child) {
        return Transform.scale(scale: scale, child: child);
      },
      child: AppCard(
        key: const Key('home-streak-card'),
        variant: AppCardVariant.premiumGold,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Text('🔥', style: TextStyle(fontSize: 28)),
                const SizedBox(width: AppSpacing.sm),
                Expanded(
                  child: Text(
                    '$streakCount hari berturut-turut!',
                    style: AppTypography.headlineSmall,
                  ),
                ),
              ],
            ),
            const SizedBox(height: AppSpacing.md),
            Text(
              'Menuju milestone $milestone hari',
              style: AppTypography.bodySmall.copyWith(
                color: AppColors.textSecondary,
              ),
            ),
            const SizedBox(height: AppSpacing.sm),
            ClipRRect(
              borderRadius: BorderRadius.circular(999),
              child: LinearProgressIndicator(
                minHeight: 8,
                value: progress,
                color: AppColors.gold,
                backgroundColor: AppColors.surface3,
              ),
            ),
          ],
        ),
      ),
    );
  }

  int _nextMilestone(int value) {
    if (value < 7) {
      return 7;
    }
    if (value < 14) {
      return 14;
    }
    if (value < 30) {
      return 30;
    }
    return 60;
  }
}
