import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/theme/app_typography.dart';
import '../../../shared/widgets/display/app_chip.dart';
import '../providers/thumbnail_provider.dart';

class ColorTab extends StatelessWidget {
  const ColorTab({
    super.key,
    required this.state,
    required this.notifier,
  });

  final ThumbnailState state;
  final ThumbnailNotifier notifier;

  @override
  Widget build(BuildContext context) {
    final canvas = notifier.selectedCanvas;

    return ListView(
      key: const Key('thumbnail-tab-color'),
      padding: const EdgeInsets.all(AppSpacing.lg),
      children: [
        Text('Background filter', style: AppTypography.labelLarge),
        const SizedBox(height: AppSpacing.sm),
        Wrap(
          spacing: AppSpacing.sm,
          runSpacing: AppSpacing.sm,
          children: [
            for (var index = 0; index < 3; index++)
              AppChip(
                label: 'Gradient ${index + 1}',
                variant: AppChipVariant.selectable,
                selected: canvas.gradientIndex.round() == index,
                onSelected: (_) => notifier.setGradient(index.toDouble()),
              ),
          ],
        ),
        const SizedBox(height: AppSpacing.lg),
        ListTile(
          contentPadding: EdgeInsets.zero,
          title: Text('Color overlay', style: AppTypography.labelLarge),
          subtitle: Text(
            'Opacity ${(canvas.overlayOpacity * 100).round()}%',
            style: AppTypography.bodySmall,
          ),
          trailing: CircleAvatar(backgroundColor: canvas.colorOverlay),
          onTap: () => _pickOverlayColor(context, canvas),
        ),
        Slider(
          min: 0,
          max: 0.75,
          value: canvas.overlayOpacity,
          onChanged: (value) => notifier.setColorOverlay(
            canvas.colorOverlay == Colors.transparent
                ? AppColors.gold
                : canvas.colorOverlay,
            value,
          ),
        ),
      ],
    );
  }

  Future<void> _pickOverlayColor(
    BuildContext context,
    ThumbnailCanvasData canvas,
  ) {
    var draft = canvas.colorOverlay == Colors.transparent
        ? AppColors.gold
        : canvas.colorOverlay;
    return showModalBottomSheet<void>(
      context: context,
      backgroundColor: AppColors.surface2,
      builder: (context) => Padding(
        padding: const EdgeInsets.all(AppSpacing.lg),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            BlockPicker(
              pickerColor: draft,
              onColorChanged: (color) => draft = color,
            ),
            TextButton(
              onPressed: () {
                notifier.setColorOverlay(draft, canvas.overlayOpacity);
                Navigator.of(context).pop();
              },
              child: const Text('Apply'),
            ),
          ],
        ),
      ),
    );
  }
}
