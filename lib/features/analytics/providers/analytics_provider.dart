import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';

import '../../../shared/repositories/analytics_repository.dart';
import '../../../shared/repositories/providers.dart';
import '../../auth/models/user.dart';
import '../../auth/providers/current_user_provider.dart';

const _fallbackUserId = 'user_1';

final analyticsPeriodProvider =
    StateProvider<AnalyticsPeriod>((ref) => AnalyticsPeriod.thirtyDays);

final analyticsProvider =
    FutureProvider.family<CreatorAnalyticsData, AnalyticsPeriod>((
  ref,
  period,
) async {
  final user = ref.watch(currentUserProvider);
  final userId = user?.id ?? _fallbackUserId;
  final repository = ref.watch(analyticsRepositoryProvider);
  final stats = await repository.getUserStats(userId);

  return buildCreatorAnalyticsData(
    period: period,
    tier: user?.tier ?? SubscriptionTier.free,
    stats: stats,
  );
});

final kpiProvider = FutureProvider.family<List<KpiMetric>, AnalyticsPeriod>((
  ref,
  period,
) async {
  final data = await ref.watch(analyticsProvider(period).future);
  return data.kpis;
});

final chartDataProvider =
    FutureProvider.family<List<TimeSeriesPoint>, AnalyticsChartQuery>((
  ref,
  query,
) async {
  final data = await ref.watch(analyticsProvider(query.period).future);
  return switch (query.metric) {
    AnalyticsChartMetric.views => data.viewsOverTime,
    AnalyticsChartMetric.likes => data.likesOverTime,
    AnalyticsChartMetric.shares => data.sharesOverTime,
    AnalyticsChartMetric.followers => data.followersOverTime,
  };
});

enum AnalyticsPeriod {
  sevenDays('7d', 7),
  thirtyDays('30d', 30),
  ninetyDays('90d', 90),
  oneYear('1y', 365);

  const AnalyticsPeriod(this.label, this.days);

  final String label;
  final int days;
}

enum AnalyticsChartMetric { views, likes, shares, followers }

class AnalyticsChartQuery {
  const AnalyticsChartQuery({
    required this.metric,
    required this.period,
  });

  final AnalyticsChartMetric metric;
  final AnalyticsPeriod period;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        other is AnalyticsChartQuery &&
            other.metric == metric &&
            other.period == period;
  }

  @override
  int get hashCode => Object.hash(metric, period);
}

class CreatorAnalyticsData {
  const CreatorAnalyticsData({
    required this.period,
    required this.kpis,
    required this.viewsOverTime,
    required this.likesOverTime,
    required this.sharesOverTime,
    required this.followersOverTime,
    required this.topVideos,
    required this.engagementBreakdown,
    required this.bestPostingTimes,
    required this.demographics,
  });

  final AnalyticsPeriod period;
  final List<KpiMetric> kpis;
  final List<TimeSeriesPoint> viewsOverTime;
  final List<TimeSeriesPoint> likesOverTime;
  final List<TimeSeriesPoint> sharesOverTime;
  final List<TimeSeriesPoint> followersOverTime;
  final List<VideoPerformance> topVideos;
  final EngagementBreakdown engagementBreakdown;
  final List<PostingTimeCell> bestPostingTimes;
  final AudienceDemographics demographics;
}

class KpiMetric {
  const KpiMetric({
    required this.label,
    required this.value,
    required this.trendPercent,
    required this.icon,
  });

  final String label;
  final int value;
  final double trendPercent;
  final IconData icon;

  bool get isPositive => trendPercent >= 0;
}

class TimeSeriesPoint {
  const TimeSeriesPoint({
    required this.index,
    required this.label,
    required this.value,
  });

  final int index;
  final String label;
  final double value;
}

class VideoPerformance {
  const VideoPerformance({
    required this.id,
    required this.title,
    required this.views,
    required this.engagementRate,
  });

  final String id;
  final String title;
  final int views;
  final double engagementRate;
}

class EngagementBreakdown {
  const EngagementBreakdown({
    required this.likes,
    required this.comments,
    required this.shares,
    required this.saves,
  });

