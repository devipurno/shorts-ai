import 'package:flutter/material.dart';

import '../../../core/theme/app_radius.dart';
import '../../../core/theme/app_spacing.dart';
import '../providers/calendar_provider.dart';

class CalendarEventDot extends StatelessWidget {
  const CalendarEventDot({
    super.key,
    required this.platforms,
    this.compact = false,
  });

  final Iterable<CalendarPlatform> platforms;
  final bool compact;

  @override
  Widget build(BuildContext context) {
    final unique = platforms.toSet().take(3).toList(growable: false);
    if (unique.isEmpty) {
      return const SizedBox.shrink();
    }

    return Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        for (final platform in unique) ...[
          DecoratedBox(
            decoration: BoxDecoration(
              color: platform.color,
              borderRadius: BorderRadius.circular(AppRadius.pill),
            ),
            child: SizedBox.square(dimension: compact ? 6 : 8),
          ),
          if (platform != unique.last)
            SizedBox(width: compact ? 2 : AppSpacing.xs),
        ],
      ],
    );
  }
}
