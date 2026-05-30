import 'package:flutter/material.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/theme/app_typography.dart';
import '../../../shared/models/thumbnail.dart';
import '../../../shared/widgets/buttons/app_button.dart';
import '../../../shared/widgets/cards/app_card.dart';
import '../providers/thumbnail_provider.dart';

class SaveTab extends StatelessWidget {
  const SaveTab({
    super.key,
    required this.state,
    required this.notifier,
  });

  final ThumbnailState state;
  final ThumbnailNotifier notifier;

  @override
  Widget build(BuildContext context) {
    return ListView(
      key: const Key('thumbnail-tab-save'),
      padding: const EdgeInsets.all(AppSpacing.lg),
      children: [
        AppCard(
          variant: AppCardVariant.premiumGold,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Final selection', style: AppTypography.headlineSmall),
              const SizedBox(height: AppSpacing.sm),
              Text(
                state.isSaved
                    ? 'Thumbnail saved as Variant ${state.selectedVariant.name.toUpperCase()}.'
                    : 'Choose the winning thumbnail variant for review/export.',
                style: AppTypography.bodyMedium.copyWith(
                  color: AppColors.textSecondary,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: AppSpacing.lg),
        AppButton(
          label: 'Save A as Final',
          onPressed: () => notifier.selectFinal(ThumbnailVariant.a),
        ),
        const SizedBox(height: AppSpacing.md),
        AppButton(
          label: 'Save B as Final',
          variant: AppButtonVariant.secondary,
          onPressed: () {
            notifier.saveAsVariantB();
            notifier.selectFinal(ThumbnailVariant.b);
          },
        ),
      ],
    );
  }
}
