// ignore_for_file: constant_identifier_names, non_constant_identifier_names

import 'package:package_info_plus/package_info_plus.dart';

class AppConstants {
  AppConstants._();

  static const String APP_NAME = 'AutoShort';
  static String APP_VERSION = '0.1.0';

  static const Duration DEFAULT_TIMEOUT = Duration(seconds: 30);
  static const int MAX_VIDEO_SIZE_MB = 500;
  static const List<String> SUPPORTED_VIDEO_FORMATS = ['mp4', 'mov', 'avi'];

  static const int MAX_SHORT_DURATION_SECONDS = 120;
  static const int FREE_TRIAL_DAYS = 14;
  static const int STANDARD_PRICE_IDR = 30000;
  static const int PREMIUM_PRICE_IDR = 120000;
  static const int LIFETIME_PRICE_IDR = 1500000;

  static const String PHASE_ZERO_ORG = 'com.dayscent.shortsai';
  static const String PHASE_ONE_FIVE_ORG = 'com.autoshort.app';
  static const String HOT_STORAGE_PROVIDER = 'Cloudflare R2';
  static const String COLD_STORAGE_PROVIDER = 'Backblaze B2';
  static const String TARGET_REGION_PRIMARY = 'Indonesia';
  static const String TARGET_REGION_SECONDARY = 'Singapore';

  static Future<void> init() async {
    try {
      final info = await PackageInfo.fromPlatform();
      APP_VERSION = info.version;
    } catch (_) {
      APP_VERSION = '0.1.0';
    }
  }

  static void overrideVersionForTest(String version) {
    APP_VERSION = version;
  }
}
