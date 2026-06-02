import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'app.dart';
import 'core/sentry_config.dart';
import 'core/utils/provider_observer.dart';

export 'app.dart';

Future<void> main() async {
  await initSentry(
    appBuilder: () => const ProviderScope(
      observers: [AppProviderObserver()],
      child: MyApp(),
    ),
  );
}
