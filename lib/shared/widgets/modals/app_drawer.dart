import 'package:flutter/material.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/theme/app_typography.dart';

class AppDrawerItem {
  const AppDrawerItem({
    required this.label,
    required this.icon,
    required this.onTap,
  });

  final String label;
  final IconData icon;
  final VoidCallback onTap;
}

class AppDrawer extends StatelessWidget {
  const AppDrawer({
    super.key,
    required this.items,
  });

  final List<AppDrawerItem> items;

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: AppColors.obsidian,
      child: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(AppSpacing.lg),
          children: [
            Text('AutoShort', style: AppTypography.headlineMedium),
            const SizedBox(height: AppSpacing.lg),
            for (final item in items)
              ListTile(
                leading: Icon(item.icon, color: AppColors.gold),
                title: Text(item.label),
                onTap: item.onTap,
              ),
          ],
        ),
      ),
    );
  }
}
