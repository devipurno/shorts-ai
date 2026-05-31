import 'package:flutter/material.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/theme/app_typography.dart';
import '../../../shared/widgets/buttons/app_button.dart';
import '../../../shared/widgets/cards/app_card.dart';

class LogoUploader extends StatelessWidget {
  const LogoUploader({
    super.key,
    required this.title,
    required this.assetUrl,
    required this.onPick,
    required this.onRemove,
    this.locked = false,
  });

  final String title;
  final String? assetUrl;
  final VoidCallback onPick;
  final VoidCallback onRemove;
  final bool locked;

  @override
  Widget build(BuildContext context) {
    return AppCard(
      variant: AppCardVariant.glass,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: AppTypography.headlineSmall),
          const SizedBox(height: AppSpacing.md),
          AspectRatio(
            aspectRatio: 16 / 9,
            child: DecoratedBox(
              decoration: BoxDecoration(
                color: AppColors.surface2,
                borderRadius: BorderRadius.circular(14),
                border: Border.all(color: AppColors.surface3),
              ),
              child: Center(
                child: assetUrl == null
                    ? Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            locked
                                ? Icons.lock_rounded
                                : Icons.add_photo_alternate_rounded,
                            color: AppColors.gold,
                            size: 42,
                          ),
                          const SizedBox(height: AppSpacing.sm),
                          Text(
                            locked ? 'Locked' : 'Tap upload',
                            style: AppTypography.labelLarge.copyWith(
                              color: AppColors.textSecondary,
                            ),
                          ),
                        ],
                      )
                    : Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Icon(
                            Icons.image_rounded,
                            color: AppColors.gold,
                            size: 42,
                          ),
                          const SizedBox(height: AppSpacing.sm),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: AppSpacing.lg,
                            ),
                            child: Text(
                              assetUrl!,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              textAlign: TextAlign.center,
                              style: AppTypography.bodySmall.copyWith(
                                color: AppColors.textSecondary,
                              ),
                            ),
                          ),
                        ],
                      ),
              ),
            ),
          ),
          const SizedBox(height: AppSpacing.md),
          Row(
            children: [
              Expanded(
                child: AppButton(
                  label: locked ? 'Upgrade required' : 'Upload',
                  variant: AppButtonVariant.secondary,
                  icon:
                      Icon(locked ? Icons.lock_rounded : Icons.upload_rounded),
                  onPressed: locked ? null : onPick,
                ),
              ),
              if (assetUrl != null) ...[
                const SizedBox(width: AppSpacing.sm),
                AppButton(
                  label: 'Remove',
                  variant: AppButtonVariant.ghost,
                  onPressed: locked ? null : onRemove,
                ),
              ],
            ],
          ),
        ],
      ),
    );
  }
}
