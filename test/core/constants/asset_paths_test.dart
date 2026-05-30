import 'package:flutter_test/flutter_test.dart';
import 'package:shorts_ai/core/constants/asset_paths.dart';

void main() {
  test('exposes brand asset paths', () {
    expect(AssetPaths.logoMonogram, 'assets/logos/autoshort_logo.svg');
    expect(AssetPaths.logoWordmark, 'assets/logos/autoshort_wordmark.svg');
    expect(AssetPaths.appIcon, 'assets/icons/app_icon.png');
    expect(AssetPaths.splashLoader, 'assets/animations/splash_loader.json');
    expect(AssetPaths.emptyState, 'assets/animations/empty_state.json');
    expect(AssetPaths.successAnim, 'assets/animations/success.json');
    expect(AssetPaths.errorAnim, 'assets/animations/error.json');
  });
}
