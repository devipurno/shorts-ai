import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shorts_ai/core/theme/app_theme.dart';
import 'package:shorts_ai/core/theme/app_typography.dart';
import 'package:shorts_ai/features/auth/models/user.dart';
import 'package:shorts_ai/features/auth/providers/current_user_provider.dart';
import 'package:shorts_ai/features/editor/mini_editor_screen.dart';
import 'package:shorts_ai/features/editor/providers/editor_provider.dart';
import 'package:shorts_ai/shared/models/project.dart';
import 'package:shorts_ai/shared/repositories/project_repository.dart';
import 'package:shorts_ai/shared/repositories/providers.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  setUpAll(() {
    AppTypography.setUseGoogleFontsForTest(false);
  });

  testWidgets('renders the editor preview and switches through all seven tabs',
      (tester) async {
    await tester.pumpWidget(const _EditorHarness());
    await _pumpEditor(tester);

    expect(find.byKey(const Key('mini-editor-screen')), findsOneWidget);
    expect(find.byKey(const Key('editor-video-preview')), findsOneWidget);
    expect(find.byKey(const Key('editor-toolbar-tabs')), findsOneWidget);
    expect(find.byKey(const Key('editor-tab-trim')), findsOneWidget);

    await _tapTab(tester, EditorToolTab.split);
    expect(find.byKey(const Key('editor-tab-split')), findsOneWidget);

    await _tapTab(tester, EditorToolTab.speed);
    expect(find.byKey(const Key('editor-tab-speed')), findsOneWidget);

    await _tapTab(tester, EditorToolTab.music);
    expect(find.byKey(const Key('editor-tab-music')), findsOneWidget);

    await _tapTab(tester, EditorToolTab.watermark);
    expect(find.byKey(const Key('editor-tab-watermark')), findsOneWidget);

    await _tapTab(tester, EditorToolTab.filter);
    expect(find.byKey(const Key('editor-tab-filter')), findsOneWidget);

    await _tapTab(tester, EditorToolTab.export);
    expect(find.byKey(const Key('editor-tab-export')), findsOneWidget);
    expect(find.byKey(const Key('export-resolution-p4k')), findsOneWidget);
  });

  testWidgets('free tier gets feedback when tapping locked 4K export',
      (tester) async {
    await tester.pumpWidget(const _EditorHarness());
    await _pumpEditor(tester);

    await _tapTab(tester, EditorToolTab.export);
    await tester.tap(find.byKey(const Key('export-resolution-p4k')));
    await tester.pump();

    expect(find.text('4K LOCKED Premium tier.'), findsOneWidget);
  });

  testWidgets('export action opens progress dialog and completes mock export',
      (tester) async {
    await tester.pumpWidget(const _EditorHarness());
    await _pumpEditor(tester);

    await tester.tap(find.byKey(const Key('editor-export-action')));
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 100));

    expect(find.byKey(const Key('export-progress-dialog')), findsOneWidget);

    await tester.pump(const Duration(seconds: 3));

    expect(find.text('Export selesai'), findsOneWidget);
    expect(find.text('100%'), findsOneWidget);
  });
}

Future<void> _pumpEditor(WidgetTester tester) async {
  await tester.pump();
  await tester.pump(const Duration(milliseconds: 350));
}

Future<void> _tapTab(WidgetTester tester, EditorToolTab tab) async {
  final tabFinder = find.byKey(Key('editor-tab-button-${tab.name}'));
  await tester.ensureVisible(tabFinder);
  await tester.tap(tabFinder);
  await tester.pump();
  await tester.pump(const Duration(milliseconds: 250));
}

class _EditorHarness extends StatelessWidget {
  const _EditorHarness();

  @override
  Widget build(BuildContext context) {
    return ProviderScope(
      overrides: [
        currentUserProvider.overrideWithValue(
          User(
            id: 'user_1',
            email: 'devi@autoshort.id',
            name: 'Devi Creator',
            tier: SubscriptionTier.free,
            createdAt: DateTime(2026, 5, 31),
          ),
        ),
        projectRepositoryProvider.overrideWithValue(_FakeProjectRepository()),
      ],
      child: MaterialApp(
        theme: darkTheme(),
        home: const MiniEditorScreen(videoId: 'project_1'),
      ),
    );
  }
}

class _FakeProjectRepository implements ProjectRepository {
  final _project = Project(
    id: 'project_1',
    userId: 'user_1',
    title: 'Launch Clip',
    description: 'Editor fixture',
    status: ProjectStatus.ready,
    originalVideoUrl: '',
    duration: 60,
    createdAt: DateTime(2026, 5, 30),
    updatedAt: DateTime(2026, 5, 31),
  );

  @override
  Future<Project> create(Project project) async => project;

  @override
  Future<void> delete(String id) async {}

  @override
  Future<List<Project>> getAll({String? userId}) async => [_project];

  @override
  Future<Project?> getById(String id) async =>
      id == _project.id ? _project : null;

  @override
  Future<Project> update(Project project) async => project;

  @override
  Stream<List<Project>> watch({String? userId}) => Stream.value([_project]);
}
