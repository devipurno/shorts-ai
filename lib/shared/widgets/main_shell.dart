import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../core/error_reporter.dart';
import 'navigation/bottom_nav_bar.dart';

class MainShell extends ConsumerWidget {
  const MainShell({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final location = GoRouterState.of(context).uri.path;

    return Scaffold(
      body: child,
      bottomNavigationBar: AppBottomNavBar(
        currentPath: location,
        onDestinationSelected: (route) {
          if (route != location) {
            ref.read(errorReporterProvider).addBreadcrumb(
              message: 'Navigated to $route',
              category: 'navigation',
              data: {'from': location, 'to': route},
            );
            context.go(route);
          }
        },
      ),
    );
  }
}
