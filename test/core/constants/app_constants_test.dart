import 'package:flutter_test/flutter_test.dart';
import 'package:shorts_ai/core/constants/app_constants.dart';

void main() {
  test('exposes app constants from PRD baseline', () {
    AppConstants.overrideVersionForTest('9.9.9');

    expect(AppConstants.APP_NAME, 'AutoShort');
    expect(AppConstants.APP_VERSION, '9.9.9');
    expect(AppConstants.DEFAULT_TIMEOUT, const Duration(seconds: 30));
    expect(AppConstants.MAX_VIDEO_SIZE_MB, 500);
    expect(AppConstants.SUPPORTED_VIDEO_FORMATS, ['mp4', 'mov', 'avi']);
    expect(AppConstants.STANDARD_PRICE_IDR, 30000);
    expect(AppConstants.PREMIUM_PRICE_IDR, 120000);
    expect(AppConstants.LIFETIME_PRICE_IDR, 1500000);
  });
}
