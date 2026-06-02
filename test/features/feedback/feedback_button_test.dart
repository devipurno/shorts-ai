import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shorts_ai/core/env/env.dart';
import 'package:shorts_ai/core/theme/app_theme.dart';
import 'package:shorts_ai/core/theme/app_typography.dart';
import 'package:shorts_ai/features/feedback/feedback_button.dart';
import 'package:shorts_ai/features/feedback/services/device_context_service.dart';
import 'package:shorts_ai/features/feedback/services/whatsapp_feedback_service.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  setUpAll(() {
    AppTypography.setUseGoogleFontsForTest(false);
  });

  tearDown(() {
    Env.resetForTest();
  });

  testWidgets('hides feedback button when WhatsApp number is empty', (
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

  testWidgets(
      'opens category sheet and shows fallback snackbar on failed launch', (
    tester,
  ) async {
    Env.loadFromStringForTest('FEEDBACK_WHATSAPP_NUMBER=628123456789');

    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          deviceContextServiceProvider.overrideWithValue(
            _FakeDeviceContextService(),
          ),
          whatsappFeedbackServiceProvider.overrideWithValue(
            WhatsAppFeedbackService(
              phoneNumber: '628123456789',
              canLaunch: (_) async => false,
            ),
          ),
        ],
        child: MaterialApp(
          theme: darkTheme(),
          home: const Scaffold(body: FeedbackButton()),
        ),
      ),
    );

    expect(find.byKey(const Key('feedback-button')), findsOneWidget);

    await tester.tap(find.byKey(const Key('feedback-button')));
    await tester.pumpAndSettle();

    expect(find.byKey(const Key('feedback-category-sheet')), findsOneWidget);
    expect(find.text('Kirim Feedback'), findsWidgets);
    expect(find.byKey(const Key('feedback-category-bug')), findsOneWidget);
    expect(find.byKey(const Key('feedback-category-feature')), findsOneWidget);
    expect(find.byKey(const Key('feedback-category-praise')), findsOneWidget);

    await tester.tap(find.byKey(const Key('feedback-category-bug')));
    await tester.pumpAndSettle();

    expect(
      find.byKey(const Key('feedback-whatsapp-fallback-snackbar')),
      findsOneWidget,
    );
    expect(
      find.textContaining('support@autoshort.id'),
      findsOneWidget,
    );
  });

  testWidgets('compact feedback button opens the same picker', (tester) async {
    Env.loadFromStringForTest('FEEDBACK_WHATSAPP_NUMBER=628123456789');

    await tester.pumpWidget(
      MaterialApp(
        theme: darkTheme(),
        home: const Scaffold(body: FeedbackButton(compact: true)),
      ),
    );

    await tester.tap(find.byKey(const Key('feedback-button-compact')));
    await tester.pumpAndSettle();

    expect(find.byKey(const Key('feedback-category-sheet')), findsOneWidget);
  });
}

class _FakeDeviceContextService extends DeviceContextService {
  @override
  Future<Map<String, String>> collect() async {
    return const {
      'appVersion': '0.1.2+1',
      'platform': 'android',
      'deviceModel': 'OPPO Test',
      'osVersion': 'Android 13',
    };
  }
}
