import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shorts_ai/features/analytics/providers/analytics_provider.dart';
import 'package:shorts_ai/features/auth/models/user.dart';
import 'package:shorts_ai/features/auth/providers/current_user_provider.dart';
import 'package:shorts_ai/shared/models/analytics_event.dart';
import 'package:shorts_ai/shared/repositories/analytics_repository.dart';
import 'package:shorts_ai/shared/repositories/providers.dart';

void main() {
  test(
      'buildCreatorAnalyticsData returns KPI, chart, heatmap, and demographics',
      () {
    final data = buildCreatorAnalyticsData(
      period: AnalyticsPeriod.thirtyDays,
      tier: SubscriptionTier.premium,
      stats: const UserAnalyticsStats(
        userId: 'user_1',
        totalEvents: 12,
        projectCreatedCount: 3,
        generationStartedCount: 5,
      ),
    );

    expect(data.kpis, hasLength(4));
    expect(data.viewsOverTime, isNotEmpty);
    expect(data.topVideos, hasLength(5));
    expect(data.engagementBreakdown.total, greaterThan(0));
    expect(data.bestPostingTimes, hasLength(168));
    expect(data.demographics.topCountries.first.label, 'Indonesia');
  });

  test('tier helpers gate free, standard, and premium analytics', () {
    expect(hasFullAnalyticsCharts(SubscriptionTier.free), isFalse);
    expect(hasFullAnalyticsCharts(SubscriptionTier.standard), isTrue);
    expect(hasAudienceDemographics(SubscriptionTier.standard), isFalse);
    expect(hasAudienceDemographics(SubscriptionTier.premium), isTrue);
    expect(canExportAnalyticsPdf(SubscriptionTier.lifetime), isTrue);
  });

  test('analyticsProvider maps repository stats into dashboard data', () async {
    final container = ProviderContainer(
      overrides: [
        currentUserProvider.overrideWithValue(_premiumUser),
        analyticsRepositoryProvider.overrideWithValue(
          const _FakeAnalyticsRepository(),
        ),
      ],
    );
    addTearDown(container.dispose);

    final data = await container.read(
      analyticsProvider(AnalyticsPeriod.sevenDays).future,
    );
    final chart = await container.read(
      chartDataProvider(
        const AnalyticsChartQuery(
          metric: AnalyticsChartMetric.views,
          period: AnalyticsPeriod.sevenDays,
        ),
      ).future,
    );

    expect(data.period, AnalyticsPeriod.sevenDays);
    expect(data.kpis.first.label, 'Total Views');
    expect(chart, data.viewsOverTime);
  });
}

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
      totalEvents: 18,
      projectCreatedCount: 4,
      generationStartedCount: 7,
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
