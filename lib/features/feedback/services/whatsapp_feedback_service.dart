import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../core/env/env.dart';
import '../models/feedback_category.dart';

typedef CanLaunchFeedbackUrl = Future<bool> Function(Uri url);
typedef LaunchFeedbackUrl = Future<bool> Function(
  Uri url, {
  required LaunchMode mode,
});
typedef FeedbackClock = DateTime Function();

final whatsappFeedbackServiceProvider =
    Provider<WhatsAppFeedbackService>((ref) {
  return WhatsAppFeedbackService(phoneNumber: Env.feedbackWhatsappNumber);
});

class WhatsAppFeedbackService {
  const WhatsAppFeedbackService({
    required this.phoneNumber,
    CanLaunchFeedbackUrl? canLaunch,
    LaunchFeedbackUrl? launchUrlFn,
    FeedbackClock? clock,
  })  : _canLaunch = canLaunch ?? canLaunchUrl,
        _launchUrl = launchUrlFn ?? launchUrl,
        _clock = clock ?? DateTime.now;

  final String phoneNumber;
  final CanLaunchFeedbackUrl _canLaunch;
  final LaunchFeedbackUrl _launchUrl;
  final FeedbackClock _clock;

  Future<bool> launch({
    required FeedbackCategory category,
    required Map<String, String> deviceContext,
    String? currentRoute,
  }) async {
    final url = buildUrl(
      category: category,
      deviceContext: deviceContext,
      currentRoute: currentRoute,
    );

    if (!await _canLaunch(url)) {
      return false;
    }

    return _launchUrl(url, mode: LaunchMode.externalApplication);
  }

  Uri buildUrl({
    required FeedbackCategory category,
    required Map<String, String> deviceContext,
    String? currentRoute,
  }) {
    final message = buildMessage(
      category: category,
      deviceContext: deviceContext,
      currentRoute: currentRoute,
    );
    return Uri.parse(
      'https://wa.me/$phoneNumber?text=${Uri.encodeComponent(message)}',
    );
  }

  String buildMessage({
    required FeedbackCategory category,
    required Map<String, String> deviceContext,
    String? currentRoute,
  }) {
    return '''
Halo Devi! 👋
Mau report: ${category.emoji} ${category.label}
App: AutoShort v${deviceContext['appVersion'] ?? 'unknown'}
Device: ${deviceContext['deviceModel'] ?? 'unknown'}
OS: ${deviceContext['osVersion'] ?? 'unknown'}
Screen: ${currentRoute ?? 'unknown'}
Waktu: ${_clock().toIso8601String()}
Detail:
[Tulis disini]
'''
        .trim();
  }
}
