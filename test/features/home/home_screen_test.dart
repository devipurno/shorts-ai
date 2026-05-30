import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shorts_ai/core/theme/app_theme.dart';
import 'package:shorts_ai/core/theme/app_typography.dart';
import 'package:shorts_ai/features/auth/models/user.dart' as auth;
import 'package:shorts_ai/features/auth/providers/auth_provider.dart';
import 'package:shorts_ai/features/home/home_screen.dart';
import 'package:shorts_ai/features/home/providers/home_provider.dart';
import 'package:shorts_ai/features/home/widgets/greeting_header.dart';
import 'package:shorts_ai/routing/app_router.dart';
import 'package:shorts_ai/routing/routes.dart';
import 'package:shorts_ai/shared/models/analytics_event.dart';
import 'package:shorts_ai/shared/models/project.dart';
import 'package:shorts_ai/shared/models/template.dart';
import 'package:shorts_ai/shared/repositories/analytics_repository.dart';
import 'package:shorts_ai/shared/repositories/project_repository.dart';
import 'package:shorts_ai/shared/repositories/providers.dart';
import 'package:shorts_ai/shared/repositories/template_repository.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  setUpAll(() {
    AppTypography.setUseGoogleFontsForTest(false);
  });

  testWidgets('renders home sections with mock data', (tester) async {
    await tester.pumpWidget(
      _HomeHarness(
        projects: _projects(),
        templates: _templates(),
      ),
    );

    await _pumpHomeReady(tester);

    expect(find.byKey(const Key('home-screen')), findsOneWidget);
    expect(find.byKey(const Key('home-streak-card')), findsOneWidget);
    expect(find.text('Project Terbaru'), findsOneWidget);
    expect(find.byKey(const Key('project-card-project_1')), findsOneWidget);
    await tester.drag(find.byType(CustomScrollView), const Offset(0, -520));
    await tester.pump();

    expect(find.text('Template Spotlight'), findsOneWidget);
    expect(find.byKey(const Key('template-card-template_1')), findsOneWidget);
    await tester.drag(find.byType(CustomScrollView), const Offset(0, -900));
    await tester.pump();

    expect(find.text('Tips Hari Ini'), findsOneWidget);
  });

  testWidgets('loading state shows shimmer placeholders', (tester) async {
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          homeDataProvider.overrideWith((ref) => Completer<HomeData>().future),
        ],
        child: const MaterialApp(
          home: Scaffold(body: HomeScreen()),
        ),
      ),
    );

    await tester.pump();

    expect(find.byKey(const Key('home-loading')), findsOneWidget);
  });

  testWidgets('empty projects show empty state with CTA', (tester) async {
    await tester.pumpWidget(
      _HomeHarness(
        projects: const [],
        templates: _templates(),
      ),
    );

    await _pumpHomeReady(tester);

    expect(find.byKey(const Key('home-empty-projects')), findsOneWidget);
    expect(find.text('Belum ada project.'), findsOneWidget);
    expect(find.text('Buat shorts pertama kamu!'), findsOneWidget);
  });

  testWidgets('tap hero CTA navigates to create route', (tester) async {
    final authState = Authenticated(_user);
    final notifier = ValueNotifier<AuthState>(authState);
    final router = createAppRouter(
      initialLocation: AppRoutes.home,
      authStateListenable: notifier,
    );

    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          authProvider.overrideWith((ref) => _SeededAuthNotifier(authState)),
          projectRepositoryProvider
              .overrideWithValue(_FakeProjectRepository(_projects())),
          templateRepositoryProvider
              .overrideWithValue(_FakeTemplateRepository(_templates())),
          analyticsRepositoryProvider
              .overrideWithValue(const _FakeAnalyticsRepository()),
        ],
        child: MaterialApp.router(
          theme: darkTheme(),
          routerConfig: router,
        ),
      ),
    );

    await _pumpHomeReady(tester);
    await tester.tap(find.byKey(const Key('home-create-cta')));
    await _pumpHomeReady(tester);

    expect(find.byKey(const Key('placeholder-Create')), findsOneWidget);

    router.dispose();
    notifier.dispose();
  });

  testWidgets('project card opens mini editor route', (tester) async {
    final authState = Authenticated(_user);
    final notifier = ValueNotifier<AuthState>(authState);
    final router = createAppRouter(
      initialLocation: AppRoutes.home,
      authStateListenable: notifier,
    );

    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          authProvider.overrideWith((ref) => _SeededAuthNotifier(authState)),
          projectRepositoryProvider
              .overrideWithValue(_FakeProjectRepository(_projects())),
          templateRepositoryProvider
              .overrideWithValue(_FakeTemplateRepository(_templates())),
          analyticsRepositoryProvider
              .overrideWithValue(const _FakeAnalyticsRepository()),
        ],
        child: MaterialApp.router(
          theme: darkTheme(),
          routerConfig: router,
        ),
      ),
    );

    await _pumpHomeReady(tester);
    await tester.drag(find.byType(CustomScrollView), const Offset(0, -320));
    await tester.pump();
    await tester.tap(find.byKey(const Key('project-card-project_1')));
    await _pumpHomeReady(tester);

    expect(find.byKey(const Key('mini-editor-screen')), findsOneWidget);
    expect(find.text('Launch clip'), findsOneWidget);

    router.dispose();
    notifier.dispose();
  });

  testWidgets('greeting adapts to local hour', (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        theme: darkTheme(),
        home: Scaffold(
          body: GreetingHeader(
            name: 'Devi',
            tier: auth.SubscriptionTier.premium,
            hasUnreadNotifications: false,
            now: DateTime(2026, 5, 30, 9),
          ),
        ),
      ),
    );

    expect(find.text('Selamat pagi, Devi'), findsOneWidget);
  });
}

