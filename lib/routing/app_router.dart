import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../features/auth/models/user.dart';
import '../features/auth/providers/auth_provider.dart';
import '../features/onboarding/onboarding_screen.dart';
import '../features/splash/splash_screen.dart';
import '../shared/widgets/_dev/component_gallery.dart';
import '../shared/widgets/main_shell.dart';
import '../shared/widgets/placeholder_screen.dart';
import 'routes.dart';

final appRouterProvider = Provider<GoRouter>((ref) {
  final authRefreshListenable = AuthRouterRefreshListenable(ref);
  final router = createAppRouter(authStateListenable: authRefreshListenable);

  ref
    ..onDispose(authRefreshListenable.dispose)
    ..onDispose(router.dispose);

  return router;
});

GoRouter createAppRouter({
  String initialLocation = AppRoutes.splash,
  AuthState initialAuthState = const Unauthenticated(),
  ValueListenable<AuthState>? authStateListenable,
}) {
  return GoRouter(
    initialLocation: initialLocation,
    refreshListenable: authStateListenable,
    redirect: (context, state) => _authRedirect(
      state,
      authState: authStateListenable?.value ?? initialAuthState,
    ),
    errorBuilder: (context, state) => ErrorScreen(error: state.error),
    routes: [
      GoRoute(
        path: AppRoutes.splash,
        builder: (context, state) => const SplashScreen(),
      ),
      GoRoute(
        path: AppRoutes.onboarding,
        builder: (context, state) => const OnboardingScreen(),
      ),
      GoRoute(
        path: AppRoutes.login,
        builder: (context, state) => const PlaceholderScreen(name: 'Login'),
      ),
      GoRoute(
        path: AppRoutes.signup,
        builder: (context, state) => const PlaceholderScreen(name: 'Signup'),
      ),
      GoRoute(
        path: AppRoutes.forgotPassword,
        builder: (context, state) =>
            const PlaceholderScreen(name: 'Forgot Password'),
      ),
      GoRoute(
        path: AppRoutes.otpVerify,
        builder: (context, state) =>
            const PlaceholderScreen(name: 'OTP Verify'),
      ),
      ShellRoute(
        builder: (context, state, child) => MainShell(child: child),
        routes: [
          GoRoute(
            path: AppRoutes.home,
            builder: (context, state) => const PlaceholderScreen(name: 'Home'),
          ),
          GoRoute(
            path: AppRoutes.library,
            builder: (context, state) =>
                const PlaceholderScreen(name: 'Library'),
          ),
          GoRoute(
            path: AppRoutes.create,
            builder: (context, state) =>
                const PlaceholderScreen(name: 'Create'),
          ),
          GoRoute(
            path: AppRoutes.analytics,
            builder: (context, state) =>
                const PlaceholderScreen(name: 'Analytics'),
          ),
          GoRoute(
            path: AppRoutes.profile,
            builder: (context, state) =>
                const PlaceholderScreen(name: 'Profile'),
          ),
        ],
      ),
      GoRoute(
        path: AppRoutes.subtitleStudio,
        builder: (context, state) => PlaceholderScreen(
          name: 'Subtitle Studio',
          detail: 'videoId: ${state.pathParameters['videoId']}',
        ),
      ),
      GoRoute(
        path: AppRoutes.thumbnailEditor,
        builder: (context, state) => PlaceholderScreen(
          name: 'Thumbnail Editor',
          detail: 'videoId: ${state.pathParameters['videoId']}',
        ),
      ),
      GoRoute(
        path: AppRoutes.miniEditor,
        builder: (context, state) => PlaceholderScreen(
          name: 'Mini Editor',
          detail: 'videoId: ${state.pathParameters['videoId']}',
        ),
      ),
      GoRoute(
        path: AppRoutes.templateDetail,
        builder: (context, state) => PlaceholderScreen(
          name: 'Template Detail',
          detail: 'templateId: ${state.pathParameters['templateId']}',
        ),
      ),
      GoRoute(
        path: AppRoutes.templateLibrary,
        builder: (context, state) =>
            const PlaceholderScreen(name: 'Template Library'),
      ),
      GoRoute(
        path: AppRoutes.hookGenerator,
        builder: (context, state) =>
            const PlaceholderScreen(name: 'Hook Generator'),
      ),
      GoRoute(
        path: AppRoutes.brandKit,
        builder: (context, state) => const PlaceholderScreen(name: 'Brand Kit'),
      ),
      GoRoute(
        path: AppRoutes.contentCalendar,
        builder: (context, state) =>
            const PlaceholderScreen(name: 'Content Calendar'),
      ),
      GoRoute(
        path: AppRoutes.pricing,
        builder: (context, state) => const PlaceholderScreen(name: 'Pricing'),
      ),
      GoRoute(
        path: AppRoutes.checkout,
        builder: (context, state) => const PlaceholderScreen(name: 'Checkout'),
      ),
      GoRoute(
        path: AppRoutes.referral,
        builder: (context, state) => const PlaceholderScreen(name: 'Referral'),
      ),
      GoRoute(
        path: AppRoutes.settings,
        builder: (context, state) => const PlaceholderScreen(name: 'Settings'),
      ),
      GoRoute(
        path: AppRoutes.accountSettings,
        builder: (context, state) =>
            const PlaceholderScreen(name: 'Account Settings'),
      ),
      GoRoute(
        path: AppRoutes.notificationSettings,
        builder: (context, state) =>
            const PlaceholderScreen(name: 'Notification Settings'),
      ),
      GoRoute(
        path: AppRoutes.privacySettings,
        builder: (context, state) =>
            const PlaceholderScreen(name: 'Privacy Settings'),
      ),
      GoRoute(
        path: AppRoutes.about,
        builder: (context, state) => const PlaceholderScreen(name: 'About'),
      ),
      if (kDebugMode)
        GoRoute(
          path: AppRoutes.devComponents,
          builder: (context, state) => const ComponentGallery(),
        ),
    ],
  );
}

String? _authRedirect(
  GoRouterState state, {
  required AuthState authState,
}) {
  final path = state.uri.path;
  final isAuthEntryRoute = AppRoutes.authEntryRoutes.contains(path);

  if (kDebugMode && path == AppRoutes.devComponents) {
    return null;
  }

  if (path == AppRoutes.splash) {
    return null;
  }

  if (authState is! Authenticated && !isAuthEntryRoute) {
    return AppRoutes.login;
  }

  if (authState is Authenticated &&
      (path == AppRoutes.login || path == AppRoutes.signup)) {
    return AppRoutes.home;
  }

  return null;
}

final class AuthRouterRefreshListenable extends ChangeNotifier
    implements ValueListenable<AuthState> {
  AuthRouterRefreshListenable(Ref ref) : _state = ref.read(authProvider) {
    _subscription = ref.listen<AuthState>(
      authProvider,
      (previous, next) {
        _state = next;
        notifyListeners();
      },
    );
  }

  late final ProviderSubscription<AuthState> _subscription;
  AuthState _state;

  @override
  AuthState get value => _state;

  @override
  void dispose() {
    _subscription.close();
    super.dispose();
  }
}

User mockAuthenticatedRouteUser() {
  return User(
    id: 'mock-route-user',
    email: 'creator@autoshort.local',
    name: 'AutoShort Creator',
    tier: SubscriptionTier.free,
    createdAt: DateTime(2026),
  );
}
