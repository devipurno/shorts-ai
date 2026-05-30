import 'package:flutter/material.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_radius.dart';

enum AppIconButtonVariant { filled, outlined, ghost }

class AppIconButton extends StatelessWidget {
  const AppIconButton({
    super.key,
    required this.icon,
    required this.onPressed,
    this.tooltip,
    this.variant = AppIconButtonVariant.ghost,
    this.size = 44,
  });

  final Widget icon;
  final VoidCallback? onPressed;
  final String? tooltip;
  final AppIconButtonVariant variant;
  final double size;

  @override
  Widget build(BuildContext context) {
    final enabled = onPressed != null;
    final decoration = _decoration(enabled);

    final button = SizedBox.square(
      dimension: size,
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onPressed,
          customBorder: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppRadius.md),
          ),
          child: Ink(
            decoration: decoration,
            child: IconTheme(
              data: IconThemeData(
                color: enabled ? _foregroundColor : AppColors.textTertiary,
                size: size * 0.48,
              ),
              child: Center(child: icon),
            ),
          ),
        ),
      ),
    );

    return Semantics(
      button: true,
      enabled: enabled,
      label: tooltip,
      child:
          tooltip == null ? button : Tooltip(message: tooltip!, child: button),
    );
  }

  BoxDecoration _decoration(bool enabled) {
    final borderRadius = BorderRadius.circular(AppRadius.md);
    final color = enabled ? null : AppColors.surface2;

    return switch (variant) {
      AppIconButtonVariant.filled => BoxDecoration(
          color: color ?? AppColors.gold,
          borderRadius: borderRadius,
        ),
      AppIconButtonVariant.outlined => BoxDecoration(
          color: color ?? Colors.transparent,
          borderRadius: borderRadius,
          border:
              Border.all(color: enabled ? AppColors.gold : AppColors.surface3),
        ),
      AppIconButtonVariant.ghost => BoxDecoration(
          color: color ?? Colors.transparent,
          borderRadius: borderRadius,
        ),
    };
  }

  Color get _foregroundColor {
    return variant == AppIconButtonVariant.filled
        ? AppColors.textInverse
        : AppColors.gold;
  }
}
