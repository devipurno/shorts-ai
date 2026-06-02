import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sentry_flutter/sentry_flutter.dart';
import 'package:shorts_ai/core/env/env.dart';
import 'package:shorts_ai/core/error_reporter.dart';

void main() {
  tearDown(Env.resetForTest);

  test('NoOpErrorReporter captureException and breadcrumbs do not crash',
      () async {
    const reporter = NoOpErrorReporter();

    await reporter.captureException(
      StateError('boom'),
      stackTrace: StackTrace.current,
      extra: {'password': 'secret'},
      hint: 'test',
    );
    reporter.addBreadcrumb(message: 'Tapped login', category: 'ui');
    await reporter.setUser(userId: 'user-1');
    await reporter.clearUser();
  });

  test('SentryErrorReporter delegates to backend with scrubbed data', () async {
    final backend = _FakeSentryBackend();
    final reporter = SentryErrorReporter(backend: backend);

    await reporter.captureException(
      StateError('boom'),
      stackTrace: StackTrace.current,
      extra: {'token': 'secret-token'},
      hint: 'unit-test',
    );
    reporter.addBreadcrumb(
      message: 'User devi@autoshort.id tapped button',
      category: 'ui',
      data: {'password': 'secret'},
    );
    await reporter.setUser(userId: 'user-1');
    await reporter.clearUser();

    expect(backend.exception, isA<StateError>());
    expect(backend.breadcrumb!.message, 'User [EMAIL_REDACTED] tapped button');
    expect(backend.breadcrumb!.data!['password'], '[REDACTED]');
    expect(backend.users[0]!.id, 'user-1');
    expect(backend.users[1], isNull);
  });

  test('errorReporterProvider returns NoOp in debug mode or empty DSN', () {
    Env.loadFromStringForTest('SENTRY_DSN=');
    final container = ProviderContainer();
    addTearDown(container.dispose);

    expect(container.read(errorReporterProvider), isA<NoOpErrorReporter>());
  });
}

class _FakeSentryBackend implements SentryBackend {
  Object? exception;
  Breadcrumb? breadcrumb;
  final users = <SentryUser?>[];

  @override
  void addBreadcrumb(Breadcrumb breadcrumb) {
    this.breadcrumb = breadcrumb;
  }

  @override
  Future<void> captureException(
    Object exception, {
    StackTrace? stackTrace,
    Hint? hint,
  }) async {
    this.exception = exception;
  }

  @override
  Future<void> setUser(SentryUser? user) async {
    users.add(user);
  }
}
