import 'package:flutter/material.dart';

import 'app.dart';
import 'core/constants/app_constants.dart';
import 'core/env/env.dart';
import 'core/utils/logger.dart';

export 'app.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Env.init();
  await AppConstants.init();
  AppLogger.i('${AppConstants.APP_NAME} bootstrapped', tag: 'Bootstrap');
  runApp(const MyApp());
}
