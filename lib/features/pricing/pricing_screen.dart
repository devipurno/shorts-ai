import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../core/theme/app_colors.dart';
import '../../core/theme/app_radius.dart';
import '../../core/theme/app_spacing.dart';
import '../../core/theme/app_typography.dart';
import '../../routing/routes.dart';
import '../../shared/widgets/buttons/icon_button.dart';
import '../../shared/widgets/feedback/app_loader.dart';
import '../../shared/widgets/feedback/error_state.dart';
import '../../shared/widgets/navigation/app_appbar.dart';
import '../auth/providers/current_user_provider.dart';
import 'providers/pricing_provider.dart';
import 'widgets/comparison_table.dart';
import 'widgets/faq_accordion.dart';
import 'widgets/tier_card.dart';

class PricingScreen extends ConsumerWidget {
  const PricingScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final billing = ref.watch(pricingBillingCycleProvider);
    final plans = ref.watch(pricingPlansProvider);
    final tierMatrix = ref.watch(tierMatrixProvider);
    final faqs = ref.watch(pricingFaqProvider);
    final lifetimeSlots = ref.watch(lifetimeSlotsProvider);
    final mutation = ref.watch(subscribeMutationProvider);
    final currentTier = ref.watch(currentUserProvider)?.tier;

    return Scaffold(
      key: const Key('pricing-screen'),
      backgroundColor: AppColors.obsidian,
      appBar: AppAppBar(
        title: 'Upgrade Plan',
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: AppSpacing.sm),
            child: AppIconButton(
              key: const Key('pricing-close-button'),
              tooltip: 'Close',
              icon: const Icon(Icons.close_rounded),
              onPressed: () {
                if (context.canPop()) {
                  context.pop();
                } else {
                  context.go(AppRoutes.home);
                }
              },
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: lifetimeSlots.when(
          loading: () => const Center(child: AppLoader()),
          error: (error, stackTrace) => ErrorState(
            title: 'Pricing belum bisa dimuat',
            message: 'Coba buka ulang halaman upgrade.',
            onRetry: () => ref.invalidate(lifetimeSlotsProvider),
          ),
          data: (slots) {
            return ListView(
              key: const Key('pricing-list'),
              padding: const EdgeInsets.fromLTRB(
                AppSpacing.lg,
                AppSpacing.md,
                AppSpacing.lg,
                AppSpacing.huge,
              ),
              children: [
                Text(
                  'Pilih paket yang cocok untuk ritme konten kamu.',
                  style: AppTypography.bodyMedium.copyWith(
                    color: AppColors.textSecondary,
                  ),
                ),
                const SizedBox(height: AppSpacing.lg),
                _BillingToggle(
                  value: billing,
                  onChanged: (value) {
                    ref.read(pricingBillingCycleProvider.notifier).state =
                        value;
                  },
                ),
                const SizedBox(height: AppSpacing.xl),
                for (final plan in plans) ...[
                  TierCard(
                    plan: plan,
                    billing: billing,
                    lifetimeSlots: slots,
                    currentTier: currentTier,
                    isLoading: mutation.isLoading,
                    onSelect: () async {
                      final checkoutPath = await ref
                          .read(subscribeMutationProvider.notifier)
                          .subscribe(plan.tier, billing);
                      if (context.mounted) {
                        context.go(checkoutPath);
                      }
                    },
                  ),
                  const SizedBox(height: AppSpacing.lg),
                ],
                ComparisonTable(features: tierMatrix),
                const SizedBox(height: AppSpacing.xl),
                FaqAccordion(items: faqs),
              ],
            );
          },
        ),
      ),
    );
  }
}

class _BillingToggle extends StatelessWidget {
  const _BillingToggle({
    required this.value,
    required this.onChanged,
  });

  final BillingCycle value;
  final ValueChanged<BillingCycle> onChanged;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: AppColors.surface1,
        borderRadius: BorderRadius.circular(AppRadius.md),
        border: Border.all(color: AppColors.surface3),
      ),
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.sm),
        child: Row(
          children: [
            Expanded(
              child: SegmentedButton<BillingCycle>(
                key: const Key('pricing-billing-toggle'),
                segments: const [
                  ButtonSegment(
                    value: BillingCycle.monthly,
                    label: Text('Monthly'),
                  ),
                  ButtonSegment(
                    value: BillingCycle.yearly,
                    label: Text('Yearly'),
                  ),
                ],
                selected: {value},
                showSelectedIcon: false,
                onSelectionChanged: (selection) => onChanged(selection.single),
                style: ButtonStyle(
                  foregroundColor: WidgetStateProperty.resolveWith((states) {
                    return states.contains(WidgetState.selected)
                        ? AppColors.textInverse
                        : AppColors.gold;
                  }),
                  backgroundColor: WidgetStateProperty.resolveWith((states) {
                    return states.contains(WidgetState.selected)
                        ? AppColors.gold
                        : Colors.transparent;
                  }),
                  side: const WidgetStatePropertyAll(
                    BorderSide(color: AppColors.gold),
                  ),
                ),
              ),
            ),
            const SizedBox(width: AppSpacing.sm),
            DecoratedBox(
              key: const Key('pricing-yearly-discount-badge'),
              decoration: BoxDecoration(
                color: AppColors.success.withValues(alpha: 0.16),
                borderRadius: BorderRadius.circular(AppRadius.pill),
                border: Border.all(color: AppColors.success),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppSpacing.sm,
                  vertical: AppSpacing.xs,
                ),
                child: Text(
                  '20% OFF',
                  style: AppTypography.labelSmall.copyWith(
                    color: AppColors.success,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