Future<void> _pumpHomeReady(WidgetTester tester) async {
  await tester.pump();
  await tester.pump(const Duration(seconds: 1));
}

final _user = auth.User(
  id: 'user_1',
  email: 'devi@autoshort.id',
  name: 'Devi',
  tier: auth.SubscriptionTier.premium,
  createdAt: DateTime(2026),
);

List<Project> _projects() {
  final now = DateTime(2026, 5, 30, 10);
  return [
    Project(
      id: 'project_1',
      userId: 'user_1',
      title: 'Launch clip',
      status: ProjectStatus.ready,
      thumbnailUrl: '',
      duration: 42,
      createdAt: now.subtract(const Duration(days: 1)),
      updatedAt: now,
    ),
    Project(
      id: 'project_2',
      userId: 'user_1',
      title: 'Education hook',
      status: ProjectStatus.processing,
      thumbnailUrl: '',
      duration: 31,
      createdAt: now.subtract(const Duration(days: 2)),
      updatedAt: now.subtract(const Duration(hours: 3)),
    ),
  ];
}

List<Template> _templates() {
  return const [
    Template(
      id: 'template_1',
      name: 'Podcast Gold',
      category: 'podcast',
      thumbnailUrl: '',
      tier: TemplateTier.free,
      timesUsed: 40,
    ),
    Template(
      id: 'template_2',
      name: 'Story Premium',
      category: 'story',
      thumbnailUrl: '',
      tier: TemplateTier.premium,
      timesUsed: 20,
    ),
  ];
}

class _HomeHarness extends StatelessWidget {
  const _HomeHarness({
    required this.projects,
    required this.templates,
  });

  final List<Project> projects;
  final List<Template> templates;

  @override
  Widget build(BuildContext context) {
    return ProviderScope(
      overrides: [
        authProvider
            .overrideWith((ref) => _SeededAuthNotifier(Authenticated(_user))),
        projectRepositoryProvider
            .overrideWithValue(_FakeProjectRepository(projects)),
        templateRepositoryProvider
            .overrideWithValue(_FakeTemplateRepository(templates)),
        analyticsRepositoryProvider
            .overrideWithValue(const _FakeAnalyticsRepository()),
      ],
      child: MaterialApp(
        theme: darkTheme(),
        home: const HomeScreen(),
      ),
    );
  }
}

class _SeededAuthNotifier extends AuthNotifier {
  _SeededAuthNotifier(AuthState seed) : super(mockDelay: Duration.zero) {
    state = seed;
  }
}

class _FakeProjectRepository implements ProjectRepository {
  const _FakeProjectRepository(this.projects);

  final List<Project> projects;

  @override
  Future<List<Project>> getAll({String? userId}) async {
    return projects.where((project) => project.userId == userId).toList();
  }

  @override
  Future<Project?> getById(String id) async =>
      projects.where((project) => project.id == id).firstOrNull;

  @override
  Future<Project> create(Project project) async => project;

  @override
  Future<void> delete(String id) async {}

  @override
  Future<Project> update(Project project) async => project;

  @override
  Stream<List<Project>> watch({String? userId}) {
    return Stream.value(
      projects.where((project) => project.userId == userId).toList(),
    );
  }
}

class _FakeTemplateRepository implements TemplateRepository {
  const _FakeTemplateRepository(this.templates);

  final List<Template> templates;

  @override
  Future<List<Template>> getAll() async => templates;

  @override
  Future<Template?> getById(String id) async =>
      templates.where((template) => template.id == id).firstOrNull;

  @override
  Future<List<Template>> getByCategory(String category) async {
    return templates
        .where((template) => template.category == category)
        .toList();
  }

  @override
  Stream<List<Template>> watchAll() => Stream.value(templates);
}

class _FakeAnalyticsRepository implements AnalyticsRepository {
  const _FakeAnalyticsRepository();

  @override
  Future<List<AnalyticsEvent>> getEvents({String? userId}) async => const [];

  @override
  Future<UserAnalyticsStats> getUserStats(String userId) async {
    return UserAnalyticsStats(
      userId: userId,
      totalEvents: 2,
      projectCreatedCount: 4,
      generationStartedCount: 3,
      lastEventAt: DateTime(2026, 5, 30, 9),
    );
  }

  @override
  Future<void> trackEvent(AnalyticsEvent event) async {}

  @override
  Stream<List<AnalyticsEvent>> watchEvents({String? userId}) {
    return const Stream.empty();
  }
}