  final int likes;
  final int comments;
  final int shares;
  final int saves;

  int get total => likes + comments + shares + saves;

  List<EngagementSegment> get segments {
    return [
      EngagementSegment(
          label: 'Likes', value: likes, color: const Color(0xFFD4AF37)),
      EngagementSegment(
          label: 'Comments', value: comments, color: const Color(0xFF60A5FA)),
      EngagementSegment(
          label: 'Shares', value: shares, color: const Color(0xFF4ADE80)),
      EngagementSegment(
          label: 'Saves', value: saves, color: const Color(0xFFE879F9)),
    ];
  }
}

class EngagementSegment {
  const EngagementSegment({
    required this.label,
    required this.value,
    required this.color,
  });

  final String label;
  final int value;
  final Color color;
}

class PostingTimeCell {
  const PostingTimeCell({
    required this.day,
    required this.hour,
    required this.score,
  });

  final int day;
  final int hour;
  final double score;
}

class AudienceDemographics {
  const AudienceDemographics({
    required this.ageGroups,
    required this.genderSplit,
    required this.topCountries,
  });

  final List<DemographicSegment> ageGroups;
  final List<DemographicSegment> genderSplit;
  final List<DemographicSegment> topCountries;
}

class DemographicSegment {
  const DemographicSegment({
    required this.label,
    required this.value,
  });

  final String label;
  final double value;
}

CreatorAnalyticsData buildCreatorAnalyticsData({
  required AnalyticsPeriod period,
  required SubscriptionTier tier,
  required UserAnalyticsStats stats,
}) {
  final seed = stats.totalEvents + period.days + tier.index * 17;
  final points = _buildSeries(
    period: period,
    seed: seed,
    base: 900 + stats.generationStartedCount * 80 + tier.index * 240,
    amplitude: 170 + tier.index * 36,
  );
  final likes = _scaleSeries(points, 0.092, 'L');
  final shares = _scaleSeries(points, 0.018, 'S');
  final followers = _scaleSeries(points, 0.006, 'F');
  final totalViews =
      points.fold<int>(0, (sum, item) => sum + item.value.round());
  final totalLikes =
      likes.fold<int>(0, (sum, item) => sum + item.value.round());
  final totalShares =
      shares.fold<int>(0, (sum, item) => sum + item.value.round());
  final followerGrowth =
      followers.fold<int>(0, (sum, item) => sum + item.value.round());

  return CreatorAnalyticsData(
    period: period,
    kpis: [
      KpiMetric(
        label: 'Total Views',
        value: totalViews,
        trendPercent: 12.5 + tier.index * 1.8,
        icon: Icons.visibility_rounded,
      ),
      KpiMetric(
        label: 'Total Likes',
        value: totalLikes,
        trendPercent: 8.2 + tier.index * 1.2,
        icon: Icons.favorite_rounded,
      ),
      KpiMetric(
        label: 'Total Shares',
        value: totalShares,
        trendPercent: 5.9 + tier.index,
        icon: Icons.ios_share_rounded,
      ),
      KpiMetric(
        label: 'Follower Growth',
        value: followerGrowth,
        trendPercent: 3.8 + tier.index * 0.9,
        icon: Icons.trending_up_rounded,
      ),
    ],
    viewsOverTime: points,
    likesOverTime: likes,
    sharesOverTime: shares,
    followersOverTime: followers,
    topVideos: _buildTopVideos(seed, totalViews),
    engagementBreakdown: EngagementBreakdown(
      likes: totalLikes,
      comments: (totalLikes * 0.18).round(),
      shares: totalShares,
      saves: (totalLikes * 0.12).round(),
    ),
    bestPostingTimes: _buildHeatmap(seed),
    demographics: const AudienceDemographics(
      ageGroups: [
        DemographicSegment(label: '13-17', value: 8),
        DemographicSegment(label: '18-24', value: 34),
        DemographicSegment(label: '25-34', value: 29),
        DemographicSegment(label: '35-44', value: 18),
        DemographicSegment(label: '45+', value: 11),
      ],
      genderSplit: [
        DemographicSegment(label: 'Women', value: 52),
        DemographicSegment(label: 'Men', value: 44),
        DemographicSegment(label: 'Other', value: 4),
      ],
      topCountries: [
        DemographicSegment(label: 'Indonesia', value: 68),
        DemographicSegment(label: 'Malaysia', value: 12),
        DemographicSegment(label: 'Singapore', value: 7),
        DemographicSegment(label: 'United States', value: 5),
      ],
    ),
  );
}

