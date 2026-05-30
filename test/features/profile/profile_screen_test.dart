import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:shorts_ai/core/theme/app_theme.dart';
import 'package:shorts_ai/core/theme/app_typography.dart';
import 'package:shorts_ai/features/auth/models/user.dart';
import 'package:shorts_ai/features/auth/providers/auth_provider.dart';
import 'package:shorts_ai/features/profile/profile_screen.dart';
import 'package:shorts_ai/routing/app_router.dart';
import 'package:shorts_ai/routing/routes.dart';
import 'package:shorts_ai/shared/models/analytics_event.dart';
import 'package:shorts_ai/shared/models/project.dart';
import 'package:shorts_ai/shared/models/subscription.dart';
import 'package:shorts_ai/shared/models/user.dart' as shared_user;
import 'package:shorts_ai/shared/repositories/analytics_repository.dart';
import 'package:shorts_ai/shared/repositories/project_repository.dart';
import 'package:shorts_ai/shared/repositories/providers.dart';
import 'package:shorts_ai/shared/repositories/subscription_repository.dart';
import 'package:shorts_ai/shared/repositories/user_repository.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  setUpAll(() {
    AppTypography.setUseGoogleFontsForTest(false);
  });

  testWidgets('renders profile with current user, tier, and stats',
      (tester) async {
    await tester.pumpWidget(_ProfileHarness(user: _authUser()));
    await _pumpProfile(tester);

    expect(find.byKey(const Key('profile-screen')), findsOneWidget);
    expect(find.text('Devi Creator'), findsOneWidget);
    expect(find.text('devi@autoshort.id'), findsOneWidget);
    expect(find.text('Free'), findsOneWidget);
    expect(find.byKey(const Key('profile-stats-row')), findsOneWidget);
    expect(find.text('Videos Created'), findsOneWidget);
    expect(find.text('Total Views'), findsOneWidget);
    expect(find.text('Followers Gained'), findsOneWidget);

    await tester.drag(find.byType(CustomScrollView), const Offset(0, -600));
    await tester.pump();

    expect(find.byKey(const Key('profile-upgrade-banner')), findsOneWidget);
  });

  testWidgets('logout confirm dialog logs out and redirects to login',
      (tester) async {
    await tester.pumpWidget(_ProfileRouterHarness(user: _authUser()));
    await _pumpProfile(tester);

    await tester.drag(find.byType(CustomScrollView), const Offset(0, -1000));
    await tester.pump();

    await tester.tap(find.byKey(const Key('profile-logout-button')));
    await tester.pumpAndSettle();

    expect(find.text('Yakin keluar?'), findsOneWidget);

    await tester.tap(find.text('Keluar'));
    await tester.pump();
    await tester.pump(const Duration(seconds: 1));
    await tester.pump();

    expect(find.byKey(const Key('login-screen')), findsOneWidget);
  });

  testWidgets('edit profile modal save updates user repository',
      (tester) async {
    final userRepository = _FakeUserRepository();

    await tester.pumpWidget(
      _ProfileHarness(
        user: _authUser(),
        userRepository: userRepository,
      ),
    );
    await _pumpProfile(tester);

    await tester.tap(find.byKey(const Key('profile-edit-button')));
    await tester.pumpAndSettle();

    final nameField = find.descendant(
      of: find.byKey(const Key('edit-profile-name')),
      matching: find.byType(TextField),
    );
    await tester.enterText(nameField, 'Devi Premium');
    await tester.pump();

    await tester.tap(find.byKey(const Key('edit-profile-save')));
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 100));

    expect(userRepository.updatedUser?.name, 'Devi Premium');
  });
}

Future<void> _pumpProfile(WidgetTester tester) async {
  await tester.pump();
  await tester.pump(const Duration(milliseconds: 350));
}

User _authUser() {
  return User(
    id: 'user_1',
    email: 'devi@autoshort.id',
    name: 'Devi Creator',
    tier: SubscriptionTier.free,
    createdAt: DateTime(2026, 5, 31),
  );
}

class _ProfileHarness extends StatelessWidget {
  const _ProfileHarness({
    required this.user,
    this.userRepository,
  });

  final User user;
  final UserRepository? userRepository;

  @override
  Widget build(BuildContext context) {
    return ProviderScope(
      overrides: [
        authMockDelayProvider.overrideWithValue(Duration.zero),
        authProvider.overrideWith(
          (ref) => _AuthenticatedAuthNotifier(user),
        ),
        projectRepositoryProvider.overrideWithValue(_FakeProjectRepository()),
        analyticsRepositoryProvider.overrideWithValue(
          _FakeAnalyticsRepository(),
        ),
        subscriptionRepositoryProvider.overrideWithValue(
          _FakeSubscriptionRepository(),
        ),
        userRepositoryProvider.overrideWithValue(
          userRepository ?? _FakeUserRepository(),
        ),
      ],
      child: MaterialApp(
        theme: darkTheme(),
        home: const ProfileScreen(),
      ),
    );
  }
}

