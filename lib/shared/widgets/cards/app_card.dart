import 'dart:ui';

import 'package:flutter/material.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_radius.dart';
import '../../../core/theme/app_shadows.dart';
import '../../../core/theme/app_spacing.dart';

enum AppCardVariant { flat, elevated, glass, premiumGold }

class AppCard extends StatelessWidget {
  const AppCard({
    super.key,
    required this.child,
    this.variant = AppCardVariant.flat,
    this.padding = const EdgeInsets.all(AppSpacing.lg),
    this.onTap,
  });

  final Widget child;
  final AppCardVariant variant;
  final EdgeInsetsGeometry padding;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final radius = BorderRadius.circular(AppRadius.md);
    final decoration = _decoration(radius);

    Widget card = ClipRRect(
      borderRadius: radius,
      child: DecoratedBox(
        decoration: decoration,
        child: Padding(padding: padding, child: child),
      ),
    );

    if (variant == AppCardVariant.glass) {
      card = ClipRRect(
        borderRadius: radius,
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 16, sigmaY: 16),
          child: card,
        ),
      );
    }

    if (onTap == null) {
      return card;
    }

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: radius,
        child: card,
      ),
    );
  }

  BoxDecoration _decoration(BorderRadius radius) {
    return switch (variant) {
      AppCardVariant.flat => BoxDecoration(
          color: AppColors.surface1,
          borderRadius: radius,
          border: Border.all(color: AppColors.surface3),
        ),
      AppCardVariant.elevated => BoxDecoration(
          color: AppColors.surface2,
          borderRadius: radius,
          boxShadow: AppShadows.shadowMd,
        ),
      AppCardVariant.glass => BoxDecoration(
          color: AppColors.glassWhite,
          borderRadius: radius,
          border: Border.all(color: AppColors.glassWhite),
        ),
      AppCardVariant.premiumGold => BoxDecoration(
          color: AppColors.surface1,
          borderRadius: radius,
          border: Border.all(color: AppColors.gold),
          boxShadow: AppShadows.shadowGoldGlow,
        ),
    };
  }
}
