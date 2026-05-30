import 'package:flutter/material.dart';

import 'core/constants/app_constants.dart';
import 'core/theme/app_theme.dart';
import 'routing/app_router.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: AppConstants.APP_NAME,
      locale: const Locale('id', 'ID'),
      theme: darkTheme(),
      themeMode: ThemeMode.dark,
      routerConfig: appRouter,
    );
  }
}
