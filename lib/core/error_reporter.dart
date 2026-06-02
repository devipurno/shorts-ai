import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sentry_flutter/sentry_flutter.dart';

import 'env/env.dart';
import 'sentry_config.dart';

abstract class ErrorReporter {
  Future<void> captureException(
    Object exception, {
    StackTrace? stackTrace,
    Map<String, dynamic>? extra,
    String? hint,
  });

  void addBreadcrumb({
    required String message,
    String? category,
    SentryLevel level = SentryLevel.info,
    Map<String, dynamic>? data,
  });

  Future<void> setUser({required String userId});
  Future<void> clearUser();
}

abstract class SentryBackend {
  Future<void> captureException(
    Object exception, {
    StackTrace? stackTrace,
    Hint? hint,
  });

  void addBreadcrumb(Breadcrumb breadcrumb);
  Future<void> setUser(SentryUser? user);
}

class RealSentryBackend implements SentryBackend {
  const RealSentryBackend();

  @override
  Future<void> captureException(
    Object exception, {
    StackTrace? stackTrace,
    Hint? hint,
  }) {
    return Sentry.captureException(
      exception,
      stackTrace: stackTrace,
      hint: hint,
    );
  }

  @override
  void addBreadcrumb(Breadcrumb breadcrumb) {
    Sentry.addBreadcrumb(breadcrumb);
  }

  @override
  Future<void> setUser(SentryUser? user) async {
    await Sentry.configureScope((scope) => scope.setUser(user));
  }
}

class SentryErrorReporter implements ErrorReporter {
  const SentryErrorReporter({SentryBackend backend = const RealSentryBackend()})
      : _backend = backend;

  final SentryBackend _backend;

  @override
  Future<void> captureException(
    Object exception, {
    StackTrace? stackTrace,
    Map<String, dynamic>? extra,
    String? hint,
  }) {
    return _backend.captureException(
      exception,
      stackTrace: stackTrace,
      hint: Hint.withMap({
        if (hint != null) 'hint': hint,
        if (extra != null) 'extra': scrubMap(extra),
      }),
    );
  }

  @override
  void addBreadcrumb({
    required String message,
    String? category,
    SentryLevel level = SentryLevel.info,
    Map<String, dynamic>? data,
  }) {
    _backend.addBreadcrumb(
      Breadcrumb(
        message: scrubSensitiveData(message),
        category: category,
        level: level,
        data: scrubMap(data),
        timestamp: DateTime.now().toUtc(),
      ),
    );
  }

  @override
  Future<void> setUser({required String userId}) {
    return _backend.setUser(SentryUser(id: userId));
  }

  @override
  Future<void> clearUser() {
    return _backend.setUser(null);
  }
}

class NoOpErrorReporter implements ErrorReporter {
  const NoOpErrorReporter();

  @override
  Future<void> captureException(
    Object exception, {
    StackTrace? stackTrace,
    Map<String, dynamic>? extra,
    String? hint,
  }) async {
    if (kDebugMode) {
      debugPrint('[ErrorReporter:NoOp] Captured: $exception');
    }
  }

  @override
  void addBreadcrumb({
    required String message,
    String? category,
    SentryLevel level = SentryLevel.info,
    Map<String, dynamic>? data,
  }) {
    if (kDebugMode) {
      debugPrint('[ErrorReporter:NoOp] Breadcrumb: $category | $message');
    }
  }

  @override
  Future<void> setUser({required String userId}) async {}

  @override
  Future<void> clearUser() async {}
}

final errorReporterProvider = Provider<ErrorReporter>((ref) {
  final useSentry = Env.sentryDsn != null && !kDebugMode;
  return useSentry ? const SentryErrorReporter() : const NoOpErrorReporter();
});
