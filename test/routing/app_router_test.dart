import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shorts_ai/core/constants/app_constants.dart';
import 'package:shorts_ai/core/theme/app_colors.dart';
import 'package:shorts_ai/core/theme/app_theme.dart';
import 'package:shorts_ai/core/theme/app_typography.dart';
import 'package:shorts_ai/features/auth/providers/auth_provider.dart';
import 'package:shorts_ai/features/home/providers/home_provider.dart';
import 'package:shorts_ai/features/library/providers/library_provider.dart';
import 'package:shorts_ai/features/onboarding/providers/onboarding_provider.dart';
import 'package:shorts_ai/features/splash/splash_screen.dart';
import 'package:shorts_ai/routing/app_router.dart';
import 'package:shorts_ai/routing/routes.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  setUpAll(() {
    AppTypography.setUseGoogleFontsForTest(false);
  });

  setUp(() {
    SharedPreferences.setMockInitialValues({
      hasCompletedOnboardingKey: true,
    });
  });

  testWidgets('starts at splash screen', (tester) async {
    await tester.pumpWidget(
      _RouterHarness(
        router: createAppRouter(
          initialAuthState: Authenticated(mockAuthenticatedRouteUser()),
        ),
      ),
    );
    await tester.pump();

    expect(find.byType(SplashScreen), findsOneWidget);
    expect(find.byKey(const Key('splash-screen')), findsOneWidget);

    await tester.pump(const Duration(seconds: 3));
    await tester.pump();
  });

  testWidgets('can navigate manually to home route', (tester) async {
    final router = createAppRouter(
      initialLocation: AppRoutes.home,
      initialAuthState: Authenticated(mockAuthenticatedRouteUser()),
    );

    await tester.pumpWidget(_RouterHarness(router: router));
    await _pumpRoute(tester);

    router.go(AppRoutes.home);
    await _pumpRoute(tester);

    expect(find.byKey(const Key('home-screen')), findsOneWidget);
    expect(find.byType(NavigationBar), findsOneWidget);
  });

  testWidgets('bottom navigation switches the 5 main tabs', (tester) async {
    final router = createAppRouter(
      initialLocation: AppRoutes.home,
      initialAuthState: Authenticated(mockAuthenticatedRouteUser()),
    );

    await tester.pumpWidget(_RouterHarness(router: router));
    await _pumpRoute(tester);

    await tester.tap(find.text('Library').last);
    await _pumpRoute(tester);
    expect(find.byKey(const Key('library-screen')), findsOneWidget);

    await tester.tap(find.text('Create').last);
    await _pumpRoute(tester);
    expect(find.byKey(const Key('placeholder-Create')), findsOneWidget);

    await tester.tap(find.text('Analytics').last);
    await _pumpRoute(tester);
    expect(find.byKey(const Key('placeholder-Analytics')), findsOneWidget);

    await tester.tap(find.text('Profile').last);
    await _pumpRoute(tester);
    expect(find.byKey(const Key('placeholder-Profile')), findsOneWidget);
  });

  testWidgets('dynamic routes render placeholder details', (tester) async {
    final router = createAppRouter(
      initialLocation: AppRoutes.subtitleStudioPath('video-42'),
      initialAuthState: Authenticated(mockAuthenticatedRouteUser()),
    );

    await tester.pumpWidget(_RouterHarness(router: router));
    await tester.pumpAndSettle();

    expect(
        find.byKey(const Key('placeholder-Subtitle Studio')), findsOneWidget);
    expect(find.text('videoId: video-42'), findsOneWidget);
  });

  testWidgets('protected route redirects to login when auth is false', (
    tester,
  ) async {
    final router = createAppRouter(
      initialLocation: AppRoutes.home,
    );

    await tester.pumpWidget(_RouterHarness(router: router));
    await tester.pumpAndSettle();

    expect(find.byKey(const Key('login-screen')), findsOneWidget);
  });

  testWidgets('unknown path renders error screen', (tester) async {
    final router = createAppRouter(
      initialLocation: '/missing',
      initialAuthState: Authenticated(mockAuthenticatedRouteUser()),
    );

    await tester.pumpWidget(_RouterHarness(router: router));
    await tester.pumpAndSettle();

    expect(find.byKey(const Key('placeholder-Error')), findsOneWidget);
  });
}

Future<void> _pumpRoute(WidgetTester tester) async {
  await tester.pump();
  await tester.pump(const Duration(seconds: 1));
}

class _RouterHarness extends StatelessWidget {
  const _RouterHarness({required this.router});

  final GoRouter router;

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: AppConstants.APP_NAME,
      locale: const Locale('id', 'ID'),
      theme: darkTheme(),
      themeMode: ThemeMode.dark,
      routerConfig: router,
      builder: (context, child) {
        return ProviderScope(
          overrides: [
            homeDataProvider.overrideWith((ref) async => _emptyHomeData),
            libraryDataProvider.overrideWith((ref) async => _emptyLibraryData),
          ],
          child: ColoredBox(
            color: AppColors.obsidian,
            child: child ?? const SizedBox.shrink(),
          ),
        );
      },
    );
  }
}

const _emptyHomeData = HomeData(
  recentProjects: [],
  spotlightTemplates: [],
  streakCount: 1,
  tipOfTheDay: 'Test tip',
  hasUnreadNotifications: false,
);

const _emptyLibraryData = LibraryData(
  projects: [],
  totalCount: 0,
  draftCount: 0,
  processingCount: 0,
  readyCount: 0,
  publishedCount: 0,
);
