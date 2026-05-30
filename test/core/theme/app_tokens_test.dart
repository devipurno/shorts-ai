import 'package:flutter/animation.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shorts_ai/core/theme/app_animations.dart';
import 'package:shorts_ai/core/theme/app_radius.dart';
import 'package:shorts_ai/core/theme/app_shadows.dart';
import 'package:shorts_ai/core/theme/app_spacing.dart';

void main() {
  test('exposes spacing and radius scale', () {
    expect(AppSpacing.xs, 4);
    expect(AppSpacing.xl, 24);
    expect(AppSpacing.huge, 64);
    expect(AppRadius.sm, 8);
    expect(AppRadius.pill, 999);
  });

  test('exposes animation durations and curves', () {
    expect(AppDurations.fast, const Duration(milliseconds: 150));
    expect(AppDurations.slower, const Duration(milliseconds: 800));
    expect(AppCurves.standard, Curves.easeInOutCubic);
    expect(AppCurves.emphasized, Curves.easeOutBack);
  });

  test('exposes subtle and premium gold shadow tokens', () {
    expect(AppShadows.shadowSm, isNotEmpty);
    expect(AppShadows.shadowMd.first.blurRadius,
        greaterThan(AppShadows.shadowSm.first.blurRadius));
    expect(AppShadows.shadowGoldGlow.first.blurRadius, 24);
  });
}
