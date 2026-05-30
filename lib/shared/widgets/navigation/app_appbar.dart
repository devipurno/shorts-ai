import 'package:flutter/material.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_typography.dart';
import '../buttons/icon_button.dart';

class AppAppBar extends StatelessWidget implements PreferredSizeWidget {
  const AppAppBar({
    super.key,
    required this.title,
    this.actions = const [],
    this.showBackButton = false,
    this.onBack,
  });

  final String title;
  final List<Widget> actions;
  final bool showBackButton;
  final VoidCallback? onBack;

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: showBackButton
          ? AppIconButton(
              tooltip: 'Back',
              icon: const Icon(Icons.arrow_back),
              onPressed: onBack ?? () => Navigator.maybePop(context),
            )
          : null,
      title: Text(title, style: AppTypography.headlineSmall),
      actions: actions,
      backgroundColor: AppColors.obsidian,
      surfaceTintColor: Colors.transparent,
    );
  }
}
