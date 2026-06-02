import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shorts_ai/core/env/env.dart';
import 'package:shorts_ai/core/theme/app_theme.dart';
import 'package:shorts_ai/core/theme/app_typography.dart';
import 'package:shorts_ai/features/feedback/feedback_button.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  setUpAll(() {
    AppTypography.setUseGoogleFontsForTest(false);
  });

  tearDown(Env.resetForTest);

  testWidgets('hides feedback button when Sentry DSN is empty', (
    tester,
  ) async {
    Env.loadFromStringForTest('');

    await tester.pumpWidget(
      MaterialApp(
        theme: darkTheme(),
        home: const Scaffold(body: FeedbackButton()),
      ),
    );

    expect(find.byKey(const Key('feedback-button')), findsNothing);
    expect(find.byType(SizedBox), findsOneWidget);
  });

  testWidgets('opens Sentry feedback dialog when Sentry DSN is configured', (
    tester,
  ) async {
    Env.loadFromStringForTest(
      'SENTRY_DSN=https://key@o1.ingest.sentry.io/1',
    );

    await tester.pumpWidget(
      MaterialApp(
        theme: darkTheme(),
        home: const Scaffold(body: FeedbackButton()),
      ),
    );

    await tester.tap(find.byKey(const Key('feedback-button')));
    await tester.pumpAndSettle();

    expect(find.byKey(const Key('feedback-dialog')), findsOneWidget);
  });

  testWidgets('compact button opens Sentry feedback dialog', (tester) async {
    Env.loadFromStringForTest(
      'SENTRY_DSN=https://key@o1.ingest.sentry.io/1',
    );

    await tester.pumpWidget(
      MaterialApp(
        theme: darkTheme(),
        home: const Scaffold(body: FeedbackButton(compact: true)),
      ),
    );

    await tester.tap(find.byKey(const Key('feedback-button-compact')));
    await tester.pumpAndSettle();

    expect(find.byKey(const Key('feedback-dialog')), findsOneWidget);
  });
}
