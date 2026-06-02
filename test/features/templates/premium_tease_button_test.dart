import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shorts_ai/core/theme/app_theme.dart';
import 'package:shorts_ai/core/theme/app_typography.dart';
import 'package:shorts_ai/features/templates/widgets/premium_tease_button.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  setUpAll(() {
    AppTypography.setUseGoogleFontsForTest(false);
  });

  testWidgets('opens premium tease bottom sheet', (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        theme: darkTheme(),
        home: const Scaffold(
          body: PremiumTeaseButton(
            label: 'Customize',
            teaseText: 'Coming v0.2.x',
            icon: Icons.tune_rounded,
          ),
        ),
      ),
    );

    expect(find.byKey(const Key('premium-tease-Customize')), findsOneWidget);
    expect(find.text('Coming v0.2.x'), findsOneWidget);

    await tester.tap(find.byKey(const Key('premium-tease-Customize')));
    await tester.pumpAndSettle();

    expect(find.byKey(const Key('premium-tease-sheet')), findsOneWidget);
    expect(find.text('Customize segera hadir'), findsOneWidget);
    expect(find.text('Notify me'), findsOneWidget);
  });
}
