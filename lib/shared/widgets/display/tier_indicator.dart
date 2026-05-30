import 'package:flutter/material.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_radius.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/theme/app_typography.dart';
import '../../../features/auth/models/user.dart';

class TierIndicator extends StatelessWidget {
  const TierIndicator({
    super.key,
    required this.tier,
  });

  final SubscriptionTier tier;

  @override
  Widget build(BuildContext context) {
    final premium =
        tier == SubscriptionTier.premium || tier == SubscriptionTier.lifetime;
    final label = switch (tier) {
      SubscriptionTier.free => 'Free',
      SubscriptionTier.standard => 'Standard',
      SubscriptionTier.premium => 'Premium',
      SubscriptionTier.lifetime => 'Lifetime',
    };

    return DecoratedBox(
      decoration: BoxDecoration(
        gradient: premium
            ? const LinearGradient(
                colors: [AppColors.goldLight, AppColors.goldDark])
            : null,
        color: premium ? null : AppColors.surface2,
        borderRadius: BorderRadius.circular(AppRadius.pill),
        border:
            Border.all(color: premium ? AppColors.gold : AppColors.surface3),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.md,
          vertical: AppSpacing.xs,
        ),
        child: Text(
          label,
          style: AppTypography.labelSmall.copyWith(
            color: premium ? AppColors.textInverse : AppColors.textSecondary,
          ),
        ),
      ),
    );
  }
}
