import 'package:flutter/material.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_radius.dart';
import '../../../core/theme/app_shadows.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/theme/app_typography.dart';

enum AppButtonVariant { primary, secondary, ghost, danger }

enum AppButtonSize { sm, md, lg }

class AppButton extends StatefulWidget {
  const AppButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.variant = AppButtonVariant.primary,
    this.size = AppButtonSize.md,
    this.icon,
    this.isLoading = false,
    this.fullWidth = false,
  });

  final String label;
  final VoidCallback? onPressed;
  final AppButtonVariant variant;
  final AppButtonSize size;
  final Widget? icon;
  final bool isLoading;
  final bool fullWidth;

  @override
  State<AppButton> createState() => _AppButtonState();
}

class _AppButtonState extends State<AppButton> {
  bool _pressed = false;

  bool get _interactable => widget.onPressed != null && !widget.isLoading;
  bool get _visuallyEnabled => widget.onPressed != null || widget.isLoading;

  @override
  Widget build(BuildContext context) {
    final metrics = _ButtonMetrics.fromSize(widget.size);
    final colors = _ButtonColors.fromVariant(widget.variant, _visuallyEnabled);

    Widget child = AnimatedContainer(
      duration: const Duration(milliseconds: 120),
      curve: Curves.easeOutCubic,
      width: widget.fullWidth ? double.infinity : null,
      padding: metrics.padding,
      decoration: BoxDecoration(
        color: colors.background,
        borderRadius: BorderRadius.circular(AppRadius.md),
        border: colors.border,
        boxShadow: _pressed && widget.variant == AppButtonVariant.primary
            ? AppShadows.shadowGoldGlow
            : null,
      ),
      child: AnimatedOpacity(
        duration: const Duration(milliseconds: 120),
        opacity: _visuallyEnabled ? 1 : 0.55,
        child: Row(
          mainAxisSize: widget.fullWidth ? MainAxisSize.max : MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (widget.isLoading)
              SizedBox.square(
                dimension: metrics.loaderSize,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  valueColor: AlwaysStoppedAnimation<Color>(colors.foreground),
                ),
              )
            else if (widget.icon != null)
              IconTheme(
                data: IconThemeData(
                  color: colors.foreground,
                  size: metrics.iconSize,
                ),
                child: widget.icon!,
              ),
            if (widget.isLoading || widget.icon != null)
              const SizedBox(width: AppSpacing.sm),
            Flexible(
              child: Text(
                widget.label,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.center,
                style: metrics.textStyle.copyWith(color: colors.foreground),
              ),
            ),
          ],
        ),
      ),
    );

    child = MouseRegion(
      cursor:
          _interactable ? SystemMouseCursors.click : SystemMouseCursors.basic,
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: _interactable ? widget.onPressed : null,
        onTapDown:
            _interactable ? (_) => setState(() => _pressed = true) : null,
        onTapUp: _interactable ? (_) => setState(() => _pressed = false) : null,
        onTapCancel:
            _interactable ? () => setState(() => _pressed = false) : null,
        child: child,
      ),
    );

    return Semantics(
      button: true,
      enabled: _interactable,
      label: widget.label,
      child: child,
    );
  }
}

class _ButtonMetrics {
  const _ButtonMetrics({
    required this.padding,
    required this.textStyle,
    required this.iconSize,
    required this.loaderSize,
  });

  final EdgeInsetsGeometry padding;
  final TextStyle textStyle;
  final double iconSize;
  final double loaderSize;

  static _ButtonMetrics fromSize(AppButtonSize size) {
    return switch (size) {
      AppButtonSize.sm => _ButtonMetrics(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 9),
          textStyle: AppTypography.labelMedium,
          iconSize: 16,
          loaderSize: 14,
        ),
      AppButtonSize.md => _ButtonMetrics(
          padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 13),
          textStyle: AppTypography.labelLarge,
          iconSize: 18,
          loaderSize: 16,
        ),
      AppButtonSize.lg => _ButtonMetrics(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          textStyle: AppTypography.labelLarge,
          iconSize: 20,
          loaderSize: 18,
        ),
    };
  }
}

class _ButtonColors {
  const _ButtonColors({
    required this.background,
    required this.foreground,
    required this.border,
  });

  final Color background;
  final Color foreground;
  final Border? border;

  static _ButtonColors fromVariant(AppButtonVariant variant, bool enabled) {
    if (!enabled) {
      return const _ButtonColors(
        background: AppColors.surface3,
        foreground: AppColors.textTertiary,
        border: null,
      );
    }

    return switch (variant) {
      AppButtonVariant.primary => const _ButtonColors(
          background: AppColors.gold,
          foreground: AppColors.textInverse,
          border: null,
        ),
      AppButtonVariant.secondary => _ButtonColors(
          background: Colors.transparent,
          foreground: AppColors.gold,
          border: Border.all(color: AppColors.gold),
        ),
      AppButtonVariant.ghost => const _ButtonColors(
          background: Colors.transparent,
          foreground: AppColors.gold,
          border: null,
        ),
      AppButtonVariant.danger => const _ButtonColors(
          background: AppColors.error,
          foreground: AppColors.textPrimary,
          border: null,
        ),
    };
  }
}
