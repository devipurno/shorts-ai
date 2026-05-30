import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/theme/app_typography.dart';
import '../../../shared/widgets/display/app_chip.dart';
import '../../../shared/widgets/inputs/text_input.dart';
import '../providers/editor_provider.dart';

class WatermarkTab extends StatelessWidget {
  const WatermarkTab({
    super.key,
    required this.state,
    required this.notifier,
  });

  final EditorState state;
  final EditorNotifier notifier;

  @override
  Widget build(BuildContext context) {
    final watermark = state.watermark;

    return ListView(
      key: const Key('editor-tab-watermark'),
      padding: const EdgeInsets.all(AppSpacing.lg),
      children: [
        Text('Watermark', style: AppTypography.headlineSmall),
        const SizedBox(height: AppSpacing.md),
        Wrap(
          spacing: AppSpacing.sm,
          children: [
            AppChip(
              label: 'Text',
              variant: AppChipVariant.selectable,
              selected: watermark.type == WatermarkType.text,
              onSelected: (_) => notifier.setWatermark(
                watermark.copyWith(type: WatermarkType.text),
              ),
            ),
            AppChip(
              label: 'Logo',
              variant: AppChipVariant.selectable,
              selected: watermark.type == WatermarkType.logo,
              onSelected: (_) => notifier.setWatermark(
                watermark.copyWith(type: WatermarkType.logo),
              ),
            ),
          ],
        ),
        const SizedBox(height: AppSpacing.md),
        AppTextInput(
          key: const Key('watermark-text-input'),
          label: 'Watermark text',
          hint: 'AutoShort',
          onChanged: (value) => notifier.setWatermark(
            watermark.copyWith(text: value),
          ),
        ),
        const SizedBox(height: AppSpacing.lg),
        Text('Position', style: AppTypography.labelLarge),
        const SizedBox(height: AppSpacing.sm),
        _PositionGrid(
          selected: watermark.position,
          onSelected: (position) => notifier.setWatermark(
            watermark.copyWith(position: position),
          ),
        ),
        const SizedBox(height: AppSpacing.lg),
        Text('Opacity', style: AppTypography.labelLarge),
        Slider(
          min: 0,
          max: 1,
          value: watermark.opacity,
          onChanged: (value) => notifier.setWatermark(
            watermark.copyWith(opacity: value),
          ),
        ),
        Text('Size', style: AppTypography.labelLarge),
        Slider(
          min: 0.08,
          max: 0.36,
          value: watermark.size,
          onChanged: (value) => notifier.setWatermark(
            watermark.copyWith(size: value),
          ),
        ),
        const SizedBox(height: AppSpacing.md),
        OutlinedButton.icon(
          icon: const Icon(Icons.color_lens_outlined),
          label: const Text('Pick watermark color'),
          onPressed: () => _showColorPicker(context, watermark),
        ),
      ],
    );
  }

  void _showColorPicker(BuildContext context, WatermarkConfig watermark) {
    var color = watermark.color;
    showDialog<void>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Pick watermark color'),
        content: BlockPicker(
          pickerColor: color,
          availableColors: const [
            Colors.white,
            AppColors.gold,
            AppColors.info,
            AppColors.success,
            AppColors.error,
          ],
          onColorChanged: (value) => color = value,
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              notifier.setWatermark(watermark.copyWith(color: color));
              Navigator.of(context).pop();
            },
            child: const Text('Select'),
          ),
        ],
      ),
    );
  }
}

class _PositionGrid extends StatelessWidget {
  const _PositionGrid({
    required this.selected,
    required this.onSelected,
  });

  final WatermarkPosition selected;
  final ValueChanged<WatermarkPosition> onSelected;

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      crossAxisCount: 3,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      mainAxisSpacing: AppSpacing.sm,
      crossAxisSpacing: AppSpacing.sm,
      children: [
        for (final position in WatermarkPosition.values)
          InkWell(
            onTap: () => onSelected(position),
            child: DecoratedBox(
              decoration: BoxDecoration(
                color: selected == position
                    ? AppColors.goldGlow
                    : AppColors.surface2,
                border: Border.all(
                  color: selected == position
                      ? AppColors.gold
                      : AppColors.surface3,
                ),
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Center(
                child: Icon(Icons.control_point_rounded, size: 18),
              ),
            ),
          ),
      ],
    );
  }
}
