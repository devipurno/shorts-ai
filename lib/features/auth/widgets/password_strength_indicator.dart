import 'package:flutter/material.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_radius.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/theme/app_typography.dart';

enum PasswordStrength { weak, medium, strong }

class PasswordStrengthIndicator extends StatelessWidget {
  const PasswordStrengthIndicator({
    super.key,
    required this.password,
  });

  final String password;

  PasswordStrength get strength {
    final hasLetter = RegExp('[A-Za-z]').hasMatch(password);
    final hasNumber = RegExp('[0-9]').hasMatch(password);
    final hasSymbol = RegExp(r'[^A-Za-z0-9]').hasMatch(password);

    if (password.length >= 12 && hasLetter && hasNumber && hasSymbol) {
      return PasswordStrength.strong;
    }
    if (password.length >= 8 && hasLetter && hasNumber) {
      return PasswordStrength.medium;
    }
    return PasswordStrength.weak;
  }

  @override
  Widget build(BuildContext context) {
    final activeSegments = switch (strength) {
      PasswordStrength.weak => password.isEmpty ? 0 : 1,
      PasswordStrength.medium => 2,
      PasswordStrength.strong => 3,
    };
    final label = switch (strength) {
      PasswordStrength.weak => 'Weak',
      PasswordStrength.medium => 'Medium',
      PasswordStrength.strong => 'Strong',
    };

    return Column(
      key: const Key('password-strength-indicator'),
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            for (var index = 0; index < 3; index++) ...[
              Expanded(
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 180),
                  height: 5,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(AppRadius.pill),
                    gradient: index < activeSegments
                        ? _activeGradient(strength)
                        : null,
                    color: index < activeSegments ? null : AppColors.surface3,
                  ),
                ),
              ),
              if (index < 2) const SizedBox(width: AppSpacing.xs),
            ],
          ],
        ),
        const SizedBox(height: AppSpacing.xs),
        Text(
          'Password strength: $label',
          style: AppTypography.labelSmall.copyWith(
            color: strength == PasswordStrength.strong
                ? AppColors.gold
                : AppColors.textTertiary,
          ),
        ),
      ],
    );
  }

  LinearGradient _activeGradient(PasswordStrength strength) {
    return switch (strength) {
      PasswordStrength.weak => const LinearGradient(
          colors: [AppColors.error, AppColors.warning],
        ),
      PasswordStrength.medium => const LinearGradient(
          colors: [AppColors.warning, AppColors.goldDark],
        ),
      PasswordStrength.strong => const LinearGradient(
          colors: [AppColors.goldDark, AppColors.gold, AppColors.goldLight],
        ),
    };
  }
}
