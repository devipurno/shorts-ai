import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shorts_ai/core/theme/app_theme.dart';
import 'package:shorts_ai/core/theme/app_typography.dart';
import 'package:shorts_ai/features/library/library_screen.dart';
import 'package:shorts_ai/shared/models/project.dart';
import 'package:shorts_ai/shared/repositories/project_repository.dart';
import 'package:shorts_ai/shared/repositories/providers.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  setUpAll(() {
    AppTypography.setUseGoogleFontsForTest(false);
  });

  testWidgets('tab switching shows filtered project list', (tester) async {
    await tester.pumpWidget(_LibraryHarness(projects: _projects()));
    await _pumpLibraryReady(tester);

    expect(find.text('Launch Clip'), findsOneWidget);

    await tester.tap(find.textContaining('Drafts').last);
    await _pumpLibraryReady(tester);

    expect(find.text('Finance Draft'), findsOneWidget);
    expect(find.text('Launch Clip'), findsNothing);
    expect(find.text('Processing Reel'), findsNothing);
  });

  testWidgets('search overlay filters projects realtime', (tester) async {
    await tester.pumpWidget(_LibraryHarness(projects: _projects()));
    await _pumpLibraryReady(tester);

    await tester.tap(find.byKey(const Key('library-search-action')));
    await tester.pumpAndSettle();

    final searchField = find.descendant(
      of: find.byKey(const Key('library-search-overlay-input')),
      matching: find.byType(TextField),
    );
    await tester.enterText(searchField, 'finance');
    await _pumpLibraryReady(tester);

    expect(find.text('Finance Draft'), findsOneWidget);
    expect(find.text('Launch Clip'), findsNothing);
  });

  testWidgets('long press project card shows action sheet', (tester) async {
    await tester.pumpWidget(_LibraryHarness(projects: _projects()));
    await _pumpLibraryReady(tester);

    await tester.longPress(
      find.byKey(const Key('library-project-card-project_1')),
    );
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 500));

    expect(find.byKey(const Key('library-action-sheet')), findsOneWidget);
    expect(find.text('Edit'), findsOneWidget);
    expect(find.text('Duplicate'), findsOneWidget);
    expect(find.text('Share'), findsOneWidget);
    expect(find.text('Delete'), findsOneWidget);
  });

  testWidgets('empty state is tailored per tab', (tester) async {
    await tester.pumpWidget(
      _LibraryHarness(
        projects: [_projects().first],
      ),
    );
    await _pumpLibraryReady(tester);

    await tester.tap(find.textContaining('Drafts').last);
    await _pumpLibraryReady(tester);

    expect(find.text('Tidak ada draft tersimpan'), findsOneWidget);
  });

  testWidgets('loading state shows grid shimmer placeholders', (tester) async {
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          projectRepositoryProvider
              .overrideWithValue(_NeverProjectRepository()),
        ],
        child: MaterialApp(
          theme: darkTheme(),
          home: const LibraryScreen(),
        ),
      ),
    );

    await tester.pump();

    expect(find.byKey(const Key('library-loading-grid')), findsOneWidget);
  });
}

Future<void> _pumpLibraryReady(WidgetTester tester) async {
  await tester.pump();
  await tester.pump(const Duration(milliseconds: 350));
}

List<Project> _projects() {
  final now = DateTime(2026, 5, 30, 12);
  return [
    Project(
      id: 'project_1',
      userId: 'user_1',
      title: 'Launch Clip',
      description: 'Product launch edit',
      status: ProjectStatus.published,
      thumbnailUrl: '',
      duration: 45,
      tags: const ['launch', 'product'],
      createdAt: now.subtract(const Duration(days: 2)),
      updatedAt: now,
      publishedAt: now,
    ),
    Project(
      id: 'project_2',
      userId: 'user_1',
      title: 'Finance Draft',
      description: 'Money tips',
      status: ProjectStatus.draft,
      thumbnailUrl: '',
      duration: 32,
      tags: const ['finance'],
      createdAt: now.subtract(const Duration(days: 3)),
      updatedAt: now.subtract(const Duration(days: 1)),
    ),
    Project(
      id: 'project_3',
      userId: 'user_1',
      title: 'Processing Reel',
      description: 'Cooking edit',
      status: ProjectStatus.processing,
      thumbnailUrl: '',
      duration: 28,
      tags: const ['food'],
      createdAt: now.subtract(const Duration(days: 1)),
      updatedAt: now.subtract(const Duration(hours: 2)),
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
        projectRepositoryProvider.overrideWithValue(
          _MutableProjectRepository(projects),
        ),
      ],
      child: MaterialApp(
        theme: darkTheme(),
        home: const LibraryScreen(),
      ),
    );
  }
}

class _MutableProjectRepository implements ProjectRepository {
  _MutableProjectRepository(List<Project> projects) : _projects = [...projects];

  final _controller = StreamController<void>.broadcast();
  final List<Project> _projects;

  @override
  Future<Project> create(Project project) async {
    _projects.add(project);
    _controller.add(null);
    return project;
  }

  @override
  Future<void> delete(String id) async {
    _projects.removeWhere((project) => project.id == id);
    _controller.add(null);
  }

  @override
  Future<List<Project>> getAll({String? userId}) async => _filter(userId);

  @override
  Future<Project?> getById(String id) async =>
      _projects.where((project) => project.id == id).firstOrNull;

  @override
  Future<Project> update(Project project) async => project;

  @override
  Stream<List<Project>> watch({String? userId}) async* {
    yield _filter(userId);
    yield* _controller.stream.map((_) => _filter(userId));
  }

  List<Project> _filter(String? userId) {
    if (userId == null) {
      return [..._projects];
    }
    return _projects.where((project) => project.userId == userId).toList();
  }
}

class _NeverProjectRepository implements ProjectRepository {
  @override
  Future<Project> create(Project project) async => project;

  @override
  Future<void> delete(String id) async {}

  @override
  Future<List<Project>> getAll({String? userId}) async => [];

  @override
  Future<Project?> getById(String id) async => null;

  @override
  Future<Project> update(Project project) async => project;

  @override
  Stream<List<Project>> watch({String? userId}) {
    return StreamController<List<Project>>().stream;
  }
}
