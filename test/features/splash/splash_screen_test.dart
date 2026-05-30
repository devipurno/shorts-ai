import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shorts_ai/core/constants/asset_paths.dart';
import 'package:shorts_ai/core/theme/app_theme.dart';
import 'package:shorts_ai/core/theme/app_typography.dart';
import 'package:shorts_ai/features/auth/models/user.dart';
import 'package:shorts_ai/features/auth/providers/auth_provider.dart';
import 'package:shorts_ai/features/splash/splash_screen.dart';
import 'package:shorts_ai/routing/app_router.dart';

void main() {
  setUpAll(() {
    AppTypography.setUseGoogleFontsForTest(false);
  });

  testWidgets('shows brand splash content before navigation', (tester) async {
    await tester.pumpWidget(
      const _SplashHarness(
        authState: Unauthenticated(),
      ),
    );
    await tester.pump();

    expect(find.byType(SplashScreen), findsOneWidget);
    expect(find.byKey(const Key('splash-screen')), findsOneWidget);
    expect(find.text('Preparing your studio'), findsOneWidget);

    await tester.pump(const Duration(seconds: 3));
    await tester.pumpAndSettle();
  });

  testWidgets('navigates unauthenticated users to onboarding', (tester) async {
    await tester.pumpWidget(
      const _SplashHarness(
        authState: Unauthenticated(),
      ),
    );
    await tester.pump(const Duration(seconds: 3));
    await tester.pumpAndSettle();

    expect(find.byKey(const Key('placeholder-Onboarding')), findsOneWidget);
  });

  testWidgets('navigates authenticated users to home', (tester) async {
    await tester.pumpWidget(
      _SplashHarness(
        authState: Authenticated(_user),
      ),
    );
    await tester.pump(const Duration(seconds: 3));
    await tester.pumpAndSettle();

    expect(find.byKey(const Key('placeholder-Home')), findsOneWidget);
  });

  test('splash animation asset path is wired', () {
    expect(AssetPaths.splashLoader, endsWith('splash_loader.json'));
  });
}

final _user = User(
  id: 'splash-user',
  email: 'creator@autoshort.local',
  name: 'Creator',
  tier: SubscriptionTier.free,
  createdAt: DateTime(2026),
);

class _SplashHarness extends StatelessWidget {
  const _SplashHarness({required this.authState});

  final AuthState authState;

  @override
  Widget build(BuildContext context) {
    final router = createAppRouter(initialAuthState: authState);

    return ProviderScope(
      overrides: [
        authProvider.overrideWith(
          (ref) => _SeededAuthNotifier(authState),
        ),
      ],
      child: MaterialApp.router(
        theme: darkTheme(),
        routerConfig: router,
      ),
    );
  }
}

class _SeededAuthNotifier extends AuthNotifier {
  _SeededAuthNotifier(AuthState seed) : super(mockDelay: Duration.zero) {
    state = seed;
  }
}
