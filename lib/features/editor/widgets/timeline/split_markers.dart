import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';

class SplitMarkers extends StatelessWidget {
  const SplitMarkers({
    super.key,
    required this.splits,
    required this.durationMs,
  });

  final List<int> splits;
  final int durationMs;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Stack(
          children: [
            for (final split in splits)
              Positioned(
                left: (split / durationMs).clamp(0, 1) * constraints.maxWidth,
                top: 0,
                bottom: 0,
                child: Container(
                  width: 2,
                  color: AppColors.info,
                ),
              ),
          ],
        );
      },
    );
  }
}
