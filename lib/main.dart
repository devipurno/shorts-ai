import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'app.dart';
import 'core/constants/app_constants.dart';
import 'core/env/env.dart';
import 'core/utils/logger.dart';
import 'core/utils/provider_observer.dart';

export 'app.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Env.init();
  await AppConstants.init();
  AppLogger.i('${AppConstants.APP_NAME} bootstrapped', tag: 'Bootstrap');
  runApp(
    const ProviderScope(
      observers: [AppProviderObserver()],
      child: MyApp(),
    ),
  );
}
