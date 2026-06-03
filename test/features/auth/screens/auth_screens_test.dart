import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shorts_ai/core/theme/app_theme.dart';
import 'package:shorts_ai/core/theme/app_typography.dart';
import 'package:shorts_ai/features/auth/providers/auth_provider.dart';
import 'package:shorts_ai/features/auth/screens/forgot_password_screen.dart';
import 'package:shorts_ai/features/auth/screens/login_screen.dart';
import 'package:shorts_ai/features/auth/screens/signup_screen.dart';
import 'package:shorts_ai/features/home/providers/home_provider.dart';
import 'package:shorts_ai/routing/app_router.dart';
import 'package:shorts_ai/routing/routes.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  setUpAll(() {
    AppTypography.setUseGoogleFontsForTest(false);
  });

  setUp(() {
    SharedPreferences.setMockInitialValues({});
  });

  testWidgets('login form validates email and password fields', (tester) async {
    await tester.pumpWidget(
      const _ScreenHarness(
        child: LoginScreen(),
      ),
    );

    await tester.tap(find.byKey(const Key('login-submit')));
    await tester.pump();

    expect(find.text('Masukkan email yang valid.'), findsOneWidget);
    expect(find.text('Password minimal 8 karakter.'), findsOneWidget);
  });

  testWidgets('signup form validates email, password length, and match',
      (tester) async {
    await tester.pumpWidget(
      const _ScreenHarness(
        child: SignupScreen(),
      ),
    );

    await _enterTextByKey(tester, const Key('signup-name'), 'Devi');
    await _enterTextByKey(tester, const Key('signup-email'), 'bad-email');
    await _enterTextByKey(tester, const Key('signup-password'), 'short');
    await _enterTextByKey(
      tester,
      const Key('signup-confirm-password'),
      'different',
    );
    await tester.tap(find.byKey(const Key('signup-terms')));
    await tester.pump();

    expect(
        find.byKey(const Key('password-strength-indicator')), findsOneWidget);
    expect(find.text('Daftar Sekarang'), findsOneWidget);
    expect(find.text('Masukkan email yang valid.'), findsOneWidget);
    expect(find.text('Password minimal 8 karakter.'), findsOneWidget);
    expect(find.text('Password tidak sama.'), findsOneWidget);
  });

  testWidgets('forgot password validates email format', (tester) async {
    await tester.pumpWidget(
      const _ScreenHarness(
        child: ForgotPasswordScreen(),
      ),
    );

    await _enterTextByKey(tester, const Key('forgot-email'), 'bad-email');
    await tester.tap(find.byKey(const Key('forgot-submit')));
    await tester.pump();

    expect(find.text('Masukkan email yang valid.'), findsOneWidget);
  });

  testWidgets('login submit shows loading state while auth is pending',
      (tester) async {
    await tester.pumpWidget(
      const _RouterHarness(
        initialLocation: AppRoutes.login,
        authDelay: Duration(seconds: 1),
      ),
    );

    await _enterTextByKey(tester, const Key('login-email'), 'devi@test.id');
    await _enterTextByKey(tester, const Key('login-password'), 'secret123');
    await _tapVisible(tester, find.text('Masuk').last);
    await tester.pump();

    expect(find.byType(CircularProgressIndicator), findsOneWidget);

    await tester.pump(const Duration(seconds: 1));
    await tester.pump();
  });

  testWidgets('AuthError state shows red snackbar on login failure',
      (tester) async {
    await tester.pumpWidget(
      const _RouterHarness(initialLocation: AppRoutes.login),
    );

    await _enterTextByKey(tester, const Key('login-email'), 'fail@test.id');
    await _enterTextByKey(tester, const Key('login-password'), 'secret123');
    await _tapVisible(tester, find.text('Masuk').last);
    await tester.pumpAndSettle();

    expect(find.text('Invalid mock credentials.'), findsOneWidget);
    expect(find.byKey(const Key('auth-error-snackbar')), findsOneWidget);
  });

  testWidgets('login success navigates to home', (tester) async {
    await tester.pumpWidget(
      const _RouterHarness(initialLocation: AppRoutes.login),
    );

    await _enterTextByKey(tester, const Key('login-email'), 'devi@test.id');
    await _enterTextByKey(tester, const Key('login-password'), 'secret123');
    await _tapVisible(tester, find.text('Masuk').last);
    await tester.pump();
    await tester.pump();
    await tester.pump(const Duration(seconds: 1));
    await tester.pump();

    expect(find.byKey(const Key('home-screen')), findsOneWidget);
  });

  testWidgets('navigation flow login to signup and forgot password reset link',
      (tester) async {
    await tester.pumpWidget(
      const _RouterHarness(initialLocation: AppRoutes.login),
    );

    expect(find.byKey(const Key('login-screen')), findsOneWidget);

    await _tapVisible(tester, find.byKey(const Key('login-signup-link')));
    await tester.pumpAndSettle();
    expect(find.byKey(const Key('signup-screen')), findsOneWidget);

    await _tapVisible(tester, find.byKey(const Key('signup-login-link')));
    await tester.pumpAndSettle();
    expect(find.byKey(const Key('login-screen')), findsOneWidget);

    await _tapVisible(tester, find.byKey(const Key('login-forgot-link')));
    await tester.pumpAndSettle();
    expect(find.byKey(const Key('forgot-password-screen')), findsOneWidget);

    await _enterTextByKey(
      tester,
      const Key('forgot-email'),
      'creator@autoshort.id',
    );
    await _tapVisible(tester, find.byKey(const Key('forgot-submit')));
    await tester.pump();
    await tester.pumpAndSettle();

    expect(find.byKey(const Key('forgot-password-screen')), findsOneWidget);
    expect(
      find.text('Link reset terkirim. Cek inbox + spam folder.'),
      findsOneWidget,
    );
  });
}

