import 'package:flutter/material.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_radius.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/theme/app_typography.dart';

enum AppBadgeVariant { notification, count, tier }

class AppBadge extends StatelessWidget {
  const AppBadge({
    super.key,
    this.label,
    this.count,
    this.variant = AppBadgeVariant.count,
    this.color = AppColors.gold,
  });

  final String? label;
  final int? count;
  final AppBadgeVariant variant;
  final Color color;

  @override
  Widget build(BuildContext context) {
    if (variant == AppBadgeVariant.notification) {
      return DecoratedBox(
        decoration: BoxDecoration(color: color, shape: BoxShape.circle),
        child: const SizedBox.square(dimension: 10),
      );
    }

    final text = label ??
        (count == null
            ? ''
            : count! > 99
                ? '99+'
                : '$count');
    return DecoratedBox(
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(AppRadius.pill),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.sm,
          vertical: AppSpacing.xs,
        ),
        child: Text(
          text,
          style:
              AppTypography.labelSmall.copyWith(color: AppColors.textInverse),
        ),
      ),
    );
  }
}
