import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'logger.dart';

final class AppProviderObserver extends ProviderObserver {
  const AppProviderObserver();

  @override
  void didAddProvider(ProviderObserverContext context, Object? value) {
    if (!kDebugMode) return;
    AppLogger.d(
      'initialized with $value',
      tag: _providerName(context),
    );
  }

  @override
  void didUpdateProvider(
    ProviderObserverContext context,
    Object? previousValue,
    Object? newValue,
  ) {
    if (!kDebugMode) return;
    AppLogger.d(
      '$previousValue -> $newValue',
      tag: _providerName(context),
    );
  }

  @override
  void providerDidFail(
    ProviderObserverContext context,
    Object error,
    StackTrace stackTrace,
  ) {
    if (!kDebugMode) return;
    AppLogger.e(
      'provider failed',
      tag: _providerName(context),
      error: error,
      stackTrace: stackTrace,
    );
  }

  @override
  void didDisposeProvider(ProviderObserverContext context) {
    if (!kDebugMode) return;
    AppLogger.d(
      'disposed',
      tag: _providerName(context),
    );
  }

  String _providerName(ProviderObserverContext context) {
    return context.provider.name ?? context.provider.toString();
  }
}
