import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'app_colors.dart';

class AppTypography {
  AppTypography._();

  static bool _useGoogleFonts = true;

  @visibleForTesting
  static void setUseGoogleFontsForTest(bool value) {
    _useGoogleFonts = value;
  }

  static TextStyle get displayLarge => _inter(
        fontSize: 48,
        height: 1.05,
        fontWeight: FontWeight.w800,
        letterSpacing: -0.4,
        color: AppColors.textPrimary,
      );

  static TextStyle get displayMedium => _inter(
        fontSize: 36,
        height: 1.08,
        fontWeight: FontWeight.w800,
        letterSpacing: -0.2,
        color: AppColors.textPrimary,
      );

  static TextStyle get displaySmall => _inter(
        fontSize: 28,
        height: 1.12,
        fontWeight: FontWeight.w700,
        letterSpacing: 0,
        color: AppColors.textPrimary,
      );

  static TextStyle get headlineLarge => _inter(
        fontSize: 24,
        height: 1.18,
        fontWeight: FontWeight.w700,
        letterSpacing: 0,
        color: AppColors.textPrimary,
      );

  static TextStyle get headlineMedium => _inter(
        fontSize: 20,
        height: 1.22,
        fontWeight: FontWeight.w700,
        letterSpacing: 0,
        color: AppColors.textPrimary,
      );

  static TextStyle get headlineSmall => _inter(
        fontSize: 18,
        height: 1.28,
        fontWeight: FontWeight.w600,
        letterSpacing: 0,
        color: AppColors.textPrimary,
      );

  static TextStyle get bodyLarge => _inter(
        fontSize: 16,
        height: 1.5,
        fontWeight: FontWeight.w400,
        letterSpacing: 0,
        color: AppColors.textPrimary,
      );

  static TextStyle get bodyMedium => _inter(
        fontSize: 14,
        height: 1.45,
        fontWeight: FontWeight.w400,
        letterSpacing: 0,
        color: AppColors.textPrimary,
      );

  static TextStyle get bodySmall => _inter(
        fontSize: 12,
        height: 1.35,
        fontWeight: FontWeight.w400,
        letterSpacing: 0.1,
        color: AppColors.textSecondary,
      );

  static TextStyle get labelLarge => _inter(
        fontSize: 14,
        height: 1.2,
        fontWeight: FontWeight.w700,
        letterSpacing: 0.2,
        color: AppColors.textPrimary,
      );

  static TextStyle get labelMedium => _inter(
        fontSize: 12,
        height: 1.2,
        fontWeight: FontWeight.w700,
        letterSpacing: 0.4,
        color: AppColors.textPrimary,
      );

  static TextStyle get labelSmall => _inter(
        fontSize: 10,
        height: 1.2,
        fontWeight: FontWeight.w700,
        letterSpacing: 0.6,
        color: AppColors.textSecondary,
      );

  static TextStyle get mono => _jetBrainsMono(
        fontSize: 14,
        height: 1.45,
        fontWeight: FontWeight.w500,
        letterSpacing: 0,
        color: AppColors.textPrimary,
      );

  static TextTheme get textTheme => TextTheme(
        displayLarge: displayLarge,
        displayMedium: displayMedium,
        displaySmall: displaySmall,
        headlineLarge: headlineLarge,
        headlineMedium: headlineMedium,
        headlineSmall: headlineSmall,
        bodyLarge: bodyLarge,
        bodyMedium: bodyMedium,
        bodySmall: bodySmall,
        labelLarge: labelLarge,
        labelMedium: labelMedium,
        labelSmall: labelSmall,
        titleLarge: headlineLarge,
        titleMedium: headlineMedium,
        titleSmall: headlineSmall,
      );

  static TextStyle _inter({
    required double fontSize,
    required double height,
    required FontWeight fontWeight,
    required double letterSpacing,
    required Color color,
  }) {
    final base = TextStyle(
      fontFamily: 'Inter',
      fontSize: fontSize,
      height: height,
      fontWeight: fontWeight,
      letterSpacing: letterSpacing,
      color: color,
    );
    return _useGoogleFonts ? GoogleFonts.inter(textStyle: base) : base;
  }

  static TextStyle _jetBrainsMono({
    required double fontSize,
    required double height,
    required FontWeight fontWeight,
    required double letterSpacing,
    required Color color,
  }) {
    final base = TextStyle(
      fontFamily: 'JetBrains Mono',
      fontSize: fontSize,
      height: height,
      fontWeight: fontWeight,
      letterSpacing: letterSpacing,
      color: color,
    );
    return _useGoogleFonts ? GoogleFonts.jetBrainsMono(textStyle: base) : base;
  }
}
