import 'package:flutter/material.dart';
import 'package:screenshot/screenshot.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_radius.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/theme/app_typography.dart';
import '../providers/thumbnail_provider.dart';
import 'canvas_widget.dart';

class AbComparisonView extends StatelessWidget {
  const AbComparisonView({
    super.key,
    required this.state,
  });

  final ThumbnailState state;

  static Future<void> show(BuildContext context, ThumbnailState state) {
    return showDialog<void>(
      context: context,
      builder: (context) => Dialog.fullscreen(
        backgroundColor: AppColors.obsidian,
        child: AbComparisonView(state: state),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final aScore = _score(state.ctrPredictionA);
    final bScore = _score(state.ctrPredictionB);
    final bCanvas =
        state.variantB == null ? state.variantACanvas : state.variantBCanvas;

    return Scaffold(
      backgroundColor: AppColors.obsidian,
      appBar: AppBar(
        backgroundColor: AppColors.obsidian,
        title: const Text('A/B Comparison'),
        leading: IconButton(
          onPressed: () => Navigator.of(context).pop(),
          icon: const Icon(Icons.close_rounded),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(AppSpacing.lg),
        child: Row(
          children: [
            Expanded(
              child: _PreviewPane(
                label: 'Variant A',
                score: aScore,
                winner: aScore >= bScore,
                canvas: state.variantACanvas,
              ),
            ),
            const SizedBox(width: AppSpacing.md),
            Expanded(
              child: _PreviewPane(
                label: 'Variant B',
                score: bScore,
                winner: bScore > aScore,
                canvas: bCanvas,
              ),
            ),
          ],
        ),
      ),
    );
  }

  double _score(double? value) => value ?? 0;
}

class _PreviewPane extends StatelessWidget {
  const _PreviewPane({
    required this.label,
    required this.score,
    required this.winner,
    required this.canvas,
  });

  final String label;
  final double score;
  final bool winner;
  final ThumbnailCanvasData canvas;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: AppColors.surface1,
        borderRadius: BorderRadius.circular(AppRadius.lg),
        border: Border.all(color: winner ? AppColors.gold : AppColors.surface3),
      ),
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.md),
        child: Column(
          children: [
            Text(label, style: AppTypography.labelLarge),
            const SizedBox(height: AppSpacing.xs),
            Text(
              '${(score * 100).round()}% CTR',
              style: AppTypography.headlineSmall.copyWith(
                color: winner ? AppColors.gold : AppColors.textSecondary,
              ),
            ),
            const SizedBox(height: AppSpacing.md),
            Expanded(
              child: ThumbnailCanvasWidget(
                canvas: canvas,
                screenshotController: ScreenshotController(),
                onLayerChanged: (_) {},
                onTextEditRequested: (_) {},
              ),
            ),
          ],
        ),
      ),
    );
  }
}
