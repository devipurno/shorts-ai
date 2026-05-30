import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shorts_ai/core/theme/app_colors.dart';
import 'package:shorts_ai/core/theme/app_theme.dart';
import 'package:shorts_ai/core/theme/app_typography.dart';

void main() {
  setUpAll(() {
    AppTypography.setUseGoogleFontsForTest(false);
  });

  test('exposes Inter and JetBrains Mono typography tokens', () {
    expect(AppTypography.displayLarge.fontSize, 48);
    expect(AppTypography.headlineMedium.fontSize, 20);
    expect(AppTypography.bodyMedium.fontSize, 14);
    expect(AppTypography.labelSmall.fontWeight, FontWeight.w700);
    expect(AppTypography.bodyMedium.fontFamily, 'Inter');
    expect(AppTypography.mono.fontFamily, 'JetBrains Mono');
  });

  testWidgets('renders text with the dark luxury text theme', (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        theme: darkTheme(),
        home: const Scaffold(
          body: Text('AutoShort premium'),
        ),
      ),
    );

    final text = tester.widget<Text>(find.text('AutoShort premium'));
    final defaultStyle = DefaultTextStyle.of(
      tester.element(find.text('AutoShort premium')),
    ).style;

    expect(text.data, 'AutoShort premium');
    expect(defaultStyle.color, AppColors.textPrimary);
    expect(defaultStyle.fontFamily, contains('Inter'));
  });
}
