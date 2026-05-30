import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart'
    hide colorFromHex, colorToHex;

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_radius.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/theme/app_typography.dart';
import '../../../shared/widgets/display/app_chip.dart';
import '../providers/subtitle_provider.dart';
import '../widgets/style_preview.dart';

class StyleTab extends StatelessWidget {
  const StyleTab({
    super.key,
    required this.state,
    required this.notifier,
  });

  final SubtitleState state;
  final SubtitleNotifier notifier;

  @override
  Widget build(BuildContext context) {
    final segment = state.segments.isEmpty
        ? null
        : state.segments[state.selectedSegmentIndex];

    return ListView(
      key: const Key('subtitle-tab-style'),
      padding: const EdgeInsets.all(AppSpacing.lg),
      children: [
        StylePreview(
          segment: segment,
          style: state.style,
          animation: state.animation,
          backgroundStyle: state.backgroundStyle,
          strokeWidth: state.strokeWidth,
          karaokeColor: state.karaokeColor,
          currentPositionMs: state.currentPositionMs,
        ),
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
                selected: state.style.fontFamily == font,
                onSelected: (_) {
                  notifier.setStyle(state.style.copyWith(fontFamily: font));
                },
              ),
          ],
        ),
        const SizedBox(height: AppSpacing.lg),
        Text(
          'Font size: ${state.style.fontSize.round()}',
          style: AppTypography.labelLarge,
        ),
        Slider(
          min: 12,
          max: 72,
          value: state.style.fontSize,
          onChanged: (value) {
            notifier.setStyle(state.style.copyWith(fontSize: value));
          },
        ),
        const SizedBox(height: AppSpacing.lg),
        _ColorRow(
          label: 'Font color',
          color: colorFromHex(state.style.fontColor),
          onTap: () => _pickColor(
            context,
            initial: colorFromHex(state.style.fontColor),
            onChanged: (color) {
              notifier.setStyle(
                state.style.copyWith(fontColor: colorToHex(color)),
              );
            },
          ),
        ),
        _ColorRow(
          label: 'Stroke color',
          color: colorFromHex(state.style.strokeColor),
          onTap: () => _pickColor(
            context,
            initial: colorFromHex(state.style.strokeColor),
            onChanged: (color) {
              notifier.setStyle(
                state.style.copyWith(strokeColor: colorToHex(color)),
              );
            },
          ),
        ),
        const SizedBox(height: AppSpacing.md),
        Text(
          'Stroke width: ${state.strokeWidth.toStringAsFixed(1)}',
          style: AppTypography.labelLarge,
        ),
        Slider(
          min: 0,
          max: 10,
          value: state.strokeWidth,
          onChanged: notifier.setStrokeWidth,
        ),
        const SizedBox(height: AppSpacing.lg),
        Text('Position', style: AppTypography.labelLarge),
        const SizedBox(height: AppSpacing.sm),
        _PositionGrid(
          selected: state.style.position,
          onSelected: (position) {
            notifier.setStyle(state.style.copyWith(position: position));
          },
        ),
        const SizedBox(height: AppSpacing.lg),
        Text('Background style', style: AppTypography.labelLarge),
        const SizedBox(height: AppSpacing.sm),
        Wrap(
          spacing: AppSpacing.sm,
          runSpacing: AppSpacing.sm,
          children: [
            for (final background in SubtitleBackgroundStyle.values)
              AppChip(
                label: background.label,
                variant: AppChipVariant.selectable,
                selected: state.backgroundStyle == background,
                onSelected: (_) => notifier.setBackgroundStyle(background),
              ),
          ],
        ),
        const SizedBox(height: AppSpacing.lg),
        _ColorRow(
          label: 'Karaoke color',
          color: colorFromHex(state.karaokeColor),
          onTap: () => _pickColor(
            context,
            initial: colorFromHex(state.karaokeColor),
            onChanged: (color) => notifier.setKaraokeColor(colorToHex(color)),
          ),
        ),
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
              availableColors: const [
                AppColors.gold,
                AppColors.textPrimary,
                AppColors.error,
                AppColors.info,
                AppColors.success,
                Color(0xFFFF7A59),
                Color(0xFFB794F4),
                Color(0xFF111827),
              ],
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

class _ColorRow extends StatelessWidget {
  const _ColorRow({
    required this.label,
    required this.color,
    required this.onTap,
  });

  final String label;
  final Color color;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      title: Text(label, style: AppTypography.labelLarge),
      trailing: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(AppRadius.pill),
        child: CircleAvatar(backgroundColor: color),
      ),
    );
  }
}

class _PositionGrid extends StatelessWidget {
  const _PositionGrid({
    required this.selected,
    required this.onSelected,
  });

  final String selected;
  final ValueChanged<String> onSelected;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 144,
      child: GridView.count(
        physics: const NeverScrollableScrollPhysics(),
        crossAxisCount: 3,
        childAspectRatio: 2.7,
        crossAxisSpacing: AppSpacing.sm,
        mainAxisSpacing: AppSpacing.sm,
        children: [
          for (final position in _positions)
            InkWell(
              onTap: () => onSelected(position),
              borderRadius: BorderRadius.circular(AppRadius.md),
              child: DecoratedBox(
                decoration: BoxDecoration(
                  color: selected == position
                      ? AppColors.goldGlow
                      : AppColors.surface1,
                  borderRadius: BorderRadius.circular(AppRadius.md),
                  border: Border.all(
                    color: selected == position
                        ? AppColors.gold
                        : AppColors.surface3,
                  ),
                ),
                child: Center(
                  child: Icon(
                    Icons.subtitles_rounded,
                    color: selected == position
                        ? AppColors.gold
                        : AppColors.textTertiary,
                    size: 18,
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}

const _fonts = [
  'Inter',
  'Roboto Black',
  'Bebas Neue',
  'Anton',
  'Montserrat Bold',
  'Impact',
  'Poppins',
  'Oswald',
];

const _positions = [
  'top_left',
  'top_center',
  'top_right',
  'center_left',
  'center',
  'center_right',
  'bottom_left',
  'bottom_center',
  'bottom_right',
];
