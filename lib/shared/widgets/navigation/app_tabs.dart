import 'package:flutter/material.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_radius.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/theme/app_typography.dart';

enum AppTabsVariant { standard, pill, segmented }

class AppTabs extends StatelessWidget {
  const AppTabs({
    super.key,
    required this.tabs,
    this.controller,
    this.onTap,
    this.variant = AppTabsVariant.standard,
  });

  final List<String> tabs;
  final TabController? controller;
  final ValueChanged<int>? onTap;
  final AppTabsVariant variant;

  @override
  Widget build(BuildContext context) {
    final radius =
        variant == AppTabsVariant.standard ? AppRadius.sm : AppRadius.pill;
    return DecoratedBox(
      decoration: BoxDecoration(
        color: variant == AppTabsVariant.standard
            ? Colors.transparent
            : AppColors.surface1,
        borderRadius: BorderRadius.circular(radius),
        border: variant == AppTabsVariant.segmented
            ? Border.all(color: AppColors.surface3)
            : null,
      ),
      child: TabBar(
        controller: controller,
        onTap: onTap,
        dividerColor: Colors.transparent,
        indicatorSize: TabBarIndicatorSize.tab,
        labelStyle: AppTypography.labelMedium,
        unselectedLabelStyle: AppTypography.labelMedium,
        labelColor: AppColors.textInverse,
        unselectedLabelColor: AppColors.textSecondary,
        padding: variant == AppTabsVariant.standard
            ? EdgeInsets.zero
            : const EdgeInsets.all(AppSpacing.xs),
        indicator: BoxDecoration(
          color: AppColors.gold,
          borderRadius: BorderRadius.circular(radius),
        ),
        tabs: [for (final tab in tabs) Tab(text: tab)],
      ),
    );
  }
}
