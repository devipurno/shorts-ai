import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/env/env.dart';
import '../services/supabase_service.dart';
import 'analytics_repository.dart';
import 'auth_repository.dart';
import 'brand_kit_repository.dart';
import 'mock/mock_analytics_repository.dart';
import 'mock/mock_auth_repository.dart';
import 'mock/mock_brand_kit_repository.dart';
import 'mock/mock_notification_repository.dart';
import 'mock/mock_project_repository.dart';
import 'mock/mock_referral_repository.dart';
import 'mock/mock_script_repository.dart';
import 'mock/mock_subtitle_repository.dart';
import 'mock/mock_subscription_repository.dart';
import 'mock/mock_template_repository.dart';
import 'mock/mock_thumbnail_repository.dart';
import 'mock/mock_user_repository.dart';
import 'notification_repository.dart';
import 'project_repository.dart';
import 'referral_repository.dart';
import 'script_repository.dart';
import 'subtitle_repository.dart';
import 'subscription_repository.dart';
import 'supabase/supabase_auth_repository.dart';
import 'supabase/supabase_user_repository.dart';
import 'template_repository.dart';
import 'thumbnail_repository.dart';
import 'user_repository.dart';

bool get _shouldUseSupabase => Env.useSupabase && SupabaseService.isInitialized;

final authRepositoryProvider = Provider<AuthRepository>((ref) {
  if (_shouldUseSupabase) {
    return SupabaseAuthRepository();
  }
  return MockAuthRepository();
});

final userRepositoryProvider = Provider<UserRepository>((ref) {
  if (_shouldUseSupabase) {
    return SupabaseUserRepository();
  }
  return MockUserRepository();
});

final projectRepositoryProvider = Provider<ProjectRepository>((ref) {
  return MockProjectRepository();
});

final scriptRepositoryProvider = Provider<ScriptRepository>((ref) {
  return MockScriptRepository();
});

final subtitleRepositoryProvider = Provider<SubtitleRepository>((ref) {
  return MockSubtitleRepository();
});

final thumbnailRepositoryProvider = Provider<ThumbnailRepository>((ref) {
  return MockThumbnailRepository();
});

final templateRepositoryProvider = Provider<TemplateRepository>((ref) {
  return MockTemplateRepository();
});

final subscriptionRepositoryProvider = Provider<SubscriptionRepository>((ref) {
  return MockSubscriptionRepository();
});

final referralRepositoryProvider = Provider<ReferralRepository>((ref) {
  return MockReferralRepository();
});

final brandKitRepositoryProvider = Provider<BrandKitRepository>((ref) {
  return MockBrandKitRepository();
});

final analyticsRepositoryProvider = Provider<AnalyticsRepository>((ref) {
  return MockAnalyticsRepository();
});

final notificationRepositoryProvider = Provider<NotificationRepository>((ref) {
  return MockNotificationRepository();
});
