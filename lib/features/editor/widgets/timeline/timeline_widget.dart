import 'dart:math' as math;

import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_radius.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_typography.dart';
import '../../providers/editor_provider.dart';
import 'split_markers.dart';
import 'trim_handles.dart';

class TimelineWidget extends StatelessWidget {
  const TimelineWidget({
    super.key,
    required this.state,
    this.onTrimChanged,
    this.onTapPosition,
    this.showTrimHandles = true,
  });

  final EditorState state;
  final void Function(int startMs, int endMs)? onTrimChanged;
  final ValueChanged<int>? onTapPosition;
  final bool showTrimHandles;

  int get _durationMs => math.max(state.trimEndMs, 60000);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      key: const Key('editor-timeline'),
      height: 104,
      child: LayoutBuilder(
        builder: (context, constraints) {
          return GestureDetector(
            onTapDown: (details) {
              final position =
                  (details.localPosition.dx / constraints.maxWidth).clamp(0, 1);
              onTapPosition?.call((position * _durationMs).round());
            },
            child: Stack(
              children: [
                ListView.separated(
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) => _Thumb(index: index),
                  separatorBuilder: (context, index) =>
                      const SizedBox(width: AppSpacing.xs),
                  itemCount: 10,
                ),
                Positioned.fill(
                  top: 58,
                  child: CustomPaint(
                    painter: _WaveformPainter(),
                  ),
                ),
                Positioned.fill(
                  child: SplitMarkers(
                    splits: state.splits,
                    durationMs: _durationMs,
                  ),
                ),
                Positioned.fill(
                  child: Align(
                    alignment: Alignment.topCenter,
                    child: Container(
                      width: 2,
                      height: 104,
                      color: AppColors.gold,
                    ),
                  ),
                ),
                if (showTrimHandles && onTrimChanged != null)
                  Positioned.fill(
                    child: TrimHandles(
                      durationMs: _durationMs,
                      startMs: state.trimStartMs,
                      endMs: state.trimEndMs,
                      onChanged: onTrimChanged!,
                    ),
                  ),
              ],
            ),
          );
        },
      ),
    );
  }
}

class _Thumb extends StatelessWidget {
  const _Thumb({required this.index});

  final int index;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 72,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(AppRadius.sm),
        gradient: LinearGradient(
          colors: index.isEven
              ? const [AppColors.surface2, AppColors.goldDark]
              : const [AppColors.surface3, AppColors.obsidianLight],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Align(
        alignment: Alignment.topLeft,
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.xs),
          child: Text(
            '${index + 1}',
            style: AppTypography.labelSmall.copyWith(
              color: AppColors.textSecondary,
            ),
          ),
        ),
      ),
    );
  }
}

class _WaveformPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = AppColors.gold.withValues(alpha: 0.35)
      ..strokeWidth = 2
      ..strokeCap = StrokeCap.round;
    final step = size.width / 38;
    for (var i = 0; i < 38; i++) {
      final x = i * step;
      final height = 8 + (math.sin(i * 0.9).abs() * 22);
      final center = size.height / 2;
      canvas.drawLine(
        Offset(x, center - height / 2),
        Offset(x, center + height / 2),
        paint,
      );
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
