import 'package:flutter/material.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_radius.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/theme/app_typography.dart';
import '../../../shared/widgets/buttons/app_button.dart';

class PremiumTeaseButton extends StatelessWidget {
  const PremiumTeaseButton({
    super.key,
    required this.label,
    required this.teaseText,
    this.icon,
    this.onTap,
  });

  final String label;
  final String teaseText;
  final IconData? icon;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: 0.6,
      child: InkWell(
        key: Key('premium-tease-$label'),
        borderRadius: BorderRadius.circular(AppRadius.md),
        onTap: onTap ?? () => _showTeaseSheet(context),
        child: Container(
          padding: const EdgeInsets.all(AppSpacing.md),
          decoration: BoxDecoration(
            color: AppColors.surface1,
            borderRadius: BorderRadius.circular(AppRadius.md),
            border: Border.all(color: AppColors.surface3),
          ),
          child: Row(
            children: [
              Icon(icon ?? Icons.lock_rounded, color: AppColors.gold),
              const SizedBox(width: AppSpacing.sm),
              Expanded(
                child: Text(
                  label,
                  overflow: TextOverflow.ellipsis,
                  style: AppTypography.labelLarge,
                ),
              ),
              const SizedBox(width: AppSpacing.sm),
              DecoratedBox(
                decoration: BoxDecoration(
                  color: AppColors.glassBlack,
                  borderRadius: BorderRadius.circular(AppRadius.pill),
                  border: Border.all(color: AppColors.gold),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppSpacing.sm,
                    vertical: AppSpacing.xs,
                  ),
                  child: Text(
                    teaseText,
                    style: AppTypography.labelSmall.copyWith(
                      color: AppColors.gold,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _showTeaseSheet(BuildContext context) {
    return showModalBottomSheet<void>(
      context: context,
      backgroundColor: AppColors.surface2,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(AppRadius.xl)),
      ),
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.all(AppSpacing.xl),
          child: Column(
            key: const Key('premium-tease-sheet'),
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                '$label segera hadir',
                style: AppTypography.headlineSmall,
              ),
              const SizedBox(height: AppSpacing.md),
              Text(
                'Fitur ini akan tersedia di versi premium v0.2.x. Daftar waitlist untuk update.',
                style: AppTypography.bodyMedium.copyWith(
                  color: AppColors.textSecondary,
                ),
              ),
              const SizedBox(height: AppSpacing.lg),
              AppButton(
                label: 'Notify me',
                variant: AppButtonVariant.secondary,
                onPressed: () => Navigator.of(context).pop(),
              ),
              const SizedBox(height: AppSpacing.sm),
              AppButton(
                label: 'OK',
                onPressed: () => Navigator.of(context).pop(),
              ),
            ],
          ),
        );
      },
    );
  }
}
