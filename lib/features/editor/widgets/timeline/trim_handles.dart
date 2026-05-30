import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_radius.dart';
import '../../../../core/theme/app_spacing.dart';

class TrimHandles extends StatelessWidget {
  const TrimHandles({
    super.key,
    required this.durationMs,
    required this.startMs,
    required this.endMs,
    required this.onChanged,
  });

  final int durationMs;
  final int startMs;
  final int endMs;
  final void Function(int startMs, int endMs) onChanged;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final startX =
            (startMs / durationMs).clamp(0, 1) * constraints.maxWidth;
        final endX = (endMs / durationMs).clamp(0, 1) * constraints.maxWidth;

        return Stack(
          children: [
            Positioned(
              left: startX,
              right: constraints.maxWidth - endX,
              top: 0,
              bottom: 0,
              child: DecoratedBox(
                decoration: BoxDecoration(
                  border: Border.all(color: AppColors.gold, width: 2),
                  borderRadius: BorderRadius.circular(AppRadius.sm),
                ),
              ),
            ),
            _Handle(
              key: const Key('trim-start-handle'),
              left: startX - 9,
              onDrag: (delta) {
                HapticFeedback.selectionClick();
                final next = _msFromDelta(constraints.maxWidth, startX + delta);
                onChanged(next.clamp(0, endMs - 1000), endMs);
              },
            ),
            _Handle(
              key: const Key('trim-end-handle'),
              left: endX - 9,
              onDrag: (delta) {
                HapticFeedback.selectionClick();
                final next = _msFromDelta(constraints.maxWidth, endX + delta);
                onChanged(startMs, next.clamp(startMs + 1000, durationMs));
              },
            ),
          ],
        );
      },
    );
  }

  int _msFromDelta(double width, double value) {
    return ((value / width).clamp(0, 1) * durationMs).round();
  }
}

class _Handle extends StatelessWidget {
  const _Handle({
    super.key,
    required this.left,
    required this.onDrag,
  });

  final double left;
  final ValueChanged<double> onDrag;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: left,
      top: AppSpacing.sm,
      bottom: AppSpacing.sm,
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onHorizontalDragUpdate: (details) => onDrag(details.localPosition.dx),
        child: Container(
          width: 18,
          decoration: BoxDecoration(
            color: AppColors.gold,
            borderRadius: BorderRadius.circular(AppRadius.pill),
          ),
        ),
      ),
    );
  }
}
