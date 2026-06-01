import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/misc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:golden_toolkit/golden_toolkit.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shorts_ai/core/theme/app_colors.dart';
import 'package:shorts_ai/core/theme/app_theme.dart';
import 'package:shorts_ai/core/theme/app_typography.dart';
import 'package:shorts_ai/features/auth/models/user.dart';
import 'package:shorts_ai/features/auth/providers/auth_provider.dart';
import 'package:shorts_ai/shared/models/analytics_event.dart';
import 'package:shorts_ai/shared/models/project.dart';
import 'package:shorts_ai/shared/models/subscription.dart';
import 'package:shorts_ai/shared/models/template.dart';
import 'package:shorts_ai/shared/repositories/analytics_repository.dart';
import 'package:shorts_ai/shared/repositories/project_repository.dart';
import 'package:shorts_ai/shared/repositories/providers.dart';
import 'package:shorts_ai/shared/repositories/subscription_repository.dart';
import 'package:shorts_ai/shared/repositories/template_repository.dart';

const goldenSurfaceSize = Size(832, 896);
const pixel4Size = Size(393, 851);
const iphone11Size = Size(414, 896);

void setUpGoldenTests() {
  TestWidgetsFlutterBinding.ensureInitialized();
  setUpAll(() async {
    AppTypography.setUseGoogleFontsForTest(false);
    await loadAppFonts();
  });
  setUp(() {
    SharedPreferences.setMockInitialValues({});
  });
}

Future<void> pumpResponsiveGolden(
  WidgetTester tester, {
  required Widget Function() builder,
  AuthState authState = const Unauthenticated(),
  List<Override> overrides = const [],
}) async {
  tester.view
    ..physicalSize = goldenSurfaceSize
    ..devicePixelRatio = 1;
  addTearDown(tester.view.resetPhysicalSize);
  addTearDown(tester.view.resetDevicePixelRatio);

  await tester.pumpWidget(
    Directionality(
      textDirection: TextDirection.ltr,
      child: ColoredBox(
        color: AppColors.obsidian,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: pixel4Size.width,
              height: pixel4Size.height,
              child: _GoldenApp(
                authState: authState,
                overrides: overrides,
                child: builder(),
              ),
            ),
            const SizedBox(width: 24),
            SizedBox(
              width: iphone11Size.width,
              height: iphone11Size.height,
              child: _GoldenApp(
                authState: authState,
                overrides: overrides,
                child: builder(),
              ),
            ),
          ],
        ),
      ),
    ),
  );
  await tester.pump();
  await tester.pump(const Duration(milliseconds: 350));
}

Future<void> expectResponsiveGolden(
  WidgetTester tester,
  String name,
) async {
  await expectLater(
    find.byType(Row).first,
    matchesGoldenFile('../goldens/$name.png'),
  );
}

final goldenUser = User(
  id: 'golden-user',
  email: 'creator@autoshort.id',
  name: 'Devi',
  tier: SubscriptionTier.premium,
  createdAt: DateTime(2026),
);

final goldenNow = DateTime(2026, 6, 1, 9);

final goldenProjects = <Project>[
  Project(
    id: 'golden-video',
    userId: goldenUser.id,
    title: 'Viral launch clip',
    status: ProjectStatus.ready,
    duration: 42,
    createdAt: goldenNow,
    updatedAt: goldenNow,
  ),
  Project(
    id: 'golden-library-2',
    userId: goldenUser.id,
    title: 'Draft tutorial',
    status: ProjectStatus.draft,
    duration: 51,
    createdAt: goldenNow,
    updatedAt: goldenNow,
  ),
];

const goldenTemplates = <Template>[
  Template(
    id: 'golden-template-1',
    name: 'Podcast Gold',
    category: 'Podcast Split',
    tier: TemplateTier.premium,
    timesUsed: 1400,
  ),
  Template(
    id: 'golden-template-2',
    name: 'Edu Hook',
    category: 'Education',
    tier: TemplateTier.free,
    timesUsed: 900,
  ),
];

class _GoldenApp extends StatelessWidget {
  const _GoldenApp({
    required this.child,
    required this.authState,
    required this.overrides,
  });

  final Widget child;
  final AuthState authState;
  final List<Override> overrides;

  @override
  Widget build(BuildContext context) {
    return ProviderScope(
      overrides: [
        authMockDelayProvider.overrideWith((ref) => Duration.zero),
        authProvider.overrideWith((ref) => _GoldenAuthNotifier(authState)),
        projectRepositoryProvider.overrideWithValue(_GoldenProjectRepository()),
        templateRepositoryProvider.overrideWithValue(_GoldenTemplateRepository()),
        analyticsRepositoryProvider.overrideWithValue(_GoldenAnalyticsRepository()),
        subscriptionRepositoryProvider.overrideWithValue(_GoldenSubscriptionRepository()),
        ...overrides,
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: darkTheme(),
        home: child,
      ),
    );
  }
}

class _GoldenAuthNotifier extends AuthNotifier {
  _GoldenAuthNotifier(AuthState seed) : super(mockDelay: Duration.zero) {
    state = seed;
  }
}

class _GoldenProjectRepository implements ProjectRepository {
  @override
  Future<Project> create(Project project) async => project;

  @override
  Future<void> delete(String id) async {}

  @override
  Future<List<Project>> getAll({String? userId}) async => goldenProjects;

  @override
  Future<Project?> getById(String id) async => goldenProjects.firstOrNull;

  @override
  Future<Project> update(Project project) async => project;

  @override
  Stream<List<Project>> watch({String? userId}) => Stream.value(goldenProjects);
}

class _GoldenTemplateRepository implements TemplateRepository {
  @override
  Future<List<Template>> getAll() async => goldenTemplates;

  @override
  Future<Template?> getById(String id) async => goldenTemplates.firstOrNull;

  @override
  Future<List<Template>> getByCategory(String category) async => goldenTemplates;

  @override
  Stream<List<Template>> watchAll() => Stream.value(goldenTemplates);
}

class _GoldenAnalyticsRepository implements AnalyticsRepository {
  @override
  Future<List<AnalyticsEvent>> getEvents({String? userId}) async => const [];

  @override
  Future<UserAnalyticsStats> getUserStats(String userId) async {
    return UserAnalyticsStats(
      userId: userId,
      totalEvents: 320,
      projectCreatedCount: 12,
      generationStartedCount: 18,
      lastEventAt: goldenNow,
    );
  }

  @override
  Future<void> trackEvent(AnalyticsEvent event) async {}

  @override
  Stream<List<AnalyticsEvent>> watchEvents({String? userId}) => Stream.value(const []);
}

class _GoldenSubscriptionRepository implements SubscriptionRepository {
  @override
  Future<Subscription> create(Subscription subscription) async => subscription;

  @override
  Future<Subscription?> getById(String id) async => null;

  @override
  Future<Subscription?> getByUserId(String userId) async => null;

  @override
  Future<int> getLifetimeSlots() async => 84;

  @override
  Future<Subscription> update(Subscription subscription) async => subscription;

  @override
  Future<void> cancel(String id) async {}

  @override
  Stream<Subscription?> watchByUserId(String userId) => Stream.value(null);
}