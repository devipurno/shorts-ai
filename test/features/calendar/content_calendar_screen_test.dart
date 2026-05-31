import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shorts_ai/core/theme/app_theme.dart';
import 'package:shorts_ai/core/theme/app_typography.dart';
import 'package:shorts_ai/features/auth/models/user.dart';
import 'package:shorts_ai/features/auth/providers/current_user_provider.dart';
import 'package:shorts_ai/features/calendar/content_calendar_screen.dart';
import 'package:shorts_ai/features/calendar/providers/calendar_provider.dart';
import 'package:shorts_ai/shared/models/project.dart';
import 'package:shorts_ai/shared/repositories/project_repository.dart';
import 'package:shorts_ai/shared/repositories/providers.dart';
import 'package:table_calendar/table_calendar.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  setUpAll(() {
    AppTypography.setUseGoogleFontsForTest(false);
  });

  testWidgets('renders calendar with scheduled posts and view toggle', (
    tester,
  ) async {
    await tester.pumpWidget(
      _CalendarHarness(
        user: _premiumUser,
        projects: _projects,
        initialPosts: [_scheduledPost],
      ),
    );
    await _pumpCalendar(tester);

    expect(find.byKey(const Key('content-calendar-screen')), findsOneWidget);
    expect(find.byType(TableCalendar<ScheduledPost>), findsOneWidget);
    expect(find.text('Scheduled Posts'), findsOneWidget);
    await tester.drag(
      find.byKey(const Key('content-calendar-list')),
      const Offset(0, -900),
    );
    await tester.pumpAndSettle();
    expect(find.textContaining('1 dipakai bulan ini'), findsOneWidget);

    await tester.tap(find.text('Week').last);
    await tester.pump();
    expect(find.text('Week'), findsWidgets);
  });

  testWidgets('schedule modal creates a new scheduled post', (tester) async {
    await tester.pumpWidget(
      _CalendarHarness(
        user: _freeUser,
        projects: _projects,
      ),
    );
    await _pumpCalendar(tester);

    await tester.tap(find.text('Schedule New').last);
    await tester.pumpAndSettle();

    expect(find.text('Schedule New'), findsWidgets);
    expect(find.text('Calendar Launch'), findsOneWidget);

    await tester.tap(find.byKey(const Key('schedule-submit-button')));
    await tester.pumpAndSettle();

    expect(find.text('Post berhasil dijadwalkan.'), findsOneWidget);
    expect(find.byKey(const Key('scheduled-post-schedule_seed_today')),
        findsNothing);
  });
}

Future<void> _pumpCalendar(WidgetTester tester) async {
  await tester.pump();
  await tester.pump(const Duration(milliseconds: 450));
}

class _CalendarHarness extends StatelessWidget {
  const _CalendarHarness({
    required this.user,
    required this.projects,
    this.initialPosts = const [],
  });

  final User user;
  final List<Project> projects;
  final List<ScheduledPost> initialPosts;

  @override
  Widget build(BuildContext context) {
    return ProviderScope(
      overrides: [
        currentUserProvider.overrideWithValue(user),
        projectRepositoryProvider.overrideWithValue(
          _FakeProjectRepository(projects),
        ),
        scheduledPostStoreProvider.overrideWith(
          (ref) => ScheduledPostController(initialPosts),
        ),
        selectedCalendarDayProvider.overrideWith(
          (ref) => normalizeCalendarDay(DateTime.now()),
        ),
        focusedCalendarDayProvider.overrideWith(
          (ref) => normalizeCalendarDay(DateTime.now()),
        ),
      ],
      child: MaterialApp(
        theme: darkTheme(),
        home: const ContentCalendarScreen(),
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
  Future<Project?> getById(String id) async {
    return projects.where((project) => project.id == id).firstOrNull;
  }

  @override
  Future<Project> update(Project project) async => project;

  @override
  Stream<List<Project>> watch({String? userId}) {
    return Stream.value(
      projects.where((project) => project.userId == userId).toList(),
    );
  }
}

final _freeUser = User(
  id: 'calendar-user',
  email: 'free@autoshort.id',
  tier: SubscriptionTier.free,
  createdAt: DateTime(2026),
);

final _premiumUser = User(
  id: 'calendar-user',
  email: 'premium@autoshort.id',
  tier: SubscriptionTier.premium,
  createdAt: DateTime(2026),
);

final _projects = [
  Project(
    id: 'project_calendar',
    userId: 'calendar-user',
    title: 'Calendar Launch',
    description: 'Ready to schedule',
    status: ProjectStatus.ready,
    duration: 42,
    createdAt: DateTime(2026, 6, 1),
    updatedAt: DateTime(2026, 6, 2),
  ),
];

final _scheduledPost = ScheduledPost(
  id: 'scheduled_existing',
  userId: 'calendar-user',
  project: _projects.first,
  scheduledAt: normalizeCalendarDay(DateTime.now()).add(
    const Duration(hours: 10),
  ),
  platforms: const {CalendarPlatform.instagram},
  caption: 'Launch caption',
);
