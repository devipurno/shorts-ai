import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:table_calendar/table_calendar.dart';

import '../../../shared/models/project.dart';
import '../../auth/models/user.dart';
import '../../auth/providers/current_user_provider.dart';

const _fallbackUserId = 'user_1';

final calendarViewProvider =
    StateProvider<CalendarViewMode>((ref) => CalendarViewMode.month);

final selectedCalendarDayProvider =
    StateProvider<DateTime>((ref) => normalizeCalendarDay(DateTime.now()));

final focusedCalendarDayProvider =
    StateProvider<DateTime>((ref) => normalizeCalendarDay(DateTime.now()));

final scheduledPostStoreProvider =
    StateNotifierProvider<ScheduledPostController, List<ScheduledPost>>((ref) {
  final now = DateTime.now();
  return ScheduledPostController(_seedScheduledPosts(now));
});

final scheduledPostsProvider =
    FutureProvider.family<List<ScheduledPost>, DateTime>((ref, day) async {
  final posts = ref.watch(scheduledPostStoreProvider);
  await Future<void>.delayed(const Duration(milliseconds: 120));
  return scheduledPostsForDay(posts, day);
});

final schedulePostMutationProvider = Provider<SchedulePostMutation>((ref) {
  return SchedulePostMutation(ref);
});

enum CalendarViewMode {
  month('Month', CalendarFormat.month),
  week('Week', CalendarFormat.week),
  day('Day', CalendarFormat.week);

  const CalendarViewMode(this.label, this.format);

  final String label;
  final CalendarFormat format;
}

enum CalendarPlatform {
  instagram('IG', Icons.camera_alt_rounded, Color(0xFFE879F9)),
  youtube('YT', Icons.play_circle_fill_rounded, Color(0xFFEF4444)),
  tiktok('TikTok', Icons.music_note_rounded, Color(0xFF60A5FA));

  const CalendarPlatform(this.label, this.icon, this.color);

  final String label;
  final IconData icon;
  final Color color;
}

enum ScheduledPostStatus {
  scheduled('Scheduled', Color(0xFFFBBF24)),
  posted('Posted', Color(0xFF4ADE80)),
  failed('Failed', Color(0xFFEF4444));

  const ScheduledPostStatus(this.label, this.color);

  final String label;
  final Color color;
}

class ScheduledPost {
  const ScheduledPost({
    required this.id,
    required this.userId,
    required this.project,
    required this.scheduledAt,
    required this.platforms,
    required this.caption,
    this.status = ScheduledPostStatus.scheduled,
  });

  final String id;
  final String userId;
  final Project project;
  final DateTime scheduledAt;
  final Set<CalendarPlatform> platforms;
  final String caption;
  final ScheduledPostStatus status;

  ScheduledPost copyWith({
    String? id,
    String? userId,
    Project? project,
    DateTime? scheduledAt,
    Set<CalendarPlatform>? platforms,
    String? caption,
    ScheduledPostStatus? status,
  }) {
    return ScheduledPost(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      project: project ?? this.project,
      scheduledAt: scheduledAt ?? this.scheduledAt,
      platforms: platforms ?? this.platforms,
      caption: caption ?? this.caption,
      status: status ?? this.status,
    );
  }
}

class ScheduledPostController extends StateNotifier<List<ScheduledPost>> {
  ScheduledPostController([List<ScheduledPost> initialPosts = const []])
      : super(List<ScheduledPost>.unmodifiable(initialPosts));

  void upsert(ScheduledPost post) {
    final next = [...state];
    final index = next.indexWhere((item) => item.id == post.id);
    if (index == -1) {
      next.add(post);
    } else {
      next[index] = post;
    }
    next.sort((a, b) => a.scheduledAt.compareTo(b.scheduledAt));
    state = List<ScheduledPost>.unmodifiable(next);
  }

  void delete(String id) {
    state = List<ScheduledPost>.unmodifiable(
      state.where((post) => post.id != id),
    );
  }
}

class SchedulePostMutation {
  const SchedulePostMutation(this._ref);

  final Ref _ref;

