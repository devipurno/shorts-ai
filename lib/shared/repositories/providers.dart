import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/env/env.dart';
import '../services/supabase_service.dart';
import 'analytics_repository.dart';
import 'api/api_analytics_repository.dart';
import 'api/api_brand_kit_repository.dart';
import 'api/api_notification_repository.dart';
import 'api/api_project_repository.dart';
import 'api/api_referral_repository.dart';
import 'api/api_script_repository.dart';
import 'api/api_subscription_repository.dart';
import 'api/api_subtitle_repository.dart';
import 'api/api_template_repository.dart';
import 'api/api_thumbnail_repository.dart';
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
bool get _shouldUseApi => Env.useApiRepositories;

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
  if (_shouldUseApi) {
    return ApiProjectRepository();
  }
  return MockProjectRepository();
});

final scriptRepositoryProvider = Provider<ScriptRepository>((ref) {
  if (_shouldUseApi) {
    return ApiScriptRepository();
  }
  return MockScriptRepository();
});

final subtitleRepositoryProvider = Provider<SubtitleRepository>((ref) {
  if (_shouldUseApi) {
    return ApiSubtitleRepository();
  }
  return MockSubtitleRepository();
});

final thumbnailRepositoryProvider = Provider<ThumbnailRepository>((ref) {
  if (_shouldUseApi) {
    return ApiThumbnailRepository();
  }
  return MockThumbnailRepository();
});

final templateRepositoryProvider = Provider<TemplateRepository>((ref) {
  if (_shouldUseApi) {
    return ApiTemplateRepository();
  }
  return MockTemplateRepository();
});

final subscriptionRepositoryProvider = Provider<SubscriptionRepository>((ref) {
  if (_shouldUseApi) {
    return ApiSubscriptionRepository();
  }
  return MockSubscriptionRepository();
});

final referralRepositoryProvider = Provider<ReferralRepository>((ref) {
  if (_shouldUseApi) {
    return ApiReferralRepository();
  }
  return MockReferralRepository();
});

final brandKitRepositoryProvider = Provider<BrandKitRepository>((ref) {
  if (_shouldUseApi) {
    return ApiBrandKitRepository();
  }
  return MockBrandKitRepository();
});

final analyticsRepositoryProvider = Provider<AnalyticsRepository>((ref) {
  if (_shouldUseApi) {
    return ApiAnalyticsRepository();
  }
  return MockAnalyticsRepository();
});

final notificationRepositoryProvider = Provider<NotificationRepository>((ref) {
  if (_shouldUseApi) {
    return ApiNotificationRepository();
  }
  return MockNotificationRepository();
});
