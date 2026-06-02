import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sentry_flutter/sentry_flutter.dart';

import '../models/feedback_category.dart';

final sentryFeedbackServiceProvider = Provider<SentryFeedbackService>((ref) {
  return const SentryFeedbackService();
});

class SentryFeedbackService {
  const SentryFeedbackService({
    SentryFeedbackBackend backend = const RealSentryFeedbackBackend(),
  }) : _backend = backend;

  final SentryFeedbackBackend _backend;

  Future<void> submit({
    required FeedbackCategory category,
    required String message,
    String? userEmail,
  }) async {
    final trimmedMessage = message.trim();
    final email = userEmail?.trim();
    final eventId = await _backend.captureMessage(
      'User Feedback: ${category.label}',
      level: SentryLevel.info,
      withScope: (scope) {
        scope
          ..setTag('feedback_category', category.name)
          ..setTag('feedback_type', 'user_submitted');
      },
    );

    await _backend.captureFeedback(
      SentryFeedback(
        message: '[${category.label}] $trimmedMessage',
        name: 'AutoShort User',
        contactEmail:
            email == null || email.isEmpty ? 'anonymous@autoshort.app' : email,
        associatedEventId: eventId,
      ),
    );
  }
}

abstract class SentryFeedbackBackend {
  const SentryFeedbackBackend();

  Future<SentryId> captureMessage(
    String message, {
    SentryLevel? level,
    ScopeCallback? withScope,
  });

  Future<SentryId> captureFeedback(SentryFeedback feedback);
}

class RealSentryFeedbackBackend implements SentryFeedbackBackend {
  const RealSentryFeedbackBackend();

  @override
  Future<SentryId> captureMessage(
    String message, {
    SentryLevel? level,
    ScopeCallback? withScope,
  }) {
    return Sentry.captureMessage(
      message,
      level: level,
      withScope: withScope,
    );
  }

  @override
  Future<SentryId> captureFeedback(SentryFeedback feedback) {
    return Sentry.captureFeedback(feedback);
  }
}
