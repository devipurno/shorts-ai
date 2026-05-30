import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import '../../../core/constants/asset_paths.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/theme/app_typography.dart';
import '../../../shared/widgets/brand/app_logo.dart';

class StepWelcome extends StatelessWidget {
  const StepWelcome({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      key: const ValueKey('onboarding-step-welcome'),
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const AppLogo(
          variant: AppLogoVariant.monogram,
          size: AppLogoSize.lg,
        ),
        const SizedBox(height: AppSpacing.xl),
        Lottie.asset(
          AssetPaths.splashLoader,
          width: 148,
          height: 148,
          repeat: true,
        ),
        const SizedBox(height: AppSpacing.xl),
        Text(
          'Buat Shorts viral dalam menit, bukan jam',
          textAlign: TextAlign.center,
          style: AppTypography.displaySmall.copyWith(
            color: AppColors.textPrimary,
          ),
        ),
        const SizedBox(height: AppSpacing.md),
        Text(
          'AutoShort membantu kreator Indonesia menemukan hook, memotong momen terbaik, dan menyiapkan konten siap review.',
          textAlign: TextAlign.center,
          style: AppTypography.bodyMedium.copyWith(
            color: AppColors.textSecondary,
          ),
        ),
      ],
    );
  }
}
