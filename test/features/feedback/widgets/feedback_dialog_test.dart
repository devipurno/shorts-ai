import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sentry_flutter/sentry_flutter.dart';
import 'package:shorts_ai/core/theme/app_theme.dart';
import 'package:shorts_ai/core/theme/app_typography.dart';
import 'package:shorts_ai/features/feedback/services/sentry_feedback_service.dart';
import 'package:shorts_ai/features/feedback/widgets/feedback_dialog.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  setUpAll(() {
    AppTypography.setUseGoogleFontsForTest(false);
  });

  testWidgets('renders three category chips', (tester) async {
    await tester.pumpWidget(_dialogHarness());
    await _openDialog(tester);

    expect(find.byKey(const Key('feedback-dialog')), findsOneWidget);
    expect(find.byKey(const Key('feedback-category-bug')), findsOneWidget);
    expect(find.byKey(const Key('feedback-category-feature')), findsOneWidget);
    expect(find.byKey(const Key('feedback-category-praise')), findsOneWidget);
  });

  testWidgets('submit button requires message and category', (tester) async {
    final backend = _FakeSentryFeedbackBackend();
    await tester.pumpWidget(_dialogHarness(backend: backend));
    await _openDialog(tester);

    await tester.tap(find.byKey(const Key('feedback-submit-button')));
    await tester.pump();
    expect(backend.feedback, isNull);

    await tester.enterText(
      find.byKey(const Key('feedback-message-field')),
      'Aku punya saran',
    );
    await tester.pump();
    await tester.tap(find.byKey(const Key('feedback-submit-button')));
    await tester.pump();
    expect(backend.feedback, isNull);

    await tester.tap(find.byKey(const Key('feedback-category-feature')));
    await tester.pump();
    await tester.tap(find.byKey(const Key('feedback-submit-button')));
    await tester.pumpAndSettle();

    expect(backend.feedback?.message, '[Saran Fitur] Aku punya saran');
    expect(find.byKey(const Key('feedback-success-snackbar')), findsOneWidget);
  });

  testWidgets('optional email is submitted when filled', (tester) async {
    final backend = _FakeSentryFeedbackBackend();
    await tester.pumpWidget(_dialogHarness(backend: backend));
    await _openDialog(tester);

    await tester.tap(find.byKey(const Key('feedback-category-bug')));
    await tester.enterText(
      find.byKey(const Key('feedback-message-field')),
      'Bug di halaman profile',
    );
    await tester.enterText(
      find.byKey(const Key('feedback-email-field')),
      'tester@autoshort.id',
    );
    await tester.pump();
    await tester.tap(find.byKey(const Key('feedback-submit-button')));
    await tester.pumpAndSettle();

    expect(backend.feedback?.contactEmail, 'tester@autoshort.id');
  });

  testWidgets('cancel button closes dialog', (tester) async {
    await tester.pumpWidget(_dialogHarness());
    await _openDialog(tester);

    expect(find.byKey(const Key('feedback-dialog')), findsOneWidget);
    await tester.tap(find.byKey(const Key('feedback-cancel-button')));
    await tester.pumpAndSettle();

    expect(find.byKey(const Key('feedback-dialog')), findsNothing);
  });
}

Future<void> _openDialog(WidgetTester tester) async {
  await tester.tap(find.text('Open'));
  await tester.pumpAndSettle();
}

Widget _dialogHarness({_FakeSentryFeedbackBackend? backend}) {
  final fakeBackend = backend ?? _FakeSentryFeedbackBackend();
  return ProviderScope(
    overrides: [
      sentryFeedbackServiceProvider.overrideWithValue(
        SentryFeedbackService(backend: fakeBackend),
      ),
    ],
    child: MaterialApp(
      theme: darkTheme(),
      home: Builder(
        builder: (context) {
          return Scaffold(
            body: Center(
              child: ElevatedButton(
                onPressed: () => showDialog<void>(
                  context: context,
                  builder: (_) => const FeedbackDialog(),
                ),
                child: const Text('Open'),
              ),
            ),
          );
        },
      ),
    ),
  );
}

class _FakeSentryFeedbackBackend implements SentryFeedbackBackend {
  final eventId = SentryId.fromId('1234567890abcdef1234567890abcdef');
  SentryFeedback? feedback;

  @override
  Future<SentryId> captureMessage(
    String message, {
    SentryLevel? level,
    ScopeCallback? withScope,
  }) async {
    return eventId;
  }

  @override
  Future<SentryId> captureFeedback(SentryFeedback feedback) async {
    this.feedback = feedback;
    return eventId;
  }
}
