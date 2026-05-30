import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart'
    hide colorFromHex, colorToHex;

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/theme/app_typography.dart';
import '../../../shared/widgets/buttons/app_button.dart';
import '../../../shared/widgets/display/app_chip.dart';
import '../providers/thumbnail_provider.dart';

class TextTab extends StatelessWidget {
  const TextTab({
    super.key,
    required this.state,
    required this.notifier,
  });

  final ThumbnailState state;
  final ThumbnailNotifier notifier;

  @override
  Widget build(BuildContext context) {
    final textLayers = notifier.selectedCanvas.layers
        .where((layer) => layer.type == ThumbnailLayerType.text)
        .toList();
    final active = textLayers.isEmpty ? null : textLayers.last;

    return ListView(
      key: const Key('thumbnail-tab-text'),
      padding: const EdgeInsets.all(AppSpacing.lg),
      children: [
        AppButton(
          key: const Key('thumbnail-add-text'),
          label: 'Add Text Layer',
          icon: const Icon(Icons.title_rounded),
          onPressed: () => notifier.addTextLayer(),
        ),
        if (active != null) ...[
          const SizedBox(height: AppSpacing.lg),
          Text('Font', style: AppTypography.labelLarge),
          const SizedBox(height: AppSpacing.sm),
          Wrap(
            spacing: AppSpacing.sm,
            runSpacing: AppSpacing.sm,
            children: [
              for (final font in _fonts)
                AppChip(
                  label: font,
                  variant: AppChipVariant.selectable,
                  selected: active.fontFamily == font,
                  onSelected: (_) => notifier.updateLayer(
                    active.copyWith(fontFamily: font),
                  ),
                ),
            ],
          ),
          const SizedBox(height: AppSpacing.lg),
          Text('Size: ${active.fontSize.round()}',
              style: AppTypography.labelLarge),
          Slider(
            min: 24,
            max: 96,
            value: active.fontSize,
            onChanged: (value) =>
                notifier.updateLayer(active.copyWith(fontSize: value)),
          ),
          const SizedBox(height: AppSpacing.md),
          ListTile(
            contentPadding: EdgeInsets.zero,
            title: Text('Color', style: AppTypography.labelLarge),
            trailing: CircleAvatar(backgroundColor: active.color),
            onTap: () => _pickColor(
              context,
              initial: active.color,
              onChanged: (color) {
                notifier.updateLayer(active.copyWith(color: color));
              },
            ),
          ),
          SwitchListTile(
            contentPadding: EdgeInsets.zero,
            title: const Text('Shadow'),
            value: active.shadow,
            onChanged: (value) {
              notifier.updateLayer(active.copyWith(shadow: value));
            },
          ),
        ],
      ],
    );
  }

  Future<void> _pickColor(
    BuildContext context, {
    required Color initial,
    required ValueChanged<Color> onChanged,
  }) {
    var draft = initial;
    return showModalBottomSheet<void>(
      context: context,
      backgroundColor: AppColors.surface2,
      builder: (context) => Padding(
        padding: const EdgeInsets.all(AppSpacing.lg),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            BlockPicker(
              pickerColor: initial,
              onColorChanged: (color) => draft = color,
            ),
            TextButton(
              onPressed: () {
                onChanged(draft);
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

const _fonts = ['Impact', 'Anton', 'Bebas Neue'];
