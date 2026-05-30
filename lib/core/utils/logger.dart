import 'package:flutter/foundation.dart';
import 'package:logger/logger.dart';

class AppLogger {
  AppLogger._();

  static final Logger _logger = Logger(
    printer: _AutoShortLogPrinter(),
    level: Level.debug,
  );

  static void d(
    Object? message, {
    String tag = 'APP',
    Object? error,
    StackTrace? stackTrace,
  }) {
    if (kReleaseMode) return;
    _logger.d(_LogPayload(tag, message), error: error, stackTrace: stackTrace);
  }

  static void i(
    Object? message, {
    String tag = 'APP',
    Object? error,
    StackTrace? stackTrace,
  }) {
    if (kReleaseMode) return;
    _logger.i(_LogPayload(tag, message), error: error, stackTrace: stackTrace);
  }

  static void w(
    Object? message, {
    String tag = 'APP',
    Object? error,
    StackTrace? stackTrace,
  }) {
    if (kReleaseMode) return;
    _logger.w(_LogPayload(tag, message), error: error, stackTrace: stackTrace);
  }

  static void e(
    Object? message, {
    String tag = 'APP',
    Object? error,
    StackTrace? stackTrace,
  }) {
    if (kReleaseMode) return;
    _logger.e(_LogPayload(tag, message), error: error, stackTrace: stackTrace);
  }
}

class _AutoShortLogPrinter extends LogPrinter {
  @override
  List<String> log(LogEvent event) {
    final payload = event.message;
    final tag = payload is _LogPayload ? payload.tag : 'APP';
    final message = payload is _LogPayload ? payload.message : payload;
    final timestamp = DateTime.now().toIso8601String();
    final level = event.level.name.toUpperCase();
    final error = event.error == null ? '' : ' | error=${event.error}';

    return ['[$timestamp] [$level] [$tag] $message$error'];
  }
}

class _LogPayload {
  const _LogPayload(this.tag, this.message);

  final String tag;
  final Object? message;
}
