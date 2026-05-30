import 'package:flutter/material.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_radius.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/theme/app_typography.dart';
import '../providers/thumbnail_provider.dart';

class StickerTab extends StatelessWidget {
  const StickerTab({
    super.key,
    required this.state,
    required this.notifier,
  });

  final ThumbnailState state;
  final ThumbnailNotifier notifier;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      key: const Key('thumbnail-tab-sticker'),
      padding: const EdgeInsets.all(AppSpacing.lg),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 5,
        crossAxisSpacing: AppSpacing.sm,
        mainAxisSpacing: AppSpacing.sm,
      ),
      itemCount: _stickers.length,
      itemBuilder: (context, index) {
        final sticker = _stickers[index];
        return InkWell(
          onTap: () => notifier.addSticker(sticker),
          borderRadius: BorderRadius.circular(AppRadius.md),
          child: DecoratedBox(
            decoration: BoxDecoration(
              color: AppColors.surface1,
              borderRadius: BorderRadius.circular(AppRadius.md),
              border: Border.all(color: AppColors.surface3),
            ),
            child: Center(
              child: Text(sticker, style: AppTypography.displaySmall),
            ),
          ),
        );
      },
    );
  }
}

const _stickers = [
  '🔥',
  '⚡',
  '💥',
  '🎯',
  '😱',
  '🚀',
  '👀',
  '✨',
  '💎',
  '✅',
  '⬆️',
  '⭐',
  '🏆',
  '📈',
  '💡',
];
