import 'package:flutter/material.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_radius.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/theme/app_typography.dart';

enum AppChipVariant { filter, tag, selectable }

class AppChip extends StatelessWidget {
  const AppChip({
    super.key,
    required this.label,
    this.variant = AppChipVariant.tag,
    this.selected = false,
    this.onSelected,
  });

  final String label;
  final AppChipVariant variant;
  final bool selected;
  final ValueChanged<bool>? onSelected;

  @override
  Widget build(BuildContext context) {
    final active = selected || variant == AppChipVariant.tag;
    final background = active ? AppColors.goldGlow : AppColors.surface2;
    final borderColor = active ? AppColors.gold : AppColors.surface3;

    return FilterChip(
      label: Text(label),
      selected: selected,
      onSelected: variant == AppChipVariant.tag ? null : onSelected,
      showCheckmark: variant == AppChipVariant.selectable,
      labelStyle: AppTypography.labelMedium.copyWith(
        color: active ? AppColors.goldLight : AppColors.textSecondary,
      ),
      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.sm),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppRadius.pill),
        side: BorderSide(color: borderColor),
      ),
      backgroundColor: background,
      selectedColor: AppColors.goldGlow,
      disabledColor: background,
    );
  }
}
