import 'package:flutter/material.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/theme/app_typography.dart';
import '../../../shared/widgets/cards/app_card.dart';
import '../providers/pricing_provider.dart';

class FaqAccordion extends StatelessWidget {
  const FaqAccordion({
    super.key,
    required this.items,
  });

  final List<PricingFaq> items;

  @override
  Widget build(BuildContext context) {
    return AppCard(
      key: const Key('pricing-faq'),
      padding: EdgeInsets.zero,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(
              AppSpacing.lg,
              AppSpacing.lg,
              AppSpacing.lg,
              AppSpacing.sm,
            ),
            child: Text('FAQ', style: AppTypography.headlineSmall),
          ),
          for (final item in items)
            Theme(
              data: Theme.of(context).copyWith(
                dividerColor: Colors.transparent,
                splashColor: AppColors.goldGlow,
              ),
              child: ExpansionTile(
                key: Key('pricing-faq-${item.question.hashCode}'),
                iconColor: AppColors.gold,
                collapsedIconColor: AppColors.textSecondary,
                tilePadding: const EdgeInsets.symmetric(
                  horizontal: AppSpacing.lg,
                ),
                title: Text(
                  item.question,
                  style: AppTypography.labelLarge,
                ),
                childrenPadding: const EdgeInsets.fromLTRB(
                  AppSpacing.lg,
                  0,
                  AppSpacing.lg,
                  AppSpacing.lg,
                ),
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      item.answer,
                      style: AppTypography.bodyMedium.copyWith(
                        color: AppColors.textSecondary,
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
}
