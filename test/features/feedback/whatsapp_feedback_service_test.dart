import 'package:flutter_test/flutter_test.dart';
import 'package:url_launcher/url_launcher.dart';

import 'package:shorts_ai/features/feedback/models/feedback_category.dart';
import 'package:shorts_ai/features/feedback/services/whatsapp_feedback_service.dart';

void main() {
  const deviceContext = {
    'appVersion': '0.1.2+1',
    'deviceModel': 'OPPO CPH2209',
    'osVersion': 'Android 13 (SDK 33)',
  };

  WhatsAppFeedbackService service({
    Future<bool> Function(Uri)? canLaunch,
    Future<bool> Function(Uri, {required LaunchMode mode})? launchUrlFn,
  }) {
    return WhatsAppFeedbackService(
      phoneNumber: '628123456789',
      canLaunch: canLaunch,
      launchUrlFn: launchUrlFn,
      clock: () => DateTime.utc(2026, 6, 2, 9, 30, 15),
    );
  }

  test('builds correct WhatsApp deeplink URL with encoded text', () {
    final url = service().buildUrl(
      category: FeedbackCategory.bug,
      deviceContext: deviceContext,
      currentRoute: '/profile',
    );

    expect(url.scheme, 'https');
    expect(url.host, 'wa.me');
    expect(url.path, '/628123456789');
    expect(url.toString(), startsWith('https://wa.me/628123456789?text='));
    expect(url.toString(), contains('%0A'));
    expect(url.toString(), contains('Halo%20Devi'));
    expect(url.queryParameters['text'], contains('🐛 Bug'));
  });

  test('message template includes context and ISO8601 timestamp', () {
    final message = service().buildMessage(
      category: FeedbackCategory.feature,
      deviceContext: deviceContext,
      currentRoute: '/templates',
    );

    expect(message, contains('Halo Devi! 👋'));
    expect(message, contains('Mau report: ✨ Saran Fitur'));
    expect(message, contains('App: AutoShort v0.1.2+1'));
    expect(message, contains('Device: OPPO CPH2209'));
    expect(message, contains('OS: Android 13 (SDK 33)'));
    expect(message, contains('Screen: /templates'));
    expect(message, contains('Waktu: 2026-06-02T09:30:15.000Z'));
    expect(message, contains('[Tulis disini]'));
  });

  test('launch returns false when WhatsApp URL cannot be launched', () async {
    final result = await service(canLaunch: (_) async => false).launch(
      category: FeedbackCategory.praise,
      deviceContext: deviceContext,
      currentRoute: '/profile',
    );

    expect(result, isFalse);
  });

  test('launch returns true when URL can launch and launcher succeeds',
      () async {
    Uri? launchedUrl;
    LaunchMode? launchMode;

    final result = await service(
      canLaunch: (_) async => true,
      launchUrlFn: (url, {required mode}) async {
        launchedUrl = url;
        launchMode = mode;
        return true;
      },
    ).launch(
      category: FeedbackCategory.bug,
      deviceContext: deviceContext,
      currentRoute: '/profile',
    );

    expect(result, isTrue);
    expect(launchedUrl?.host, 'wa.me');
    expect(launchMode, LaunchMode.externalApplication);
  });
}