bool hasFullAnalyticsCharts(SubscriptionTier tier) {
  return tier != SubscriptionTier.free;
}

bool hasAudienceDemographics(SubscriptionTier tier) {
  return tier == SubscriptionTier.premium || tier == SubscriptionTier.lifetime;
}

bool canExportAnalyticsPdf(SubscriptionTier tier) {
  return hasAudienceDemographics(tier);
}

List<TimeSeriesPoint> _buildSeries({
  required AnalyticsPeriod period,
  required int seed,
  required double base,
  required double amplitude,
}) {
  final count = switch (period) {
    AnalyticsPeriod.sevenDays => 7,
    AnalyticsPeriod.thirtyDays => 10,
    AnalyticsPeriod.ninetyDays => 13,
    AnalyticsPeriod.oneYear => 12,
  };
  final step = period.days / count;

  return List<TimeSeriesPoint>.generate(count, (index) {
    final wave = math.sin((index + seed % 9) * 0.82);
    final growth = index * (period.days / count) * 9;
    final value = math.max<double>(120, base + growth + wave * amplitude);
    return TimeSeriesPoint(
      index: index,
      label: _pointLabel(period, index, step),
      value: value,
    );
  });
}

List<TimeSeriesPoint> _scaleSeries(
  List<TimeSeriesPoint> source,
  double ratio,
  String prefix,
) {
  return [
    for (final point in source)
      TimeSeriesPoint(
        index: point.index,
        label: '$prefix${point.index + 1}',
        value: math.max(1, point.value * ratio),
      ),
  ];
}

String _pointLabel(AnalyticsPeriod period, int index, double step) {
  return switch (period) {
    AnalyticsPeriod.sevenDays => ['M', 'T', 'W', 'T', 'F', 'S', 'S'][index],
    AnalyticsPeriod.thirtyDays => 'D${(index * step + 1).round()}',
    AnalyticsPeriod.ninetyDays => 'W${index + 1}',
    AnalyticsPeriod.oneYear => 'M${index + 1}',
  };
}

List<VideoPerformance> _buildTopVideos(int seed, int totalViews) {
  const titles = [
    '3 detik pertama yang bikin stop scroll',
    'Before-after editing workflow',
    'Hook edukasi untuk creator pemula',
    'Template viral untuk niche finance',
    'Behind the scenes AutoShort render',
  ];

  return List<VideoPerformance>.generate(5, (index) {
    final views = (totalViews * (0.18 - index * 0.022)).round() + seed * 8;
    return VideoPerformance(
      id: 'video_${index + 1}',
      title: titles[index],
      views: views,
      engagementRate: 8.4 - index * 0.7 + (seed % 5) * 0.12,
    );
  });
}

List<PostingTimeCell> _buildHeatmap(int seed) {
  return [
    for (var day = 0; day < 7; day++)
      for (var hour = 0; hour < 24; hour++)
        PostingTimeCell(
          day: day,
          hour: hour,
          score: _heatmapScore(day, hour, seed),
        ),
  ];
}

double _heatmapScore(int day, int hour, int seed) {
  final eveningPeak = math.max(0, 1 - ((hour - 20).abs() / 8));
  final noonPeak = math.max(0, 1 - ((hour - 12).abs() / 10)) * 0.42;
  final weekendLift = day >= 5 ? 0.18 : 0;
  final noise = ((day * 17 + hour * 7 + seed) % 19) / 100;
  return (eveningPeak * 0.72 + noonPeak + weekendLift + noise).clamp(0, 1);
}
