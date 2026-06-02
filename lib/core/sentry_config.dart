import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:sentry_flutter/sentry_flutter.dart';

import 'constants/app_constants.dart';
import 'env/env.dart';
import 'supabase_client.dart';

Future<void> initSentry({required Widget Function() appBuilder}) async {
  WidgetsFlutterBinding.ensureInitialized();
  await Env.init();
  await initSupabase();
  await AppConstants.init();

  final dsn = Env.sentryDsn;
  final useSentry = dsn != null && dsn.isNotEmpty && !kDebugMode;

  if (!useSentry) {
    debugPrint(
      '[Sentry] Disabled (kDebugMode=$kDebugMode, dsn empty=${dsn == null || dsn.isEmpty})',
    );
    runApp(appBuilder());
    return;
  }

  await SentryFlutter.init(
    (options) {
      options
        ..dsn = dsn
        ..environment = kDebugMode ? 'dev' : 'production'
        ..release = 'shorts-ai@${Env.appVersion}'
        ..tracesSampleRate = 0.2
        ..attachScreenshot = false
        ..sendDefaultPii = false
        ..beforeSend = privacyFilter
        ..maxBreadcrumbs = 50
        ..debug = kDebugMode;
    },
    appRunner: () => runApp(appBuilder()),
  );

  debugPrint(
      '[Sentry] Initialized: env=production, release=shorts-ai@${Env.appVersion}');
}

SentryEvent? privacyFilter(SentryEvent event, Hint hint) {
  final message = event.message?.formatted;
  final scrubbedMessage = message == null ? null : scrubSensitiveData(message);
  final scrubbedBreadcrumbs = event.breadcrumbs
      ?.map(
        (breadcrumb) => Breadcrumb(
          message: breadcrumb.message == null
              ? null
              : scrubSensitiveData(breadcrumb.message!),
          category: breadcrumb.category,
          data: scrubMap(breadcrumb.data),
          level: breadcrumb.level,
          type: breadcrumb.type,
          timestamp: breadcrumb.timestamp,
        ),
      )
      .toList(growable: false);
  final scrubbedUser = event.user == null
      ? null
      : SentryUser(
          id: event.user!.id,
        );

  // ignore: deprecated_member_use
  return event.copyWith(
    message: scrubbedMessage == null ? null : SentryMessage(scrubbedMessage),
    breadcrumbs: scrubbedBreadcrumbs,
    user: scrubbedUser,
    // ignore: deprecated_member_use
    extra: scrubMap(event.extra),
  );
}

String scrubSensitiveData(String input) {
  var result = input.replaceAll(
    RegExp(r'[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}'),
    '[EMAIL_REDACTED]',
  );
  result = result.replaceAll(
    RegExp(r'Bearer [A-Za-z0-9._-]+', caseSensitive: false),
    'Bearer [TOKEN_REDACTED]',
  );
  result = result.replaceAll(
    RegExp(r'ey[A-Za-z0-9_-]{20,}\.[A-Za-z0-9_-]+\.[A-Za-z0-9_-]+'),
    '[JWT_REDACTED]',
  );
  result = result.replaceAllMapped(
    RegExp(r'("password"\s*:\s*")[^"]+(")', caseSensitive: false),
    (match) => '${match.group(1)}***${match.group(2)}',
  );
  return result;
}

Map<String, dynamic>? scrubMap(Map<String, dynamic>? data) {
  if (data == null) {
    return null;
  }
  const sensitiveKeys = {
    'password',
    'token',
    'api_key',
    'apikey',
    'secret',
    'authorization',
  };
  return data.map((key, value) {
    if (sensitiveKeys.contains(key.toLowerCase())) {
      return MapEntry(key, '[REDACTED]');
    }
    if (value is String) {
      return MapEntry(key, scrubSensitiveData(value));
    }
    if (value is Map<String, dynamic>) {
      return MapEntry(key, scrubMap(value));
    }
    return MapEntry(key, value);
  });
}
