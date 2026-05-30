import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shorts_ai/shared/models/analytics_event.dart';
import 'package:shorts_ai/shared/models/brand_kit.dart';
import 'package:shorts_ai/shared/models/notification.dart';
import 'package:shorts_ai/shared/models/project.dart';
import 'package:shorts_ai/shared/models/referral.dart';
import 'package:shorts_ai/shared/models/script.dart';
import 'package:shorts_ai/shared/models/subscription.dart';
import 'package:shorts_ai/shared/models/subtitle.dart' as subtitle_model;
import 'package:shorts_ai/shared/models/template.dart' as template_model;
import 'package:shorts_ai/shared/models/thumbnail.dart';
import 'package:shorts_ai/shared/models/user.dart';
import 'package:shorts_ai/shared/repositories/analytics_repository.dart';
import 'package:shorts_ai/shared/repositories/auth_repository.dart';
import 'package:shorts_ai/shared/repositories/brand_kit_repository.dart';
import 'package:shorts_ai/shared/repositories/mock/mock_analytics_repository.dart';
import 'package:shorts_ai/shared/repositories/mock/mock_auth_repository.dart';
import 'package:shorts_ai/shared/repositories/mock/mock_brand_kit_repository.dart';
import 'package:shorts_ai/shared/repositories/mock/mock_notification_repository.dart';
import 'package:shorts_ai/shared/repositories/mock/mock_project_repository.dart';
import 'package:shorts_ai/shared/repositories/mock/mock_referral_repository.dart';
import 'package:shorts_ai/shared/repositories/mock/mock_repository_utils.dart';
import 'package:shorts_ai/shared/repositories/mock/mock_script_repository.dart';
import 'package:shorts_ai/shared/repositories/mock/mock_subtitle_repository.dart';
import 'package:shorts_ai/shared/repositories/mock/mock_subscription_repository.dart';
import 'package:shorts_ai/shared/repositories/mock/mock_template_repository.dart';
import 'package:shorts_ai/shared/repositories/mock/mock_thumbnail_repository.dart';
import 'package:shorts_ai/shared/repositories/mock/mock_user_repository.dart';
import 'package:shorts_ai/shared/repositories/notification_repository.dart';
import 'package:shorts_ai/shared/repositories/project_repository.dart';
import 'package:shorts_ai/shared/repositories/providers.dart';
import 'package:shorts_ai/shared/repositories/referral_repository.dart';
import 'package:shorts_ai/shared/repositories/script_repository.dart';
import 'package:shorts_ai/shared/repositories/subtitle_repository.dart';
import 'package:shorts_ai/shared/repositories/subscription_repository.dart';
import 'package:shorts_ai/shared/repositories/template_repository.dart';
import 'package:shorts_ai/shared/repositories/thumbnail_repository.dart';
import 'package:shorts_ai/shared/repositories/user_repository.dart';