class _ProfileRouterHarness extends StatefulWidget {
  const _ProfileRouterHarness({required this.user});

  final User user;

  @override
  State<_ProfileRouterHarness> createState() => _ProfileRouterHarnessState();
}

class _ProfileRouterHarnessState extends State<_ProfileRouterHarness> {
  late final ValueNotifier<AuthState> _authStateListenable;
  late final GoRouter _router;

  @override
  void initState() {
    super.initState();
    _authStateListenable = ValueNotifier<AuthState>(
      Authenticated(widget.user),
    );
    _router = createAppRouter(
      initialLocation: AppRoutes.profile,
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
        authMockDelayProvider.overrideWithValue(Duration.zero),
        authProvider.overrideWith(
          (ref) => _SyncingAuthNotifier(
            _authStateListenable,
            widget.user,
            mockDelay: Duration.zero,
          ),
        ),
        projectRepositoryProvider.overrideWithValue(_FakeProjectRepository()),
        analyticsRepositoryProvider.overrideWithValue(
          _FakeAnalyticsRepository(),
        ),
        subscriptionRepositoryProvider.overrideWithValue(
          _FakeSubscriptionRepository(),
        ),
        userRepositoryProvider.overrideWithValue(_FakeUserRepository()),
      ],
      child: MaterialApp.router(
        theme: darkTheme(),
        routerConfig: _router,
      ),
    );
  }
}

class _AuthenticatedAuthNotifier extends AuthNotifier {
  _AuthenticatedAuthNotifier(User user) : super(mockDelay: Duration.zero) {
    state = Authenticated(user);
  }
}

class _SyncingAuthNotifier extends AuthNotifier {
  _SyncingAuthNotifier(
    this._authStateListenable,
    User user, {
    required super.mockDelay,
  }) {
    state = Authenticated(user);
  }

  final ValueNotifier<AuthState> _authStateListenable;

  @override
  Future<void> logout() async {
    await super.logout();
    _authStateListenable.value = state;
  }
}

class _FakeProjectRepository implements ProjectRepository {
  final _projects = [
    Project(
      id: 'project_1',
      userId: 'user_1',
      title: 'Launch Clip',
      status: ProjectStatus.published,
      createdAt: DateTime(2026, 5, 30),
      updatedAt: DateTime(2026, 5, 31),
    ),
    Project(
      id: 'project_2',
      userId: 'user_1',
      title: 'Draft Clip',
      status: ProjectStatus.draft,
      createdAt: DateTime(2026, 5, 29),
      updatedAt: DateTime(2026, 5, 30),
    ),
  ];

  @override
  Future<Project> create(Project project) async => project;

  @override
  Future<void> delete(String id) async {}

  @override
  Future<List<Project>> getAll({String? userId}) async =>
      _projects.where((project) => project.userId == userId).toList();

  @override
  Future<Project?> getById(String id) async =>
      _projects.where((project) => project.id == id).firstOrNull;

  @override
  Future<Project> update(Project project) async => project;

  @override
  Stream<List<Project>> watch({String? userId}) => Stream.value(
        _projects.where((project) => project.userId == userId).toList(),
      );
}

class _FakeAnalyticsRepository implements AnalyticsRepository {
  @override
  Future<List<AnalyticsEvent>> getEvents({String? userId}) async => [];

  @override
  Future<UserAnalyticsStats> getUserStats(String userId) async {
    return UserAnalyticsStats(
      userId: userId,
      totalEvents: 20,
      projectCreatedCount: 2,
      generationStartedCount: 4,
      lastEventAt: DateTime(2026, 5, 31),
    );
  }

  @override
  Future<void> trackEvent(AnalyticsEvent event) async {}

  @override
  Stream<List<AnalyticsEvent>> watchEvents({String? userId}) =>
      Stream.value([]);
}

class _FakeSubscriptionRepository implements SubscriptionRepository {
  @override
  Future<void> cancel(String id) async {}

  @override
  Future<Subscription> create(Subscription subscription) async => subscription;

  @override
  Future<Subscription?> getById(String id) async => null;

  @override
  Future<Subscription?> getByUserId(String userId) async => null;

  @override
  Future<Subscription> update(Subscription subscription) async => subscription;

  @override
  Stream<Subscription?> watchByUserId(String userId) => Stream.value(null);
}

class _FakeUserRepository implements UserRepository {
  shared_user.User? updatedUser;
  final _controller = StreamController<shared_user.User?>.broadcast();

  @override
  Future<shared_user.User?> getById(String id) async => updatedUser;

  @override
  Future<shared_user.User?> getProfile(String userId) async => updatedUser;

  @override
  Future<shared_user.User> updateProfile(shared_user.User user) async {
    updatedUser = user;
    _controller.add(user);
    return user;
  }

  @override
  Stream<shared_user.User?> watchProfile(String userId) => _controller.stream;
}
