import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../shared/models/user.dart' as shared_user;
import '../../../shared/repositories/providers.dart';
import '../../../shared/services/providers.dart';
import '../../auth/providers/auth_provider.dart';
import '../models/onboarding_data.dart';

part 'onboarding_provider.freezed.dart';

const hasCompletedOnboardingKey = 'onboarding.has_completed';
const onboardingDataKey = 'onboarding.data';

const onboardingNiches = [
  'Lifestyle',
  'Tech',
  'Food',
  'Fitness',
  'Finance',
  'Education',
  'Entertainment',
];

const onboardingGoals = [
  'Grow audience',
  'Monetize',
  'Personal brand',
  'Learn skills',
  'Side hustle',
  'Have fun',
];

const onboardingLanguages = [
  'Bahasa Indonesia',
  'English',
  'Bilingual',
];

const onboardingTiers = [
  'Free',
  'Standard',
  'Premium',
  'Lifetime',
];

@freezed
abstract class OnboardingState with _$OnboardingState {
  const factory OnboardingState({
    @Default(0) int currentStep,
    String? niche,
    @Default(<String>[]) List<String> goals,
    String? language,
    String? selectedTier,
    @Default(false) bool isCompleting,
  }) = _OnboardingState;
}

final onboardingProvider =
    StateNotifierProvider<OnboardingNotifier, OnboardingState>((ref) {
  return OnboardingNotifier(ref);
});

class OnboardingNotifier extends StateNotifier<OnboardingState> {
  OnboardingNotifier(this._ref) : super(const OnboardingState());

  static const totalSteps = 5;
  static const maxGoals = 3;

  final Ref _ref;

  void setNiche(String niche) {
    state = state.copyWith(niche: niche);
  }

  void toggleGoal(String goal) {
    final goals = [...state.goals];
    if (goals.contains(goal)) {
      goals.remove(goal);
    } else if (goals.length < maxGoals) {
      goals.add(goal);
    }
    state = state.copyWith(goals: goals);
  }

  void setLanguage(String language) {
    state = state.copyWith(language: language);
  }

  void setTier(String tier) {
    state = state.copyWith(selectedTier: tier);
  }

  void setStep(int step) {
    final normalized = step.clamp(0, totalSteps - 1).toInt();
    state = state.copyWith(currentStep: normalized);
  }

  void nextStep() {
    if (state.currentStep >= totalSteps - 1) {
      return;
    }
    state = state.copyWith(currentStep: state.currentStep + 1);
  }

  void prevStep() {
    if (state.currentStep <= 0) {
      return;
    }
    state = state.copyWith(currentStep: state.currentStep - 1);
  }

  Future<OnboardingData> complete() async {
    state = state.copyWith(isCompleting: true);

    try {
      final completedAt = DateTime.now().toUtc();
      final data = OnboardingData(
        niche: state.niche,
        goals: state.goals,
        language: state.language,
        selectedTier: state.selectedTier,
        completedAt: completedAt,
      );

      final preferences = await _ref.read(preferencesServiceProvider.future);
      await preferences.setBool(hasCompletedOnboardingKey, true);
      await preferences.setString(onboardingDataKey, jsonEncode(data.toJson()));

      final userRepository = _ref.read(userRepositoryProvider);
      await userRepository.updateProfile(_profileFromState(completedAt));

      return data;
    } finally {
      state = state.copyWith(isCompleting: false);
    }
  }

  shared_user.User _profileFromState(DateTime completedAt) {
    final authState = _ref.read(authProvider);
    final authUser = authState is Authenticated ? authState.user : null;
    final tier = _tierFromLabel(state.selectedTier);

    return shared_user.User(
      id: authUser?.id ?? 'onboarding_guest',
      email: authUser?.email ?? 'guest@autoshort.local',
      name: authUser?.name ?? 'AutoShort Creator',
      locale: _localeFromLanguage(state.language),
      timezone: 'Asia/Bangkok',
      tier: tier,
      createdAt: authUser?.createdAt.toUtc() ?? completedAt,
      updatedAt: completedAt,
    );
  }

  shared_user.SubscriptionTier _tierFromLabel(String? tier) {
    return switch (tier) {
      'Standard' => shared_user.SubscriptionTier.standard,
      'Premium' => shared_user.SubscriptionTier.premium,
      'Lifetime' => shared_user.SubscriptionTier.lifetime,
      _ => shared_user.SubscriptionTier.free,
    };
  }

  String _localeFromLanguage(String? language) {
    return switch (language) {
      'English' => 'en_US',
      'Bilingual' => 'id_ID,en_US',
      _ => 'id_ID',
    };
  }
}
