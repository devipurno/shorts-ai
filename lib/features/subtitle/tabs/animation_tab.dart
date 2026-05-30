import 'package:flutter/material.dart';

import '../../../core/theme/app_spacing.dart';
import '../../../core/theme/app_typography.dart';
import '../../../shared/widgets/cards/app_card.dart';
import '../../../shared/widgets/display/app_chip.dart';
import '../providers/subtitle_provider.dart';
import '../widgets/style_preview.dart';

class AnimationTab extends StatelessWidget {
  const AnimationTab({
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
      key: const Key('subtitle-tab-animation'),
      padding: const EdgeInsets.all(AppSpacing.lg),
      children: [
        Text('Animation preset', style: AppTypography.headlineSmall),
        const SizedBox(height: AppSpacing.md),
        AppCard(
          variant: AppCardVariant.glass,
          child: StylePreview(
            segment: segment,
            style: state.style,
            animation: state.animation,
            backgroundStyle: state.backgroundStyle,
            strokeWidth: state.strokeWidth,
            karaokeColor: state.karaokeColor,
            currentPositionMs: state.currentPositionMs,
          ),
        ),
        const SizedBox(height: AppSpacing.lg),
        Wrap(
          spacing: AppSpacing.sm,
          runSpacing: AppSpacing.sm,
          children: [
            for (final animation in SubtitleAnimationPreset.values)
              AppChip(
                label: animation.label,
                variant: AppChipVariant.selectable,
                selected: state.animation == animation,
                onSelected: (_) => notifier.setAnimation(animation),
              ),
          ],
        ),
      ],
    );
  }
}
