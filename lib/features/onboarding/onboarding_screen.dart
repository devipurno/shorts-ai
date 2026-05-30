import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../core/theme/app_colors.dart';
import '../../core/theme/app_spacing.dart';
import '../../core/theme/app_typography.dart';
import '../../routing/routes.dart';
import '../../shared/widgets/animation/fade_slide.dart';
import '../../shared/widgets/buttons/app_button.dart';
import '../auth/providers/auth_provider.dart';
import 'providers/onboarding_provider.dart';
import 'steps/step_goals.dart';
import 'steps/step_language.dart';
import 'steps/step_niche.dart';
import 'steps/step_tier.dart';
import 'steps/step_welcome.dart';

class OnboardingScreen extends ConsumerStatefulWidget {
  const OnboardingScreen({super.key});

  @override
  ConsumerState<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends ConsumerState<OnboardingScreen> {
  late final PageController _pageController;

  static const _steps = [
    StepWelcome(),
    StepNiche(),
    StepGoals(),
    StepLanguage(),
    StepTier(),
  ];

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  Future<void> _skip() async {
    await ref.read(onboardingProvider.notifier).complete();
    if (!mounted) {
      return;
    }
    context.go(AppRoutes.login);
  }

  Future<void> _continue() async {
    final state = ref.read(onboardingProvider);
    final notifier = ref.read(onboardingProvider.notifier);

    if (state.currentStep < _steps.length - 1) {
      notifier.nextStep();
      await _pageController.nextPage(
        duration: const Duration(milliseconds: 280),
        curve: Curves.easeOutCubic,
      );
      return;
    }

    await notifier.complete();
    if (!mounted) {
      return;
    }

    final authState = ref.read(authProvider);
    context.go(authState is Authenticated ? AppRoutes.home : AppRoutes.login);
  }

  Future<void> _back() async {
    final state = ref.read(onboardingProvider);
    if (state.currentStep <= 0) {
      return;
    }

    ref.read(onboardingProvider.notifier).prevStep();
    await _pageController.previousPage(
      duration: const Duration(milliseconds: 240),
      curve: Curves.easeOutCubic,
    );
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(onboardingProvider);

    return Scaffold(
      key: const Key('onboarding-screen'),
      backgroundColor: AppColors.obsidian,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.xl),
          child: Column(
            children: [
              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  key: const Key('onboarding-skip'),
                  onPressed: state.isCompleting ? null : _skip,
                  child: Text(
                    'Skip',
                    style: AppTypography.labelLarge.copyWith(
                      color: AppColors.gold,
                    ),
                  ),
                ),
              ),
              Expanded(
                child: PageView.builder(
                  key: const Key('onboarding-page-view'),
                  controller: _pageController,
                  onPageChanged: (index) {
                    ref.read(onboardingProvider.notifier).setStep(index);
                  },
                  itemCount: _steps.length,
                  itemBuilder: (context, index) {
                    return FadeSlide(
                      key: ValueKey('onboarding-fade-$index'),
                      child: SingleChildScrollView(
                        physics: const BouncingScrollPhysics(),
                        child: ConstrainedBox(
                          constraints: BoxConstraints(
                            minHeight: MediaQuery.sizeOf(context).height * 0.62,
                          ),
                          child: _steps[index],
                        ),
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(height: AppSpacing.lg),
              _ProgressDots(
                currentStep: state.currentStep,
                totalSteps: _steps.length,
              ),
              const SizedBox(height: AppSpacing.lg),
              AppButton(
                key: const Key('onboarding-continue'),
                label: state.currentStep == _steps.length - 1
                    ? 'Mulai'
                    : 'Continue',
                fullWidth: true,
                isLoading: state.isCompleting,
                onPressed: state.isCompleting ? null : _continue,
              ),
              const SizedBox(height: AppSpacing.md),
              TextButton(
                key: const Key('onboarding-back'),
                onPressed:
                    state.currentStep == 0 || state.isCompleting ? null : _back,
                child: Text(
                  'Back',
                  style: AppTypography.labelLarge.copyWith(
                    color: state.currentStep == 0
                        ? AppColors.textTertiary
                        : AppColors.gold,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ProgressDots extends StatelessWidget {
  const _ProgressDots({
    required this.currentStep,
    required this.totalSteps,
  });

  final int currentStep;
  final int totalSteps;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        for (var index = 0; index < totalSteps; index++)
          AnimatedContainer(
            key: Key('onboarding-dot-$index'),
            duration: const Duration(milliseconds: 180),
            width: currentStep == index ? 22 : 8,
            height: 8,
            margin: const EdgeInsets.symmetric(horizontal: AppSpacing.xs),
            decoration: BoxDecoration(
              color: currentStep == index ? AppColors.gold : AppColors.surface3,
              borderRadius: BorderRadius.circular(999),
            ),
          ),
      ],
    );
  }
}
