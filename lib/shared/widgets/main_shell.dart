import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'navigation/bottom_nav_bar.dart';

class MainShell extends StatelessWidget {
  const MainShell({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    final location = GoRouterState.of(context).uri.path;

    return Scaffold(
      body: child,
      bottomNavigationBar: AppBottomNavBar(
        currentPath: location,
        onDestinationSelected: (route) {
          if (route != location) {
            context.go(route);
          }
        },
      ),
    );
  }
}