Future<void> _tapVisible(WidgetTester tester, Finder finder) async {
  await tester.ensureVisible(finder);
  await tester.pump();
  await tester.tap(finder);
}

Future<void> _enterTextByKey(
  WidgetTester tester,
  Key key,
  String value,
) async {
  final field = find.descendant(
    of: find.byKey(key),
    matching: find.byType(TextField),
  );
  await tester.ensureVisible(field);
  await tester.enterText(field, value);
  await tester.pump();
}

class _ScreenHarness extends StatelessWidget {
  const _ScreenHarness({required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return ProviderScope(
      overrides: [
        authMockDelayProvider.overrideWithValue(Duration.zero),
      ],
      child: MaterialApp(
        theme: darkTheme(),
        home: child,
      ),
    );
  }
}

class _RouterHarness extends StatefulWidget {
  const _RouterHarness({
    required this.initialLocation,
    this.authDelay = Duration.zero,
  });

  final String initialLocation;
  final Duration authDelay;

  @override
  State<_RouterHarness> createState() => _RouterHarnessState();
}

class _RouterHarnessState extends State<_RouterHarness> {
  late final ValueNotifier<AuthState> _authStateListenable;
  late final GoRouter _router;

  @override
  void initState() {
    super.initState();
    _authStateListenable = ValueNotifier<AuthState>(const Unauthenticated());
    _router = createAppRouter(
      initialLocation: widget.initialLocation,
      authStateListenable: _authStateListenable,
    );
  }

  @override
  void dispose() {
    _router.dispose();
    _authStateListenable.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ProviderScope(
      overrides: [
        authMockDelayProvider.overrideWithValue(widget.authDelay),
        homeDataProvider.overrideWith((ref) async => _emptyHomeData),
        authProvider.overrideWith(
          (ref) => _SyncingAuthNotifier(
            _authStateListenable,
            mockDelay: widget.authDelay,
          ),
        ),
      ],
      child: MaterialApp.router(
        theme: darkTheme(),
        routerConfig: _router,
      ),
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

class _SyncingAuthNotifier extends AuthNotifier {
  _SyncingAuthNotifier(
    this._authStateListenable, {
    required super.mockDelay,
  });

  final ValueNotifier<AuthState> _authStateListenable;

  @override
  Future<void> login(String email, String password) async {
    await super.login(email, password);
    _authStateListenable.value = state;
  }

  @override
  Future<void> signup(String email, String password, String name) async {
    await super.signup(email, password, name);
    _authStateListenable.value = state;
  }

  @override
  Future<void> verifyOtp(
    String code, {
    String? email,
    OtpPurpose purpose = OtpPurpose.forgotPassword,
  }) async {
    await super.verifyOtp(code, email: email, purpose: purpose);
    _authStateListenable.value = state;
  }

  @override
  Future<void> logout() async {
    await super.logout();
    _authStateListenable.value = state;
  }
}
