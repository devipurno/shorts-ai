import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../features/auth/models/user.dart';
import '../features/auth/providers/auth_provider.dart';
import '../features/auth/screens/forgot_password_screen.dart';
import '../features/auth/screens/login_screen.dart';
import '../features/auth/screens/otp_verify_screen.dart';
import '../features/auth/screens/reset_password_screen.dart';
import '../features/auth/screens/signup_screen.dart';
import '../features/brand_kit/brand_kit_screen.dart';
import '../features/calendar/content_calendar_screen.dart';
import '../features/editor/mini_editor_screen.dart';
import '../features/hook_generator/hook_generator_screen.dart';
import '../features/home/home_screen.dart';
import '../features/library/library_screen.dart';
import '../features/onboarding/onboarding_screen.dart';
import '../features/profile/profile_screen.dart';
import '../features/splash/splash_screen.dart';
import '../features/subtitle/subtitle_studio_screen.dart';
import '../features/templates/template_detail_screen.dart';
import '../features/templates/template_library_screen.dart';
import '../features/thumbnail/thumbnail_editor_screen.dart';
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
        builder: (context, state) => const LoginScreen(),
      ),
      GoRoute(
        path: AppRoutes.signup,
        builder: (context, state) => const SignupScreen(),
      ),
      GoRoute(
        path: AppRoutes.forgotPassword,
        builder: (context, state) => const ForgotPasswordScreen(),
      ),
      GoRoute(
        path: AppRoutes.otpVerify,
        builder: (context, state) => OtpVerifyScreen(
          email: state.uri.queryParameters['email'] ?? '',
          flow: state.uri.queryParameters['flow'] ?? 'forgot-password',
        ),
      ),
      GoRoute(
        path: AppRoutes.resetPassword,
        builder: (context, state) => ResetPasswordScreen(
          email: state.uri.queryParameters['email'] ?? '',
        ),
      ),
      ShellRoute(
        builder: (context, state, child) => MainShell(child: child),
        routes: [
          GoRoute(
            path: AppRoutes.home,
            builder: (context, state) => const HomeScreen(),
          ),
          GoRoute(
            path: AppRoutes.library,
            builder: (context, state) => const LibraryScreen(),
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
            builder: (context, state) => const ProfileScreen(),
          ),
        ],
      ),
      GoRoute(
        path: AppRoutes.subtitleStudio,
        builder: (context, state) => SubtitleStudioScreen(
          videoId: state.pathParameters['videoId'] ?? '',
        ),
      ),
      GoRoute(
        path: AppRoutes.thumbnailEditor,
        builder: (context, state) => ThumbnailEditorScreen(
          videoId: state.pathParameters['videoId'] ?? '',
        ),
      ),
      GoRoute(
        path: AppRoutes.miniEditor,
        builder: (context, state) => MiniEditorScreen(
          videoId: state.pathParameters['videoId'] ?? '',
        ),
      ),
      GoRoute(
        path: AppRoutes.templateDetail,
        builder: (context, state) => TemplateDetailScreen(
          templateId: state.pathParameters['templateId'] ?? '',
        ),
      ),
      GoRoute(
        path: AppRoutes.templateLibrary,
        builder: (context, state) => const TemplateLibraryScreen(),
      ),
      GoRoute(
        path: AppRoutes.hookGenerator,
        builder: (context, state) => const HookGeneratorScreen(),
      ),
      GoRoute(
        path: AppRoutes.brandKit,
        builder: (context, state) => const BrandKitScreen(),
      ),
      GoRoute(
        path: AppRoutes.contentCalendar,
        builder: (context, state) => const ContentCalendarScreen(),
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
      GoRoute(
        path: AppRoutes.help,
        builder: (context, state) =>
            const PlaceholderScreen(name: 'Help & Support'),
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
