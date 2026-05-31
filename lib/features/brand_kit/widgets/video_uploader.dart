import 'package:flutter/material.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/theme/app_typography.dart';
import '../../../shared/widgets/buttons/app_button.dart';
import '../../../shared/widgets/cards/app_card.dart';

class VideoUploader extends StatelessWidget {
  const VideoUploader({
    super.key,
    required this.title,
    required this.videoUrl,
    required this.onPick,
    required this.onRemove,
    this.locked = false,
    this.durationLabel = '00:06',
  });

  final String title;
  final String? videoUrl;
  final VoidCallback onPick;
  final VoidCallback onRemove;
  final bool locked;
  final String durationLabel;

  @override
  Widget build(BuildContext context) {
    return AppCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(title, style: AppTypography.headlineSmall),
              const Spacer(),
              if (locked)
                Text(
                  'Premium',
                  style: AppTypography.labelSmall.copyWith(
                    color: AppColors.gold,
                  ),
                ),
            ],
          ),
          const SizedBox(height: AppSpacing.md),
          AspectRatio(
            aspectRatio: 16 / 9,
            child: DecoratedBox(
              decoration: BoxDecoration(
                color: AppColors.surface2,
                borderRadius: BorderRadius.circular(14),
                border: Border.all(color: AppColors.surface3),
              ),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Icon(
                    locked ? Icons.lock_rounded : Icons.movie_rounded,
                    color: AppColors.gold,
                    size: 46,
                  ),
                  if (videoUrl != null)
                    Positioned(
                      left: AppSpacing.md,
                      right: AppSpacing.md,
                      bottom: AppSpacing.md,
                      child: Column(
                        children: [
                          Text(
                            videoUrl!,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            textAlign: TextAlign.center,
                            style: AppTypography.bodySmall.copyWith(
                              color: AppColors.textSecondary,
                            ),
                          ),
                          const SizedBox(height: AppSpacing.xs),
                          Text(
                            durationLabel,
                            style: AppTypography.labelSmall.copyWith(
                              color: AppColors.goldLight,
                            ),
                          ),
                        ],
                      ),
                    ),
                ],
              ),
            ),
          ),
          const SizedBox(height: AppSpacing.md),
          Row(
            children: [
              Expanded(
                child: AppButton(
                  label: locked ? 'Upgrade to unlock' : 'Upload video',
                  variant: AppButtonVariant.secondary,
                  icon:
                      Icon(locked ? Icons.lock_rounded : Icons.upload_rounded),
                  onPressed: locked ? null : onPick,
                ),
              ),
              if (videoUrl != null) ...[
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
