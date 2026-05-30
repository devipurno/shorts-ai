import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:shorts_ai/core/constants/app_constants.dart';
import 'package:shorts_ai/core/theme/app_colors.dart';
import 'package:shorts_ai/core/theme/app_theme.dart';
import 'package:shorts_ai/core/theme/app_typography.dart';
import 'package:shorts_ai/features/auth/providers/auth_provider.dart';
import 'package:shorts_ai/routing/app_router.dart';
import 'package:shorts_ai/routing/routes.dart';

void main() {
  setUpAll(() {
    AppTypography.setUseGoogleFontsForTest(false);
  });

  testWidgets('starts at splash screen', (tester) async {
    await tester.pumpWidget(
      _RouterHarness(
        router: createAppRouter(
          initialAuthState: Authenticated(mockAuthenticatedRouteUser()),
        ),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.byKey(const Key('placeholder-Splash')), findsOneWidget);
    expect(find.text(AppConstants.APP_NAME), findsOneWidget);
  });

  testWidgets('can navigate manually to home route', (tester) async {
    final router = createAppRouter(
      initialAuthState: Authenticated(mockAuthenticatedRouteUser()),
    );

    await tester.pumpWidget(_RouterHarness(router: router));
    await tester.pumpAndSettle();

    router.go(AppRoutes.home);
    await tester.pumpAndSettle();

    expect(find.byKey(const Key('placeholder-Home')), findsOneWidget);
    expect(find.byType(NavigationBar), findsOneWidget);
  });

  testWidgets('bottom navigation switches the 5 main tabs', (tester) async {
    final router = createAppRouter(
      initialLocation: AppRoutes.home,
      initialAuthState: Authenticated(mockAuthenticatedRouteUser()),
    );

    await tester.pumpWidget(_RouterHarness(router: router));
    await tester.pumpAndSettle();

    await tester.tap(find.text('Library').last);
    await tester.pumpAndSettle();
    expect(find.byKey(const Key('placeholder-Library')), findsOneWidget);

    await tester.tap(find.text('Create').last);
    await tester.pumpAndSettle();
    expect(find.byKey(const Key('placeholder-Create')), findsOneWidget);

    await tester.tap(find.text('Analytics').last);
    await tester.pumpAndSettle();
    expect(find.byKey(const Key('placeholder-Analytics')), findsOneWidget);

    await tester.tap(find.text('Profile').last);
    await tester.pumpAndSettle();
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

    expect(find.byKey(const Key('placeholder-Login')), findsOneWidget);
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
          child: ColoredBox(
            color: AppColors.obsidian,
            child: child ?? const SizedBox.shrink(),
          ),
        );
      },
    );
  }
}
