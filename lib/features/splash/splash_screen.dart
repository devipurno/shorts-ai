import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:lottie/lottie.dart';

import '../../core/constants/asset_paths.dart';
import '../../core/theme/app_colors.dart';
import '../../core/utils/logger.dart';
import '../../core/theme/app_spacing.dart';
import '../../core/theme/app_typography.dart';
import '../../routing/routes.dart';
import '../../shared/services/providers.dart';
import '../../shared/widgets/brand/app_logo.dart';
import '../auth/providers/auth_provider.dart';
import '../onboarding/providers/onboarding_provider.dart';

class SplashScreen extends ConsumerStatefulWidget {
  const SplashScreen({
    super.key,
    this.navigationDelay = const Duration(seconds: 2),
  });

  final Duration navigationDelay;

  @override
  ConsumerState<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends ConsumerState<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future<void>.delayed(widget.navigationDelay, _navigateNext);
  }

  Future<void> _navigateNext() async {
    if (!mounted) {
      return;
    }

    var hasCompletedOnboarding = false;
    try {
      final preferences = await ref.read(preferencesServiceProvider.future);
      hasCompletedOnboarding =
          preferences.getBool(hasCompletedOnboardingKey) ?? false;
    } catch (error, stackTrace) {
      AppLogger.w(
        'Failed to read onboarding preference, defaulting to false',
        tag: 'Splash',
        error: error,
        stackTrace: stackTrace,
      );
      hasCompletedOnboarding = false;
    }

    if (!mounted) {
      return;
    }

    if (!hasCompletedOnboarding) {
      context.go(AppRoutes.onboarding);
      return;
    }

    final authState = ref.read(authProvider);
    final target =
        authState is Authenticated ? AppRoutes.home : AppRoutes.login;
    context.go(target);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: const Key('splash-screen'),
      backgroundColor: AppColors.obsidian,
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(AppSpacing.xl),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const AppLogo(
                  variant: AppLogoVariant.wordmark,
                  size: AppLogoSize.lg,
                )
                    .animate()
                    .fadeIn(duration: 600.ms, curve: Curves.easeOutCubic)
                    .slideY(
                      begin: 0.12,
                      end: 0,
                      duration: 600.ms,
                      curve: Curves.easeOutCubic,
                    ),
                const SizedBox(height: AppSpacing.xl),
                Lottie.asset(
                  AssetPaths.splashLoader,
                  width: 88,
                  height: 88,
                  repeat: false,
                ),
                const SizedBox(height: AppSpacing.lg),
                Text(
                  'Preparing your studio',
                  style: AppTypography.bodySmall.copyWith(
                    color: AppColors.textTertiary,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
