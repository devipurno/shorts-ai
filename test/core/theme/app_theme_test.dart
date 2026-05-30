import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shorts_ai/app.dart';
import 'package:shorts_ai/core/theme/app_colors.dart';
import 'package:shorts_ai/core/theme/app_radius.dart';
import 'package:shorts_ai/core/theme/app_theme.dart';
import 'package:shorts_ai/core/theme/app_typography.dart';

void main() {
  setUpAll(() {
    AppTypography.setUseGoogleFontsForTest(false);
  });

  test('builds a dark-only gold and obsidian ThemeData', () {
    final theme = darkTheme();

    expect(theme.brightness, Brightness.dark);
    expect(theme.colorScheme.primary, AppColors.gold);
    expect(theme.scaffoldBackgroundColor, AppColors.surface0);
    expect(theme.cardTheme.color, AppColors.surface1);
    expect(theme.dividerTheme.color, AppColors.surface3);
  });

  test('configures rounded card, dialog, and bottom sheet surfaces', () {
    final theme = darkTheme();

    expect(theme.cardTheme.shape, isA<RoundedRectangleBorder>());
    expect(theme.dialogTheme.backgroundColor, AppColors.surface2);
    expect(theme.bottomSheetTheme.backgroundColor, AppColors.surface2);

    final cardShape = theme.cardTheme.shape! as RoundedRectangleBorder;
    expect(cardShape.borderRadius, BorderRadius.circular(AppRadius.md));
  });

  testWidgets('app shell uses the premium dark theme', (tester) async {
    await tester.pumpWidget(
      const ProviderScope(
        child: MyApp(),
      ),
    );
    await tester.pump(const Duration(seconds: 3));
    await tester.pumpAndSettle();

    final materialApp = tester.widget<MaterialApp>(find.byType(MaterialApp));
    expect(materialApp.locale, const Locale('id', 'ID'));
    expect(materialApp.themeMode, ThemeMode.dark);

    final scaffold = tester.widget<Scaffold>(find.byType(Scaffold));
    expect(scaffold.backgroundColor, AppColors.obsidian);
    expect(
      Theme.of(tester.element(find.byType(Scaffold))).colorScheme.primary,
      AppColors.gold,
    );
    expect(find.byKey(const Key('placeholder-Onboarding')), findsOneWidget);
  });
}