  Future<ScheduledPost> call({
    required Project project,
    required DateTime scheduledAt,
    required Set<CalendarPlatform> platforms,
    String? caption,
  }) async {
    if (platforms.isEmpty) {
      throw StateError('Pilih minimal satu platform.');
    }

    final user = _ref.read(currentUserProvider);
    final tier = user?.tier ?? SubscriptionTier.free;
    if (platforms.length > 1 && !canUseMultipleCalendarPlatforms(tier)) {
      throw StateError('Multi-platform scheduling tersedia untuk Premium.');
    }

    final posts = _ref.read(scheduledPostStoreProvider);
    final countThisMonth = scheduledCountForMonth(posts, scheduledAt);
    if (!canScheduleMorePosts(tier, countThisMonth)) {
      final limit = calendarScheduleLimitForTier(tier);
      throw StateError('Limit $limit scheduled posts/bulan sudah tercapai.');
    }

    final post = ScheduledPost(
      id: 'schedule_${DateTime.now().microsecondsSinceEpoch}',
      userId: user?.id ?? _fallbackUserId,
      project: project,
      scheduledAt: scheduledAt,
      platforms: Set<CalendarPlatform>.unmodifiable(platforms),
      caption:
          caption?.trim().isNotEmpty == true ? caption!.trim() : project.title,
    );

    _ref.read(scheduledPostStoreProvider.notifier).upsert(post);
    return post;
  }
}

DateTime normalizeCalendarDay(DateTime value) {
  return DateTime(value.year, value.month, value.day);
}

bool isSameCalendarDay(DateTime left, DateTime right) {
  return isSameDay(left, right);
}

List<ScheduledPost> scheduledPostsForDay(
  List<ScheduledPost> posts,
  DateTime day,
) {
  final normalized = normalizeCalendarDay(day);
  return List<ScheduledPost>.unmodifiable(
    posts.where((post) {
      return isSameCalendarDay(post.scheduledAt, normalized);
    }),
  );
}

int scheduledCountForMonth(List<ScheduledPost> posts, DateTime month) {
  return posts.where((post) {
    return post.scheduledAt.year == month.year &&
        post.scheduledAt.month == month.month;
  }).length;
}

int? calendarScheduleLimitForTier(SubscriptionTier tier) {
  return switch (tier) {
    SubscriptionTier.free => 5,
    SubscriptionTier.standard => 30,
    SubscriptionTier.premium || SubscriptionTier.lifetime => null,
  };
}

bool canScheduleMorePosts(SubscriptionTier tier, int currentMonthCount) {
  final limit = calendarScheduleLimitForTier(tier);
  return limit == null || currentMonthCount < limit;
}

bool canUseMultipleCalendarPlatforms(SubscriptionTier tier) {
  return tier == SubscriptionTier.premium || tier == SubscriptionTier.lifetime;
}

String calendarTierLimitLabel(SubscriptionTier tier) {
  final limit = calendarScheduleLimitForTier(tier);
  return limit == null ? 'Unlimited posts/bulan' : '$limit posts/bulan';
}

List<ScheduledPost> _seedScheduledPosts(DateTime now) {
  final today = normalizeCalendarDay(now);
  final projects = [
    Project(
      id: 'calendar_seed_1',
      userId: _fallbackUserId,
      title: 'Launch hook edukasi',
      description: 'Scheduled seed post',
      status: ProjectStatus.ready,
      duration: 38,
      createdAt: now.subtract(const Duration(days: 3)),
      updatedAt: now.subtract(const Duration(days: 1)),
    ),
    Project(
      id: 'calendar_seed_2',
      userId: _fallbackUserId,
      title: 'Before after brand kit',
      description: 'Scheduled seed post',
      status: ProjectStatus.ready,
      duration: 44,
      createdAt: now.subtract(const Duration(days: 5)),
      updatedAt: now.subtract(const Duration(days: 2)),
    ),
  ];

  return [
    ScheduledPost(
      id: 'schedule_seed_today',
      userId: _fallbackUserId,
      project: projects.first,
      scheduledAt: today.add(const Duration(hours: 10)),
      platforms: const {CalendarPlatform.instagram},
      caption: 'Hook edukasi siap publish.',
    ),
    ScheduledPost(
      id: 'schedule_seed_tomorrow',
      userId: _fallbackUserId,
      project: projects.last,
      scheduledAt: today.add(const Duration(days: 1, hours: 15)),
      platforms: const {CalendarPlatform.youtube, CalendarPlatform.tiktok},
      caption: 'A/B creative cut untuk audience baru.',
    ),
  ];
}
