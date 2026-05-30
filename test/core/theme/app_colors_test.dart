import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shorts_ai/core/theme/app_colors.dart';

void main() {
  test('exposes premium dark luxury color tokens', () {
    expect(AppColors.gold, const Color(0xFFD4AF37));
    expect(AppColors.obsidian, const Color(0xFF0B0C10));
    expect(AppColors.surface0, AppColors.obsidian);
    expect(AppColors.textPrimary, const Color(0xFFF5F5F7));
    expect(AppColors.goldGlow, const Color(0x4DD4AF37));
  });
}
