import 'package:go_router/go_router.dart';

import '../shared/widgets/main_shell.dart';
import '../shared/widgets/placeholder_screen.dart';
import 'routes.dart';

final GoRouter appRouter = createAppRouter();

GoRouter createAppRouter({
  String initialLocation = AppRoutes.splash,
  bool isAuthenticated = true,
}) {
  return GoRouter(
    initialLocation: initialLocation,
    redirect: (context, state) => _authRedirect(
      state,
      isAuthenticated: isAuthenticated,
    ),
    errorBuilder: (context, state) => ErrorScreen(error: state.error),
    routes: [
      GoRoute(
        path: AppRoutes.splash,
        builder: (context, state) => const PlaceholderScreen(name: 'Splash'),
      ),
      GoRoute(
        path: AppRoutes.onboarding,
        builder: (context, state) =>
            const PlaceholderScreen(name: 'Onboarding'),
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
    ],
  );
}

String? _authRedirect(
  GoRouterState state, {
  required bool isAuthenticated,
}) {
  final path = state.uri.path;
  if (!isAuthenticated && !AppRoutes.isPublicPath(path)) {
    return AppRoutes.login;
  }
  return null;
}
