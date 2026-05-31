import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shorts_ai/features/auth/models/user.dart';
import 'package:shorts_ai/features/auth/providers/current_user_provider.dart';
import 'package:shorts_ai/features/calendar/providers/calendar_provider.dart';
import 'package:shorts_ai/shared/models/project.dart';

void main() {
  test('schedulePostMutation creates scheduled job and filters by day',
      () async {
    final container = ProviderContainer(
      overrides: [
        currentUserProvider.overrideWithValue(_premiumUser),
        scheduledPostStoreProvider.overrideWith(
          (ref) => ScheduledPostController(),
        ),
      ],
    );
    addTearDown(container.dispose);

    final scheduledAt = DateTime(2026, 6, 8, 10, 30);
    final post = await container.read(schedulePostMutationProvider)(
      project: _project,
      scheduledAt: scheduledAt,
      platforms: const {CalendarPlatform.instagram, CalendarPlatform.youtube},
      caption: 'Launch caption',
    );

    expect(post.project.id, _project.id);
    expect(post.platforms, contains(CalendarPlatform.youtube));

    final filtered = scheduledPostsForDay(
      container.read(scheduledPostStoreProvider),
      DateTime(2026, 6, 8),
    );
    expect(filtered.single.id, post.id);
  });

  test('free tier blocks sixth scheduled post in the same month', () async {
    final existingPosts = List<ScheduledPost>.generate(
      5,
      (index) => ScheduledPost(
        id: 'existing_$index',
        userId: _freeUser.id,
        project: _project,
        scheduledAt: DateTime(2026, 6, index + 1, 9),
        platforms: const {CalendarPlatform.instagram},
        caption: 'Existing $index',
      ),
    );

    final container = ProviderContainer(
      overrides: [
        currentUserProvider.overrideWithValue(_freeUser),
        scheduledPostStoreProvider.overrideWith(
          (ref) => ScheduledPostController(existingPosts),
        ),
      ],
    );
    addTearDown(container.dispose);

    await expectLater(
      container.read(schedulePostMutationProvider)(
        project: _project,
        scheduledAt: DateTime(2026, 6, 20, 9),
        platforms: const {CalendarPlatform.instagram},
      ),
      throwsA(isA<StateError>()),
    );
  });

  test('tier helpers enforce monthly limits and multi-account access', () {
    expect(calendarScheduleLimitForTier(SubscriptionTier.free), 5);
    expect(calendarScheduleLimitForTier(SubscriptionTier.standard), 30);
    expect(calendarScheduleLimitForTier(SubscriptionTier.premium), isNull);

    expect(canScheduleMorePosts(SubscriptionTier.free, 4), isTrue);
    expect(canScheduleMorePosts(SubscriptionTier.free, 5), isFalse);
    expect(canUseMultipleCalendarPlatforms(SubscriptionTier.standard), isFalse);
    expect(canUseMultipleCalendarPlatforms(SubscriptionTier.premium), isTrue);
  });
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

final _project = Project(
  id: 'project_calendar',
  userId: 'premium-user',
  title: 'Calendar Launch',
  description: 'Ready to schedule',
  status: ProjectStatus.ready,
  duration: 42,
  createdAt: DateTime(2026, 6, 1),
  updatedAt: DateTime(2026, 6, 2),
);
