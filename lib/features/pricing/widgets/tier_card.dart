import 'package:flutter/material.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_radius.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/theme/app_typography.dart';
import '../../../shared/widgets/buttons/app_button.dart';
import '../../../shared/widgets/cards/app_card.dart';
import '../../auth/models/user.dart';
import '../providers/pricing_provider.dart';

class TierCard extends StatelessWidget {
  const TierCard({
    super.key,
    required this.plan,
    required this.billing,
    required this.onSelect,
    this.lifetimeSlots,
    this.isLoading = false,
    this.currentTier,
  });

  final PricingPlan plan;
  final BillingCycle billing;
  final VoidCallback onSelect;
  final int? lifetimeSlots;
  final bool isLoading;
  final SubscriptionTier? currentTier;

  @override
  Widget build(BuildContext context) {
    final isCurrent = currentTier == plan.tier;
    final urgency = plan.tier == SubscriptionTier.lifetime &&
        lifetimeSlots != null &&
        lifetimeSlots! > 0;

    return AppCard(
      key: Key('pricing-tier-${plan.tier.name}'),
      variant:
          plan.highlighted ? AppCardVariant.premiumGold : AppCardVariant.flat,
      padding: const EdgeInsets.all(AppSpacing.xl),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(plan.title, style: AppTypography.headlineLarge),
                    const SizedBox(height: AppSpacing.xs),
                    Text(
                      plan.description,
                      style: AppTypography.bodySmall.copyWith(
                        color: AppColors.textSecondary,
                      ),
                    ),
                  ],
                ),
              ),
              if (plan.badge != null)
                _Badge(
                  label: plan.badge!,
                  gold: plan.highlighted,
                ),
            ],
          ),
          const SizedBox(height: AppSpacing.lg),
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                plan.priceLabel(billing),
                style: AppTypography.displaySmall.copyWith(
                  color:
                      plan.highlighted ? AppColors.gold : AppColors.textPrimary,
                ),
              ),
              const SizedBox(width: AppSpacing.xs),
              Padding(
                padding: const EdgeInsets.only(bottom: 4),
                child: Text(
                  plan.suffixLabel(billing),
                  style: AppTypography.bodySmall.copyWith(
                    color: AppColors.textSecondary,
                  ),
                ),
              ),
            ],
          ),
          if (billing == BillingCycle.yearly &&
              !plan.oneTime &&
              plan.monthlyPrice > 0)
            Padding(
              padding: const EdgeInsets.only(top: AppSpacing.xs),
              child: Text(
                'Hemat 20% dibanding monthly',
                style: AppTypography.labelMedium.copyWith(
                  color: AppColors.success,
                ),
              ),
            ),
          if (urgency)
            Padding(
              padding: const EdgeInsets.only(top: AppSpacing.sm),
              child: _Badge(
                label: '$lifetimeSlots slots tersisa',
                gold: true,
              ),
            ),
          const SizedBox(height: AppSpacing.lg),
          ...plan.features.map(
            (feature) => Padding(
              padding: const EdgeInsets.only(bottom: AppSpacing.sm),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Icon(
                    Icons.check_circle_rounded,
                    color: AppColors.gold,
                    size: 18,
                  ),
                  const SizedBox(width: AppSpacing.sm),
                  Expanded(
                    child: Text(
                      feature,
                      style: AppTypography.bodyMedium.copyWith(
                        color: AppColors.textSecondary,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: AppSpacing.md),
          AppButton(
            key: Key('pricing-select-${plan.tier.name}'),
            label: isCurrent ? 'Plan Aktif' : 'Pilih Plan',
            fullWidth: true,
            isLoading: isLoading,
            variant: plan.highlighted
                ? AppButtonVariant.primary
                : AppButtonVariant.secondary,
            onPressed: isCurrent ? null : onSelect,
          ),
        ],
      ),
    );
  }
}

class _Badge extends StatelessWidget {
  const _Badge({
    required this.label,
    required this.gold,
  });

  final String label;
  final bool gold;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: gold ? AppColors.goldGlow : AppColors.surface2,
        borderRadius: BorderRadius.circular(AppRadius.pill),
        border: Border.all(color: gold ? AppColors.gold : AppColors.surface3),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.sm,
          vertical: AppSpacing.xs,
        ),
        child: Text(
          label,
          style: AppTypography.labelSmall.copyWith(
            color: gold ? AppColors.goldLight : AppColors.textSecondary,
          ),
        ),
      ),
    );
  }
}
