import 'package:flutter/material.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/theme/app_typography.dart';

class ProfileMenuItem extends StatelessWidget {
  const ProfileMenuItem({
    super.key,
    required this.icon,
    required this.label,
    required this.onTap,
    this.trailingBadge,
    this.isDanger = false,
  });

  final IconData icon;
  final String label;
  final VoidCallback onTap;
  final String? trailingBadge;
  final bool isDanger;

  @override
  Widget build(BuildContext context) {
    final color = isDanger ? AppColors.error : AppColors.textPrimary;

    return ListTile(
      key: Key('profile-menu-${label.toLowerCase().replaceAll(' ', '-')}'),
      onTap: onTap,
      contentPadding: EdgeInsets.zero,
      leading: Icon(icon, color: isDanger ? color : AppColors.gold),
      title: Text(
        label,
        style: AppTypography.labelLarge.copyWith(color: color),
      ),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (trailingBadge != null) ...[
            DecoratedBox(
              decoration: BoxDecoration(
                color: AppColors.goldGlow,
                borderRadius: BorderRadius.circular(999),
                border: Border.all(color: AppColors.gold),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppSpacing.sm,
                  vertical: AppSpacing.xs,
                ),
                child: Text(
                  trailingBadge!,
                  style: AppTypography.labelSmall.copyWith(
                    color: AppColors.goldLight,
                  ),
                ),
              ),
            ),
            const SizedBox(width: AppSpacing.sm),
          ],
          Icon(
            Icons.chevron_right_rounded,
            color: isDanger ? AppColors.error : AppColors.textTertiary,
          ),
        ],
      ),
    );
  }
}
