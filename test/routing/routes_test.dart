import 'package:flutter_test/flutter_test.dart';
import 'package:shorts_ai/routing/routes.dart';

void main() {
  test('exposes all AutoShort route paths', () {
    expect(AppRoutes.splash, '/');
    expect(AppRoutes.onboarding, '/onboarding');
    expect(AppRoutes.login, '/login');
    expect(AppRoutes.signup, '/signup');
    expect(AppRoutes.forgotPassword, '/forgot-password');
    expect(AppRoutes.otpVerify, '/otp-verify');
    expect(AppRoutes.home, '/home');
    expect(AppRoutes.library, '/library');
    expect(AppRoutes.create, '/create');
    expect(AppRoutes.analytics, '/analytics');
    expect(AppRoutes.profile, '/profile');
    expect(AppRoutes.miniEditor, '/editor/:videoId');
    expect(AppRoutes.subtitleStudio, '/editor/:videoId/subtitle');
    expect(AppRoutes.thumbnailEditor, '/editor/:videoId/thumbnail');
    expect(AppRoutes.templateLibrary, '/templates');
    expect(AppRoutes.templateDetail, '/templates/:templateId');
    expect(AppRoutes.hookGenerator, '/tools/hook-generator');
    expect(AppRoutes.brandKit, '/brand-kit');
    expect(AppRoutes.contentCalendar, '/calendar');
    expect(AppRoutes.pricing, '/pricing');
    expect(AppRoutes.checkout, '/checkout');
    expect(AppRoutes.referral, '/referral');
    expect(AppRoutes.settings, '/settings');
    expect(AppRoutes.accountSettings, '/settings/account');
    expect(AppRoutes.notificationSettings, '/settings/notifications');
    expect(AppRoutes.privacySettings, '/settings/privacy');
    expect(AppRoutes.about, '/about');
  });

  test('builds dynamic feature route locations', () {
    expect(AppRoutes.miniEditorPath('video-1'), '/editor/video-1');
    expect(
      AppRoutes.subtitleStudioPath('video-1'),
      '/editor/video-1/subtitle',
    );
    expect(
      AppRoutes.thumbnailEditorPath('video-1'),
      '/editor/video-1/thumbnail',
    );
    expect(AppRoutes.templateDetailPath('gold'), '/templates/gold');
  });

  test('classifies public and main tab routes', () {
    expect(AppRoutes.isPublicPath(AppRoutes.splash), isTrue);
    expect(AppRoutes.isPublicPath(AppRoutes.login), isTrue);
    expect(AppRoutes.isPublicPath(AppRoutes.home), isFalse);
    expect(AppRoutes.authEntryRoutes, contains(AppRoutes.login));
    expect(AppRoutes.authEntryRoutes, contains(AppRoutes.signup));
    expect(AppRoutes.authEntryRoutes, contains(AppRoutes.onboarding));
    expect(AppRoutes.isMainTab(AppRoutes.create), isTrue);
    expect(AppRoutes.mainTabs, hasLength(5));
  });
}
