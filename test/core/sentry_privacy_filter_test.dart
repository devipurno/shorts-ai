// ignore_for_file: deprecated_member_use

import 'package:flutter_test/flutter_test.dart';
import 'package:sentry_flutter/sentry_flutter.dart';
import 'package:shorts_ai/core/sentry_config.dart';

void main() {
  test('scrubSensitiveData redacts emails, bearer tokens, JWTs, and passwords',
      () {
    const jwt = 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.payload.signature';
    final scrubbed = scrubSensitiveData(
      'email devi@autoshort.id Bearer abc.def-123 jwt $jwt '
      '{"password":"secret123"}',
    );

    expect(scrubbed, contains('[EMAIL_REDACTED]'));
    expect(scrubbed, contains('Bearer [TOKEN_REDACTED]'));
    expect(scrubbed, contains('[JWT_REDACTED]'));
    expect(scrubbed, contains('"password":"***"'));
    expect(scrubbed, isNot(contains('devi@autoshort.id')));
    expect(scrubbed, isNot(contains('secret123')));
  });

  test('scrubMap redacts sensitive keys and nested string values', () {
    final scrubbed = scrubMap({
      'password': 'secret',
      'token': 'raw-token',
      'api_key': 'key',
      'authorization': 'Bearer abc.def',
      'note': 'Contact devi@autoshort.id',
      'nested': {'secret': 'inner'},
    });

    expect(scrubbed!['password'], '[REDACTED]');
    expect(scrubbed['token'], '[REDACTED]');
    expect(scrubbed['api_key'], '[REDACTED]');
    expect(scrubbed['authorization'], '[REDACTED]');
    expect(scrubbed['note'], 'Contact [EMAIL_REDACTED]');
    expect(
        (scrubbed['nested'] as Map<String, dynamic>)['secret'], '[REDACTED]');
  });

  test('privacyFilter scrubs message, breadcrumbs, extra, and user PII', () {
    final event = SentryEvent(
      message: SentryMessage('Login failed for devi@autoshort.id'),
      breadcrumbs: [
        Breadcrumb(
          message: 'Bearer abc.def for devi@autoshort.id',
          data: {'password': 'secret', 'path': '/login'},
        ),
      ],
      extra: {'api_key': 'secret-key', 'note': 'devi@autoshort.id'},
      user: SentryUser(
        id: 'user-1',
        email: 'devi@autoshort.id',
        name: 'Devi',
        ipAddress: '127.0.0.1',
      ),
    );

    final filtered = privacyFilter(event, Hint())!;

    expect(filtered.message!.formatted, 'Login failed for [EMAIL_REDACTED]');
    expect(
      filtered.breadcrumbs!.single.message,
      'Bearer [TOKEN_REDACTED] for [EMAIL_REDACTED]',
    );
    expect(filtered.breadcrumbs!.single.data!['password'], '[REDACTED]');
    expect(filtered.extra!['api_key'], '[REDACTED]');
    expect(filtered.extra!['note'], '[EMAIL_REDACTED]');
    expect(filtered.user!.id, 'user-1');
    expect(filtered.user!.email, isNull);
    expect(filtered.user!.name, isNull);
    expect(filtered.user!.ipAddress, isNull);
  });
}
