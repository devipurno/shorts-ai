import 'package:flutter/material.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/theme/app_typography.dart';
import '../../../shared/widgets/cards/app_card.dart';

class TipCard extends StatelessWidget {
  const TipCard({
    super.key,
    required this.tip,
    this.onLearnMore,
  });

  final String tip;
  final VoidCallback? onLearnMore;

  @override
  Widget build(BuildContext context) {
    return AppCard(
      key: const Key('home-tip-card'),
      variant: AppCardVariant.glass,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('💡', style: TextStyle(fontSize: 26)),
          const SizedBox(width: AppSpacing.md),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  tip,
                  style: AppTypography.bodyMedium.copyWith(
                    color: AppColors.textPrimary,
                  ),
                ),
                const SizedBox(height: AppSpacing.sm),
                GestureDetector(
                  onTap: onLearnMore,
                  child: Text(
                    'Pelajari',
                    style: AppTypography.labelMedium.copyWith(
                      color: AppColors.gold,
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
