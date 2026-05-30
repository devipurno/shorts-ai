import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../core/constants/asset_paths.dart';

enum AppLogoVariant { monogram, wordmark }

enum AppLogoSize { sm, md, lg }

class AppLogo extends StatelessWidget {
  const AppLogo({
    super.key,
    this.variant = AppLogoVariant.wordmark,
    this.size = AppLogoSize.md,
  });

  final AppLogoVariant variant;
  final AppLogoSize size;

  @override
  Widget build(BuildContext context) {
    final dimensions = _LogoDimensions.from(variant, size);
    return SvgPicture.asset(
      switch (variant) {
        AppLogoVariant.monogram => AssetPaths.logoMonogram,
        AppLogoVariant.wordmark => AssetPaths.logoWordmark,
      },
      width: dimensions.width,
      height: dimensions.height,
      fit: BoxFit.contain,
      semanticsLabel: switch (variant) {
        AppLogoVariant.monogram => 'AutoShort monogram',
        AppLogoVariant.wordmark => 'AutoShort wordmark',
      },
    );
  }
}

class _LogoDimensions {
  const _LogoDimensions({
    required this.width,
    required this.height,
  });

  final double width;
  final double height;

  static _LogoDimensions from(AppLogoVariant variant, AppLogoSize size) {
    if (variant == AppLogoVariant.monogram) {
      return switch (size) {
        AppLogoSize.sm => const _LogoDimensions(width: 40, height: 40),
        AppLogoSize.md => const _LogoDimensions(width: 64, height: 64),
        AppLogoSize.lg => const _LogoDimensions(width: 96, height: 96),
      };
    }

    return switch (size) {
      AppLogoSize.sm => const _LogoDimensions(width: 128, height: 32),
      AppLogoSize.md => const _LogoDimensions(width: 192, height: 48),
      AppLogoSize.lg => const _LogoDimensions(width: 280, height: 70),
    };
  }
}
