import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/theme/app_typography.dart';
import '../../../shared/widgets/display/app_chip.dart';
import '../providers/onboarding_provider.dart';

class StepGoals extends ConsumerWidget {
  const StepGoals({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(onboardingProvider);
    final notifier = ref.read(onboardingProvider.notifier);

    return Column(
      key: const ValueKey('onboarding-step-goals'),
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          'Apa target kreatormu?',
          style: AppTypography.headlineLarge.copyWith(
            color: AppColors.textPrimary,
          ),
        ),
        const SizedBox(height: AppSpacing.sm),
        Text(
          'Pilih maksimal 3 supaya pengalaman AutoShort tetap fokus.',
          style: AppTypography.bodyMedium.copyWith(
            color: AppColors.textSecondary,
          ),
        ),
        const SizedBox(height: AppSpacing.xl),
        Wrap(
          spacing: AppSpacing.md,
          runSpacing: AppSpacing.md,
          children: [
            for (final goal in onboardingGoals)
              AppChip(
                label: goal,
                variant: AppChipVariant.selectable,
                selected: state.goals.contains(goal),
                onSelected: (_) => notifier.toggleGoal(goal),
              ),
          ],
        ),
        const SizedBox(height: AppSpacing.lg),
        Text(
          '${state.goals.length}/3 dipilih',
          style: AppTypography.labelMedium.copyWith(
            color: state.goals.length == OnboardingNotifier.maxGoals
                ? AppColors.gold
                : AppColors.textTertiary,
          ),
        ),
      ],
    );
  }
}
