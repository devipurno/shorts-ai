import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_radius.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/theme/app_typography.dart';
import '../../../shared/widgets/cards/app_card.dart';
import '../providers/onboarding_provider.dart';

class StepTier extends ConsumerWidget {
  const StepTier({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(onboardingProvider);
    final notifier = ref.read(onboardingProvider.notifier);

    return Column(
      key: const ValueKey('onboarding-step-tier'),
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          'Mulai dengan paket yang pas',
          style: AppTypography.headlineLarge.copyWith(
            color: AppColors.textPrimary,
          ),
        ),
        const SizedBox(height: AppSpacing.sm),
        Text(
          'Premium membuka workflow paling lengkap untuk trial pertama.',
          style: AppTypography.bodyMedium.copyWith(
            color: AppColors.textSecondary,
          ),
        ),
        const SizedBox(height: AppSpacing.xl),
        for (final tier in onboardingTiers) ...[
          _TierCard(
            tier: tier,
            selected: state.selectedTier == tier,
            highlighted: tier == 'Premium',
            onTap: () => notifier.setTier(tier),
          ),
          const SizedBox(height: AppSpacing.md),
        ],
      ],
    );
  }
}

class _TierCard extends StatelessWidget {
  const _TierCard({
    required this.tier,
    required this.selected,
    required this.highlighted,
    required this.onTap,
  });

  final String tier;
  final bool selected;
  final bool highlighted;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final variant = highlighted || selected
        ? AppCardVariant.premiumGold
        : AppCardVariant.flat;

    return AppCard(
      variant: variant,
      padding: EdgeInsets.zero,
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 180),
        padding: const EdgeInsets.all(AppSpacing.lg),
        decoration: BoxDecoration(
          color: selected ? AppColors.goldGlow : Colors.transparent,
          borderRadius: BorderRadius.circular(AppRadius.md),
        ),
        child: Row(
          children: [
            Icon(
              selected ? Icons.check_circle : Icons.circle_outlined,
              color: highlighted ? AppColors.gold : AppColors.textTertiary,
            ),
            const SizedBox(width: AppSpacing.md),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    tier,
                    style: AppTypography.labelLarge.copyWith(
                      color: highlighted
                          ? AppColors.goldLight
                          : AppColors.textPrimary,
                    ),
                  ),
                  if (highlighted) ...[
                    const SizedBox(height: AppSpacing.xs),
                    Text(
                      'Mulai 14 hari trial gratis',
                      style: AppTypography.bodySmall.copyWith(
                        color: AppColors.gold,
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
