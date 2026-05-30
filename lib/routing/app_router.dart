import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'routes.dart';

final GoRouter appRouter = GoRouter(
  initialLocation: AppRoutes.splash,
  routes: [
    GoRoute(
      path: AppRoutes.splash,
      builder: (context, state) => const _RoutePlaceholder(name: 'Splash'),
    ),
    GoRoute(
      path: AppRoutes.onboarding,
      builder: (context, state) => const _RoutePlaceholder(name: 'Onboarding'),
    ),
    GoRoute(
      path: AppRoutes.login,
      builder: (context, state) => const _RoutePlaceholder(name: 'Login'),
    ),
    GoRoute(
      path: AppRoutes.home,
      builder: (context, state) => const _RoutePlaceholder(name: 'Home'),
    ),
  ],
);

class _RoutePlaceholder extends StatelessWidget {
  const _RoutePlaceholder({required this.name});

  final String name;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Text(name)),
    );
  }
}
