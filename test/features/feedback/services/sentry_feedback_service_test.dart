import 'package:flutter_test/flutter_test.dart';
import 'package:sentry_flutter/sentry_flutter.dart';
import 'package:shorts_ai/features/feedback/models/feedback_category.dart';
import 'package:shorts_ai/features/feedback/services/sentry_feedback_service.dart';

void main() {
  test('submits feedback with category tags and associated event id', () async {
    final backend = _FakeSentryFeedbackBackend();
    final service = SentryFeedbackService(backend: backend);

    await service.submit(
      category: FeedbackCategory.bug,
      message: 'Tombol export macet',
      userEmail: 'tester@autoshort.id',
    );

    expect(backend.message, 'User Feedback: Bug');
    expect(backend.level, SentryLevel.info);
    expect(backend.tags['feedback_category'], 'bug');
    expect(backend.tags['feedback_type'], 'user_submitted');
    expect(backend.feedback?.associatedEventId, backend.eventId);
    expect(backend.feedback?.contactEmail, 'tester@autoshort.id');
    expect(backend.feedback?.name, 'AutoShort User');
    expect(backend.feedback?.message, '[Bug] Tombol export macet');
  });

  test('defaults optional email to anonymous AutoShort address', () async {
    final backend = _FakeSentryFeedbackBackend();
    final service = SentryFeedbackService(backend: backend);

    await service.submit(
      category: FeedbackCategory.praise,
      message: 'Keren banget',
    );

    expect(backend.feedback?.contactEmail, 'anonymous@autoshort.app');
    expect(backend.feedback?.message, '[Apresiasi] Keren banget');
  });
}

class _FakeSentryFeedbackBackend implements SentryFeedbackBackend {
  final eventId = SentryId.fromId('1234567890abcdef1234567890abcdef');
  final tags = <String, String>{};
  String? message;
  SentryLevel? level;
  SentryFeedback? feedback;

  @override
  Future<SentryId> captureMessage(
    String message, {
    SentryLevel? level,
    ScopeCallback? withScope,
  }) async {
    this.message = message;
    this.level = level;
    if (withScope != null) {
      final scope = Scope(SentryOptions(dsn: 'https://key@example.com/1'));
      await withScope(scope);
      tags.addAll(scope.tags);
    }
    return eventId;
  }

  @override
  Future<SentryId> captureFeedback(SentryFeedback feedback) async {
    this.feedback = feedback;
    return eventId;
  }
}
