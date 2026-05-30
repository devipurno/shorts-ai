import 'package:flutter/material.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_shadows.dart';

class AppFab extends StatelessWidget {
  const AppFab({
    super.key,
    required this.icon,
    required this.onPressed,
    this.label,
  });

  final Widget icon;
  final VoidCallback? onPressed;
  final String? label;

  @override
  Widget build(BuildContext context) {
    final fab = DecoratedBox(
      decoration: const BoxDecoration(boxShadow: AppShadows.shadowGoldGlow),
      child: label == null
          ? FloatingActionButton(
              onPressed: onPressed,
              backgroundColor: AppColors.gold,
              foregroundColor: AppColors.textInverse,
              child: icon,
            )
          : FloatingActionButton.extended(
              onPressed: onPressed,
              backgroundColor: AppColors.gold,
              foregroundColor: AppColors.textInverse,
              icon: icon,
              label: Text(label!),
            ),
    );

    return Semantics(button: true, child: fab);
  }
}
