class AppRoutes {
  AppRoutes._();

  // Auth
  static const splash = '/';
  static const onboarding = '/onboarding';
  static const login = '/login';
  static const signup = '/signup';
  static const forgotPassword = '/forgot-password';
  static const otpVerify = '/otp-verify';
  static const resetPassword = '/reset-password';

  // Main app
  static const home = '/home';
  static const library = '/library';
  static const create = '/create';
  static const analytics = '/analytics';
  static const profile = '/profile';

  // Features
  static const miniEditor = '/editor/:videoId';
  static const subtitleStudio = '/editor/:videoId/subtitle';
  static const thumbnailEditor = '/editor/:videoId/thumbnail';
  static const templateLibrary = '/templates';
  static const templateDetail = '/templates/:templateId';
  static const hookGenerator = '/tools/hook-generator';
  static const brandKit = '/brand-kit';
  static const contentCalendar = '/calendar';

  // Monetization
  static const pricing = '/pricing';
  static const checkout = '/checkout';
  static const referral = '/referral';

  // Settings
  static const settings = '/settings';
  static const accountSettings = '/settings/account';
  static const notificationSettings = '/settings/notifications';
  static const privacySettings = '/settings/privacy';
  static const about = '/about';

  // Debug only
  static const devComponents = '/dev/components';

  static const mainTabs = [home, library, create, analytics, profile];

  static const authEntryRoutes = {
    onboarding,
    login,
    signup,
    forgotPassword,
    otpVerify,
    resetPassword,
  };

  static const publicRoutes = {
    splash,
    onboarding,
    login,
    signup,
    forgotPassword,
    otpVerify,
    resetPassword,
  };

  static bool isPublicPath(String path) => publicRoutes.contains(path);

  static bool isMainTab(String path) => mainTabs.contains(path);

  static String miniEditorPath(String videoId) => '/editor/$videoId';

  static String subtitleStudioPath(String videoId) =>
      '/editor/$videoId/subtitle';

  static String thumbnailEditorPath(String videoId) =>
      '/editor/$videoId/thumbnail';

  static String templateDetailPath(String templateId) =>
      '/templates/$templateId';

  static String otpVerifyPath({
    required String email,
    required String flow,
  }) {
    return Uri(
      path: otpVerify,
      queryParameters: {
        'email': email,
        'flow': flow,
      },
    ).toString();
  }

  static String resetPasswordPath({required String email}) {
    return Uri(
      path: resetPassword,
      queryParameters: {'email': email},
    ).toString();
  }
}
