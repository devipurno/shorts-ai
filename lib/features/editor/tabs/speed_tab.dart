import 'package:flutter/material.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/theme/app_typography.dart';
import '../../../shared/widgets/display/app_chip.dart';
import '../providers/editor_provider.dart';

class SpeedTab extends StatelessWidget {
  const SpeedTab({
    super.key,
    required this.state,
    required this.notifier,
  });

  final EditorState state;
  final EditorNotifier notifier;

  @override
  Widget build(BuildContext context) {
    const presets = [0.5, 1.0, 1.5, 2.0];

    return ListView(
      key: const Key('editor-tab-speed'),
      padding: const EdgeInsets.all(AppSpacing.lg),
      children: [
        Text('Playback speed', style: AppTypography.headlineSmall),
        const SizedBox(height: AppSpacing.md),
        Text(
          '${state.speed.toStringAsFixed(2)}x',
          style: AppTypography.displaySmall.copyWith(color: AppColors.gold),
        ),
        Slider(
          min: 0.25,
          max: 4,
          divisions: 15,
          value: state.speed,
          onChanged: notifier.setSpeed,
        ),
        const SizedBox(height: AppSpacing.md),
        Wrap(
          spacing: AppSpacing.sm,
          runSpacing: AppSpacing.sm,
          children: [
            for (final preset in presets)
              AppChip(
                key: Key('speed-preset-$preset'),
                label: '${preset}x',
                variant: AppChipVariant.selectable,
                selected: state.speed == preset,
                onSelected: (_) => notifier.setSpeed(preset),
              ),
          ],
        ),
      ],
    );
  }
}