void main() {
  const config = MockRepositoryConfig.test();
  final now = DateTime.utc(2026, 5, 30, 10);

  group('mock repositories', () {
    test('AuthRepository supports signup, refresh, watch, and logout',
        () async {
      final repository = MockAuthRepository(config: config);
      final user = await repository.signup(
        email: 'creator@example.com',
        password: 'secret123',
        name: 'Creator',
      );

      expect(user.email, 'creator@example.com');
      expect(await repository.currentUser(), user);
      expect(await repository.refresh(), user);
      expect(await repository.watchAuthState().first, user);

      await repository.logout();
      expect(await repository.currentUser(), isNull);
    });

    test('UserRepository updates profile in memory', () async {
      final repository = MockUserRepository(config: config);
      final user = User(
        id: 'user_custom',
        email: 'custom@example.com',
        name: 'Before',
        createdAt: now,
        updatedAt: now,
      );

      final created = await repository.updateProfile(user);
      final updated =
          await repository.updateProfile(created.copyWith(name: 'After'));

      expect(await repository.getProfile('user_custom'), updated);
      expect(updated.name, 'After');
    });

    test('ProjectRepository supports CRUD', () async {
      final repository = MockProjectRepository(config: config);
      final project = Project(
        id: 'project_custom',
        userId: 'user_custom',
        title: 'Initial title',
        createdAt: now,
        updatedAt: now,
      );

      await repository.create(project);
      expect(await repository.getById(project.id), project);

      final updated =
          await repository.update(project.copyWith(title: 'Updated title'));
      expect(updated.title, 'Updated title');
      expect(await repository.getAll(userId: 'user_custom'), contains(updated));

      await repository.delete(project.id);
      expect(await repository.getById(project.id), isNull);
    });

    test('ScriptRepository supports CRUD', () async {
      final repository = MockScriptRepository(config: config);
      final script = Script(
        id: 'script_custom',
        projectId: 'project_custom',
        content: 'Script body',
        hookOptions: const [
          HookOption(id: 'hook_custom', text: 'Stop scrolling'),
        ],
        selectedHookId: 'hook_custom',
        generatedAt: now,
      );

      await repository.create(script);
      final updated = await repository.update(script.copyWith(language: 'en'));

      expect(await repository.getById(script.id), updated);
      expect(await repository.getAll(projectId: 'project_custom'),
          contains(updated));

      await repository.delete(script.id);
      expect(await repository.getById(script.id), isNull);
    });

    test('SubtitleRepository supports CRUD', () async {
      final repository = MockSubtitleRepository(config: config);
      const subtitle = subtitle_model.Subtitle(
        id: 'subtitle_custom',
        projectId: 'project_custom',
        segments: [
          subtitle_model.SubtitleSegment(
            startMs: 0,
            endMs: 1000,
            text: 'Halo AutoShort',
          ),
        ],
      );

      await repository.create(subtitle);
      final updated =
          await repository.update(subtitle.copyWith(language: 'en'));

      expect(await repository.getById(subtitle.id), updated);
      expect(await repository.getAll(projectId: 'project_custom'),
          contains(updated));

      await repository.delete(subtitle.id);
      expect(await repository.getById(subtitle.id), isNull);
    });

    test('ThumbnailRepository supports CRUD', () async {
      final repository = MockThumbnailRepository(config: config);
      const thumbnail = Thumbnail(
        id: 'thumbnail_custom',
        projectId: 'project_custom',
        imageUrl: 'https://cdn.example.com/a.jpg',
      );

      await repository.create(thumbnail);
      final updated = await repository.update(
        thumbnail.copyWith(selectedVariant: ThumbnailVariant.b),
      );

      expect(await repository.getById(thumbnail.id), updated);
      expect(await repository.getAll(projectId: 'project_custom'),
          contains(updated));

      await repository.delete(thumbnail.id);
      expect(await repository.getById(thumbnail.id), isNull);
    });

    test('TemplateRepository is read-only and filters categories', () async {
      final repository = MockTemplateRepository(config: config);
      final templates = await repository.getAll();
      final first = templates.first;

      expect(templates.length, greaterThanOrEqualTo(5));
      expect(await repository.getById(first.id), first);
      expect(
        await repository.getByCategory(first.category),
        everyElement(isA<template_model.Template>()),
      );
    });

    test('SubscriptionRepository supports create, update, and cancel',
        () async {
      final repository = MockSubscriptionRepository(config: config);
      final subscription = Subscription(
        id: 'subscription_custom',
        userId: 'user_custom',
        tier: SubscriptionTier.standard,
        startedAt: now,
      );

      await repository.create(subscription);
      final updated = await repository.update(
        subscription.copyWith(tier: SubscriptionTier.premium),
      );
      await repository.cancel(subscription.id);

      final cancelled = await repository.getById(subscription.id);
      expect(updated.tier, SubscriptionTier.premium);
      expect(cancelled?.status, SubscriptionStatus.cancelled);
      expect(await repository.getByUserId('user_custom'), cancelled);
    });

    test('ReferralRepository supports CRUD', () async {
      final repository = MockReferralRepository(config: config);
      final referral = Referral(
        id: 'referral_custom',
        referrerUserId: 'user_a',
        refereeUserId: 'user_b',
      );

      await repository.create(referral);
      final updated = await repository.update(
        referral.copyWith(status: ReferralStatus.confirmed),
      );

      expect(await repository.getById(referral.id), updated);
      expect(
          await repository.getAll(referrerUserId: 'user_a'), contains(updated));

      await repository.delete(referral.id);
      expect(await repository.getById(referral.id), isNull);
    });

    test('BrandKitRepository supports CRUD', () async {
      final repository = MockBrandKitRepository(config: config);
      const brandKit = BrandKit(
        id: 'brand_custom',
        userId: 'user_custom',
        primaryColor: '#D4AF37',
      );

      await repository.create(brandKit);
      final updated = await repository.update(
        brandKit.copyWith(primaryFont: 'Inter Tight'),
      );

      expect(await repository.getById(brandKit.id), updated);
      expect(await repository.getByUserId('user_custom'), updated);

      await repository.delete(brandKit.id);
      expect(await repository.getById(brandKit.id), isNull);
    });

    test('AnalyticsRepository tracks events and returns user stats', () async {
      final repository = MockAnalyticsRepository(config: config);
      final event = AnalyticsEvent(
        id: 'event_custom',
        userId: 'user_custom',
        eventName: 'project_created',
        properties: const {'source': 'test'},
        timestamp: now,
      );

      await repository.trackEvent(event);

      expect(
          await repository.getEvents(userId: 'user_custom'), contains(event));
      final stats = await repository.getUserStats('user_custom');
      expect(stats.totalEvents, 1);
      expect(stats.projectCreatedCount, 1);
      expect(stats.lastEventAt, now);
    });

    test('NotificationRepository supports CRUD and markRead', () async {
      final repository = MockNotificationRepository(config: config);
      final notification = AppNotification(
        id: 'notification_custom',
        userId: 'user_custom',
        title: 'Ready',
        body: 'Your short is ready.',
        createdAt: now,
      );

      await repository.create(notification);
      final updated =
          await repository.update(notification.copyWith(type: 'success'));
      final read = await repository.markRead(notification.id);

      expect(updated.type, 'success');
      expect(read.isRead, isTrue);
      expect(await repository.getAll(userId: 'user_custom'), contains(read));
      expect(await repository.getAll(userId: 'user_custom', unreadOnly: true),
          isEmpty);

      await repository.delete(notification.id);
      expect(await repository.getById(notification.id), isNull);
    });
  });

  test('repository providers expose mock implementations', () {
    final container = ProviderContainer();
    addTearDown(container.dispose);

    expect(container.read(authRepositoryProvider), isA<AuthRepository>());
    expect(container.read(userRepositoryProvider), isA<UserRepository>());
    expect(container.read(projectRepositoryProvider), isA<ProjectRepository>());
    expect(container.read(scriptRepositoryProvider), isA<ScriptRepository>());
    expect(
        container.read(subtitleRepositoryProvider), isA<SubtitleRepository>());
    expect(container.read(thumbnailRepositoryProvider),
        isA<ThumbnailRepository>());
    expect(
        container.read(templateRepositoryProvider), isA<TemplateRepository>());
    expect(
      container.read(subscriptionRepositoryProvider),
      isA<SubscriptionRepository>(),
    );
    expect(
        container.read(referralRepositoryProvider), isA<ReferralRepository>());
    expect(
        container.read(brandKitRepositoryProvider), isA<BrandKitRepository>());
    expect(container.read(analyticsRepositoryProvider),
        isA<AnalyticsRepository>());
    expect(
      container.read(notificationRepositoryProvider),
      isA<NotificationRepository>(),
    );
  });
}
