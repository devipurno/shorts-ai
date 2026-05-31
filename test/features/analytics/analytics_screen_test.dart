import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shorts_ai/core/theme/app_theme.dart';
import 'package:shorts_ai/core/theme/app_typography.dart';
import 'package:shorts_ai/features/analytics/analytics_screen.dart';
import 'package:shorts_ai/features/auth/models/user.dart';
import 'package:shorts_ai/features/auth/providers/current_user_provider.dart';
import 'package:shorts_ai/shared/models/analytics_event.dart';
import 'package:shorts_ai/shared/repositories/analytics_repository.dart';
import 'package:shorts_ai/shared/repositories/providers.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  setUpAll(() {
    AppTypography.setUseGoogleFontsForTest(false);
  });

  testWidgets('free tier renders KPI basics and locked chart sections', (
    tester,
  ) async {
    await tester.pumpWidget(_AnalyticsHarness(user: _freeUser));
    await _pumpAnalytics(tester);

    expect(find.byKey(const Key('analytics-screen')), findsOneWidget);
    expect(find.text('Basic metrics aktif'), findsOneWidget);
    expect(find.text('Total Views'), findsOneWidget);

    await tester.drag(
        find.byKey(const Key('analytics-list')), const Offset(0, -900));
    await tester.pumpAndSettle();

    expect(find.text('Full charts locked'), findsOneWidget);
    expect(find.text('Audience demographics locked'), findsOneWidget);
    expect(find.byKey(const Key('analytics-export-pdf-button')), findsNothing);
  });

  testWidgets('premium tier renders demographics and PDF export CTA', (
    tester,
  ) async {
    await tester.pumpWidget(_AnalyticsHarness(user: _premiumUser));
    await _pumpAnalytics(tester);

    expect(find.text('Demographics dan PDF export aktif'), findsOneWidget);

    await tester.drag(
        find.byKey(const Key('analytics-list')), const Offset(0, -1600));
    await tester.pumpAndSettle();

    expect(
        find.byKey(const Key('analytics-demographics-card')), findsOneWidget);

    await tester.drag(
      find.byKey(const Key('analytics-list')),
      const Offset(0, -600),
    );
    await tester.pumpAndSettle();

    expect(
        find.byKey(const Key('analytics-export-pdf-button')), findsOneWidget);
  });
}

Future<void> _pumpAnalytics(WidgetTester tester) async {
  await tester.pump();
  await tester.pump(const Duration(milliseconds: 450));
}

class _AnalyticsHarness extends StatelessWidget {
  const _AnalyticsHarness({required this.user});

  final User user;

  @override
  Widget build(BuildContext context) {
    return ProviderScope(
      overrides: [
        currentUserProvider.overrideWithValue(user),
        analyticsRepositoryProvider.overrideWithValue(
          const _FakeAnalyticsRepository(),
        ),
      ],
      child: MaterialApp(
        theme: darkTheme(),
        home: const AnalyticsScreen(),
      ),
    );
  }
}

final _freeUser = User(
  id: 'free-user',
  email: 'free@autoshort.id',
  tier: SubscriptionTier.free,
  createdAt: DateTime(2026),
);

final _premiumUser = User(
  id: 'premium-user',
  email: 'premium@autoshort.id',
  tier: SubscriptionTier.premium,
  createdAt: DateTime(2026),
);

class _FakeAnalyticsRepository implements AnalyticsRepository {
  const _FakeAnalyticsRepository();

  @override
  Future<List<AnalyticsEvent>> getEvents({String? userId}) async => const [];

  @override
  Future<UserAnalyticsStats> getUserStats(String userId) async {
    return UserAnalyticsStats(
      userId: userId,
      totalEvents: 20,
      projectCreatedCount: 6,
      generationStartedCount: 9,
      lastEventAt: DateTime(2026, 6, 1),
    );
  }

  @override
  Future<void> trackEvent(AnalyticsEvent event) async {}

  @override
  Stream<List<AnalyticsEvent>> watchEvents({String? userId}) {
    return const Stream.empty();
  }
}
