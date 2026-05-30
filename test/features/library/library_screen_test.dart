import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shorts_ai/core/theme/app_theme.dart';
import 'package:shorts_ai/core/theme/app_typography.dart';
import 'package:shorts_ai/features/auth/providers/auth_provider.dart';
import 'package:shorts_ai/features/library/library_screen.dart';
import 'package:shorts_ai/features/library/providers/library_provider.dart';
import 'package:shorts_ai/routing/app_router.dart';
import 'package:shorts_ai/routing/routes.dart';
import 'package:shorts_ai/shared/models/project.dart';
import 'package:shorts_ai/shared/repositories/project_repository.dart';
import 'package:shorts_ai/shared/repositories/providers.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  setUpAll(() {
    AppTypography.setUseGoogleFontsForTest(false);
  });

  testWidgets('renders library summary and project list', (tester) async {
    await tester.pumpWidget(_LibraryHarness(projects: _projects()));
    await _pumpLibraryReady(tester);

    expect(find.byKey(const Key('library-screen')), findsOneWidget);
    expect(find.byKey(const Key('library-summary-card')), findsOneWidget);
    expect(find.byKey(const Key('library-project-card-project_1')),
        findsOneWidget);
    expect(find.text('Launch Clip'), findsOneWidget);
  });

  testWidgets('search filters projects by title', (tester) async {
    await tester.pumpWidget(_LibraryHarness(projects: _projects()));
    await _pumpLibraryReady(tester);

    final searchField = find.descendant(
      of: find.byKey(const Key('library-search')),
      matching: find.byType(TextField),
    );

    await tester.enterText(searchField, 'Finance');
    await _pumpLibraryReady(tester);

    expect(find.text('Finance Hook'), findsOneWidget);
    expect(find.text('Launch Clip'), findsNothing);
  });

  testWidgets('status filter shows matching projects', (tester) async {
    await tester.pumpWidget(_LibraryHarness(projects: _projects()));
    await _pumpLibraryReady(tester);

    await tester.tap(find.byKey(const Key('library-filter-ready')));
    await _pumpLibraryReady(tester);

    expect(find.text('Launch Clip'), findsOneWidget);
    expect(find.text('Finance Hook'), findsNothing);
  });

  testWidgets('empty data shows empty state', (tester) async {
    await tester.pumpWidget(const _LibraryHarness(projects: []));
    await _pumpLibraryReady(tester);

    expect(find.text('Belum ada project.'), findsOneWidget);
    expect(find.text('Buat Shorts Baru'), findsOneWidget);
  });

  testWidgets('loading state shows shimmer placeholders', (tester) async {
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          libraryDataProvider
              .overrideWith((ref) => Completer<LibraryData>().future),
        ],
        child: MaterialApp(
          theme: darkTheme(),
          home: const LibraryScreen(),
        ),
      ),
    );

    await tester.pump();

    expect(find.byKey(const Key('library-loading')), findsOneWidget);
  });

  testWidgets('project card opens mini editor route', (tester) async {
    final router = createAppRouter(
      initialLocation: AppRoutes.library,
      initialAuthState: Authenticated(mockAuthenticatedRouteUser()),
    );

    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          projectRepositoryProvider
              .overrideWithValue(_FakeProjectRepository(_projects())),
        ],
        child: MaterialApp.router(
          theme: darkTheme(),
          routerConfig: router,
        ),
      ),
    );
    await _pumpLibraryReady(tester);

    await tester.tap(find.byKey(const Key('library-project-card-project_1')));
    await _pumpLibraryReady(tester);

    expect(find.byKey(const Key('placeholder-Mini Editor')), findsOneWidget);
    expect(find.text('videoId: project_1'), findsOneWidget);

    router.dispose();
  });
}

Future<void> _pumpLibraryReady(WidgetTester tester) async {
  await tester.pump();
  await tester.pump(const Duration(seconds: 1));
}

List<Project> _projects() {
  final now = DateTime(2026, 5, 30, 12);
  return [
    Project(
      id: 'project_1',
      userId: 'user_1',
      title: 'Launch Clip',
      description: 'Product launch edit',
      status: ProjectStatus.ready,
      thumbnailUrl: '',
      duration: 45,
      tags: const ['launch', 'product'],
      createdAt: now.subtract(const Duration(days: 2)),
      updatedAt: now,
    ),
    Project(
      id: 'project_2',
      userId: 'user_1',
      title: 'Finance Hook',
      description: 'Money tips',
      status: ProjectStatus.draft,
      thumbnailUrl: '',
      duration: 32,
      tags: const ['finance'],
      createdAt: now.subtract(const Duration(days: 3)),
      updatedAt: now.subtract(const Duration(days: 1)),
    ),
  ];
}

class _LibraryHarness extends StatelessWidget {
  const _LibraryHarness({required this.projects});

  final List<Project> projects;

  @override
  Widget build(BuildContext context) {
    return ProviderScope(
      overrides: [
        projectRepositoryProvider
            .overrideWithValue(_FakeProjectRepository(projects)),
      ],
      child: MaterialApp(
        theme: darkTheme(),
        home: const LibraryScreen(),
      ),
    );
  }
}

class _FakeProjectRepository implements ProjectRepository {
  const _FakeProjectRepository(this.projects);

  final List<Project> projects;

  @override
  Future<Project> create(Project project) async => project;

  @override
  Future<void> delete(String id) async {}

  @override
  Future<List<Project>> getAll({String? userId}) async {
    return projects.where((project) => project.userId == userId).toList();
  }

  @override
  Future<Project?> getById(String id) async =>
      projects.where((project) => project.id == id).firstOrNull;

  @override
  Future<Project> update(Project project) async => project;

  @override
  Stream<List<Project>> watch({String? userId}) {
    return Stream.value(
      projects.where((project) => project.userId == userId).toList(),
    );
  }
}
