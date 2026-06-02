import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sentry_flutter/sentry_flutter.dart';

import '../../core/error_reporter.dart';

mixin SentryBreadcrumbMixin<T extends ConsumerStatefulWidget>
    on ConsumerState<T> {
  void addSentryBreadcrumb({
    required String message,
    String? category,
    SentryLevel level = SentryLevel.info,
    Map<String, dynamic>? data,
  }) {
    ref.read(errorReporterProvider).addBreadcrumb(
          message: message,
          category: category,
          level: level,
          data: data,
        );
  }
}
