import 'package:flutter/material.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_radius.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/theme/app_typography.dart';
import '../providers/thumbnail_provider.dart';

class FramePickerTab extends StatelessWidget {
  const FramePickerTab({
    super.key,
    required this.state,
    required this.notifier,
  });

  final ThumbnailState state;
  final ThumbnailNotifier notifier;

  @override
  Widget build(BuildContext context) {
    final canvas = notifier.selectedCanvas;
    return GridView.builder(
      key: const Key('thumbnail-tab-frame'),
      padding: const EdgeInsets.all(AppSpacing.lg),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        childAspectRatio: 9 / 16,
        crossAxisSpacing: AppSpacing.sm,
        mainAxisSpacing: AppSpacing.sm,
      ),
      itemCount: 6,
      itemBuilder: (context, index) {
        final id = 'frame_${index + 1}';
        final selected = canvas.baseFrameId == id;
        return InkWell(
          key: Key('thumbnail-frame-$id'),
          onTap: () => notifier.setBaseFrame(id, 'Frame ${index + 1}'),
          borderRadius: BorderRadius.circular(AppRadius.md),
          child: DecoratedBox(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(AppRadius.md),
              border: Border.all(
                color: selected ? AppColors.gold : AppColors.surface3,
                width: selected ? 2 : 1,
              ),
              gradient: LinearGradient(
                colors: [
                  Color(0xFF101117 + index * 0x00050808),
                  index.isEven ? AppColors.goldDark : AppColors.info,
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            child: Center(
              child: Text(
                'Frame ${index + 1}',
                style: AppTypography.labelMedium.copyWith(
                  color: selected ? AppColors.goldLight : AppColors.textPrimary,
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
