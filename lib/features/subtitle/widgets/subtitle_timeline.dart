import 'package:flutter/material.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_radius.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/theme/app_typography.dart';
import '../../../shared/models/subtitle.dart';
import '../services/srt_exporter.dart';

class SubtitleTimeline extends StatelessWidget {
  const SubtitleTimeline({
    super.key,
    required this.segments,
    required this.currentIndex,
    required this.onSelect,
  });

  final List<SubtitleSegment> segments;
  final int currentIndex;
  final ValueChanged<int> onSelect;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      key: const Key('subtitle-timeline'),
      height: 112,
      child: ListView.separated(
        padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
        scrollDirection: Axis.horizontal,
        itemCount: segments.length,
        separatorBuilder: (_, __) => const SizedBox(width: AppSpacing.sm),
        itemBuilder: (context, index) {
          final segment = segments[index];
          final active = index == currentIndex;
          return SizedBox(
            width: 180,
            child: InkWell(
              borderRadius: BorderRadius.circular(AppRadius.md),
              onTap: () => onSelect(index),
              child: DecoratedBox(
                decoration: BoxDecoration(
                  color: active ? AppColors.goldGlow : AppColors.surface1,
                  borderRadius: BorderRadius.circular(AppRadius.md),
                  border: Border.all(
                    color: active ? AppColors.gold : AppColors.surface3,
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(AppSpacing.md),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '${_shortTime(segment.startMs)} - '
                        '${_shortTime(segment.endMs)}',
                        style: AppTypography.labelSmall.copyWith(
                          color:
                              active ? AppColors.gold : AppColors.textTertiary,
                        ),
                      ),
                      const SizedBox(height: AppSpacing.sm),
                      Text(
                        segment.text,
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                        style: AppTypography.bodySmall,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  String _shortTime(int ms) {
    final formatted = SrtExporter.formatTimestamp(ms);
    return formatted.substring(3, 8);
  }
}
