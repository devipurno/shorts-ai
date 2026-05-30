import 'package:flutter_test/flutter_test.dart';
import 'package:shorts_ai/shared/models/analytics_event.dart';
import 'package:shorts_ai/shared/models/brand_kit.dart';
import 'package:shorts_ai/shared/models/notification.dart';
import 'package:shorts_ai/shared/models/profile.dart';
import 'package:shorts_ai/shared/models/project.dart';
import 'package:shorts_ai/shared/models/referral.dart';
import 'package:shorts_ai/shared/models/script.dart';
import 'package:shorts_ai/shared/models/subscription.dart';
import 'package:shorts_ai/shared/models/subtitle.dart' as subtitle_model;
import 'package:shorts_ai/shared/models/template.dart';
import 'package:shorts_ai/shared/models/thumbnail.dart';
import 'package:shorts_ai/shared/models/user.dart' as user_model;

void main() {
  group('shared data models', () {
    final createdAt = DateTime.utc(2026, 5, 30, 3, 15);
    final updatedAt = DateTime.utc(2026, 5, 30, 4, 30);

    test('User JSON round-trip uses snake_case keys', () {
      final user = user_model.User(
        id: 'user_1',
        email: 'devi@example.com',
        name: 'Devi',
        avatarUrl: 'https://cdn.example.com/avatar.jpg',
        phoneNumber: '+628123456789',
        tier: user_model.SubscriptionTier.premium,
        subscriptionId: 'sub_1',
        subscriptionExpiresAt: updatedAt,
        trialStartedAt: createdAt,
        trialEndsAt: updatedAt,
        trialDaysRemaining: 7,
        referralCode: 'DEVI100',
        referredByUserId: 'user_0',
        createdAt: createdAt,
        updatedAt: updatedAt,
        lastLoginAt: updatedAt,
      );

      final json = user.toJson();

      expect(json['avatar_url'], user.avatarUrl);
      expect(json['phone_number'], user.phoneNumber);
      expect(json['subscription_expires_at'], updatedAt.toIso8601String());
      expect(json['trial_days_remaining'], 7);
      expect(json['tier'], 'premium');
      expect(user_model.User.fromJson(json), user);
    });

    test('CreatorProfile JSON round-trip uses social handle keys', () {
      const profile = CreatorProfile(
        userId: 'user_1',
        displayName: 'Devi Purnomo',
        bio: 'Creator edukasi AI',
        instagramHandle: '@devi',
        youtubeHandle: '@deviyt',
        tiktokHandle: '@devitok',
        niche: CreatorNiche.education,
        targetAudience: 'Indonesian creators',
        contentLanguage: 'id',
        brandKitId: 'brand_1',
      );

      final json = profile.toJson();

      expect(json['user_id'], 'user_1');
      expect(json['display_name'], 'Devi Purnomo');
      expect(json['instagram_handle'], '@devi');
      expect(json['content_language'], 'id');
      expect(json['niche'], 'education');
      expect(CreatorProfile.fromJson(json), profile);
    });

    test('Project JSON round-trip preserves publication metadata', () {
      final project = Project(
        id: 'project_1',
        userId: 'user_1',
        title: 'Launch Shorts',
        description: 'Campaign batch',
        status: ProjectStatus.ready,
        originalVideoUrl: 'https://cdn.example.com/original.mp4',
        processedVideoUrl: 'https://cdn.example.com/final.mp4',
        thumbnailUrl: 'https://cdn.example.com/thumb.jpg',
        duration: 42,
        aspectRatio: '9:16',
        resolution: '1080x1920',
        templateId: 'template_1',
        brandKitId: 'brand_1',
        tags: const ['ai', 'shorts'],
        createdAt: createdAt,
        updatedAt: updatedAt,
        publishedAt: updatedAt,
      );

      final json = project.toJson();

      expect(json['user_id'], 'user_1');
      expect(json['original_video_url'], project.originalVideoUrl);
      expect(json['processed_video_url'], project.processedVideoUrl);
      expect(json['published_at'], updatedAt.toIso8601String());
      expect(json['status'], 'ready');
      expect(Project.fromJson(json), project);
    });

    test('Script JSON round-trip preserves hook options', () {
      final script = Script(
        id: 'script_1',
        projectId: 'project_1',
        content: 'Opening hook and body.',
        hookOptions: const [
          HookOption(
            id: 'hook_1',
            text: 'Kamu masih edit manual?',
            style: HookStyle.question,
            score: 91,
          ),
        ],
        selectedHookId: 'hook_1',
        language: 'id',
        durationEstimate: 35,
        aiModelUsed: 'gpt-4o-mini',
        generatedAt: createdAt,
      );

      final json = script.toJson();

      expect(json['project_id'], 'project_1');
      expect(json['hook_options'], isA<List<dynamic>>());
      expect((json['hook_options'] as List).first['style'], 'question');
      expect(json['ai_model_used'], 'gpt-4o-mini');
      expect(Script.fromJson(json), script);
    });

    test('Subtitle JSON round-trip preserves segments, words, and style', () {
      const subtitle = subtitle_model.Subtitle(
        id: 'subtitle_1',
        projectId: 'project_1',
        language: 'id',
        format: subtitle_model.SubtitleFormat.ass,
        segments: [
          subtitle_model.SubtitleSegment(
            startMs: 0,
            endMs: 1200,
            text: 'Halo dunia',
            words: [
              subtitle_model.Word(text: 'Halo', startMs: 0, endMs: 500),
              subtitle_model.Word(text: 'dunia', startMs: 520, endMs: 1200),
            ],
          ),
        ],
        style: subtitle_model.SubtitleStyle(
          fontFamily: 'Inter',
          fontSize: 44,
          fontColor: '#FFFFFF',
          strokeColor: '#0B0C10',
          position: 'bottom',
          animation: 'karaoke',
        ),
      );

      final json = subtitle.toJson();

      expect(json['project_id'], 'project_1');
      expect((json['segments'] as List).first['start_ms'], 0);
      expect((json['segments'] as List).first['words'], isA<List<dynamic>>());
      expect((json['style'] as Map)['font_family'], 'Inter');
      expect(subtitle_model.Subtitle.fromJson(json), subtitle);
    });

    test('Thumbnail JSON round-trip preserves A/B selection data', () {
      const thumbnail = Thumbnail(
        id: 'thumb_1',
        projectId: 'project_1',
        imageUrl: 'https://cdn.example.com/a.jpg',
        isVariantA: false,
        variantBImageUrl: 'https://cdn.example.com/b.jpg',
        ctrPrediction: 0.82,
        selectedVariant: ThumbnailVariant.b,
      );

      final json = thumbnail.toJson();

      expect(json['image_url'], thumbnail.imageUrl);
      expect(json['is_variant_a'], false);
      expect(json['variant_b_image_url'], thumbnail.variantBImageUrl);
      expect(json['selected_variant'], 'b');
      expect(Thumbnail.fromJson(json), thumbnail);
    });

    test('Template JSON round-trip preserves structure', () {
      const template = Template(
        id: 'template_1',
        name: 'Podcast Split',
        description: 'Split speaker layout',
        category: 'podcast',
        thumbnailUrl: 'https://cdn.example.com/template.jpg',
        previewVideoUrl: 'https://cdn.example.com/template.mp4',
        structure: TemplateStructure(
          duration: 45,
          hooks: ['question'],
          segments: ['intro', 'proof', 'cta'],
          transitions: ['cut', 'zoom'],
          music: ['ambient'],
        ),
        difficulty: TemplateDifficulty.medium,
        tier: TemplateTier.premium,
        timesUsed: 12,
        rating: 4.8,
      );

      final json = template.toJson();

      expect(json['thumbnail_url'], template.thumbnailUrl);
      expect(json['preview_video_url'], template.previewVideoUrl);
      expect((json['structure'] as Map)['segments'], ['intro', 'proof', 'cta']);
      expect(json['difficulty'], 'medium');
      expect(Template.fromJson(json), template);
    });

    test('Subscription JSON round-trip preserves billing source', () {
      final subscription = Subscription(
        id: 'sub_1',
        userId: 'user_1',
        tier: user_model.SubscriptionTier.lifetime,
        status: SubscriptionStatus.active,
        startedAt: createdAt,
        expiresAt: null,
        cancelledAt: null,
        paymentMethod: 'midtrans',
        autoRenew: false,
        source: SubscriptionSource.referralCredit,
      );

      final json = subscription.toJson();

      expect(json['user_id'], 'user_1');
      expect(json['started_at'], createdAt.toIso8601String());
      expect(json['auto_renew'], false);
      expect(json['source'], 'referral_credit');
      expect(Subscription.fromJson(json), subscription);
    });

    test('Referral JSON round-trip preserves reward status', () {
      final referral = Referral(
        id: 'ref_1',
        referrerUserId: 'user_1',
        refereeUserId: 'user_2',
        status: ReferralStatus.rewarded,
        rewardAmount: 30000,
        rewardedAt: updatedAt,
      );

      final json = referral.toJson();

      expect(json['referrer_user_id'], 'user_1');
      expect(json['referee_user_id'], 'user_2');
      expect(json['reward_amount'], 30000);
      expect(json['status'], 'rewarded');
      expect(Referral.fromJson(json), referral);
    });

    test('BrandKit JSON round-trip preserves video asset keys', () {
      const brandKit = BrandKit(
        id: 'brand_1',
        userId: 'user_1',
        logoUrl: 'https://cdn.example.com/logo.png',
        primaryColor: '#D4AF37',
        secondaryColor: '#0B0C10',
        accentColor: '#E6C757',
        primaryFont: 'Inter',
        secondaryFont: 'JetBrains Mono',
        watermarkUrl: 'https://cdn.example.com/watermark.png',
        watermarkPosition: 'bottom_right',
        introVideoUrl: 'https://cdn.example.com/intro.mp4',
        outroVideoUrl: 'https://cdn.example.com/outro.mp4',
      );

      final json = brandKit.toJson();

      expect(json['logo_url'], brandKit.logoUrl);
      expect(json['primary_color'], '#D4AF37');
      expect(json['intro_video_url'], brandKit.introVideoUrl);
      expect(json['outro_video_url'], brandKit.outroVideoUrl);
      expect(BrandKit.fromJson(json), brandKit);
    });

    test('AnalyticsEvent JSON round-trip preserves dynamic properties', () {
      final event = AnalyticsEvent(
        id: 'event_1',
        userId: 'user_1',
        eventName: 'project_created',
        properties: const {
          'source': 'upload',
          'duration_seconds': 42,
          'tags': ['ai', 'shorts'],
        },
        timestamp: createdAt,
      );

      final json = event.toJson();

      expect(json['user_id'], 'user_1');
      expect(json['event_name'], 'project_created');
      expect((json['properties'] as Map)['duration_seconds'], 42);
      expect(AnalyticsEvent.fromJson(json), event);
    });

    test('AppNotification JSON round-trip preserves read state', () {
      final notification = AppNotification(
        id: 'notification_1',
        userId: 'user_1',
        title: 'Short ready',
        body: 'Review your generated clip.',
        type: 'success',
        deepLink: '/library/project_1',
        isRead: true,
        createdAt: createdAt,
      );

      final json = notification.toJson();

      expect(json['user_id'], 'user_1');
      expect(json['deep_link'], '/library/project_1');
      expect(json['is_read'], true);
      expect(json['created_at'], createdAt.toIso8601String());
      expect(AppNotification.fromJson(json), notification);
    });
  });
}
