import 'dart:async';
import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shorts_ai/features/onboarding/providers/onboarding_provider.dart';
import 'package:shorts_ai/shared/models/user.dart' as shared_user;
import 'package:shorts_ai/shared/repositories/providers.dart';
import 'package:shorts_ai/shared/repositories/user_repository.dart';
import 'package:shorts_ai/shared/services/preferences_service.dart';
import 'package:shorts_ai/shared/services/providers.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  ProviderContainer createContainer({
    required SharedPreferences preferences,
    required _RecordingUserRepository userRepository,
  }) {
    final container = ProviderContainer(
      overrides: [
        preferencesServiceProvider.overrideWith(
          (ref) async => PreferencesService(preferences),
        ),
        userRepositoryProvider.overrideWithValue(userRepository),
      ],
    );
    addTearDown(container.dispose);
    return container;
  }

  Future<
      ({
        ProviderContainer container,
        SharedPreferences preferences,
        _RecordingUserRepository userRepository
      })> createTestHarness() async {
    SharedPreferences.setMockInitialValues({});
    final preferences = await SharedPreferences.getInstance();
    final userRepository = _RecordingUserRepository();
    final container = createContainer(
      preferences: preferences,
      userRepository: userRepository,
    );

    return (
      container: container,
      preferences: preferences,
      userRepository: userRepository,
    );
  }

  test('OnboardingNotifier moves through the 5-step flow safely', () async {
    final harness = await createTestHarness();
    final notifier = harness.container.read(onboardingProvider.notifier);

    expect(harness.container.read(onboardingProvider).currentStep, 0);

    notifier.nextStep();
    notifier.nextStep();
    notifier.nextStep();
    notifier.nextStep();
    notifier.nextStep();

    expect(harness.container.read(onboardingProvider).currentStep, 4);

    notifier.prevStep();
    expect(harness.container.read(onboardingProvider).currentStep, 3);

    notifier.setStep(-10);
    expect(harness.container.read(onboardingProvider).currentStep, 0);

    notifier.setStep(99);
    expect(harness.container.read(onboardingProvider).currentStep, 4);
  });

  test('toggleGoal enforces a maximum of 3 selected goals', () async {
    final harness = await createTestHarness();
    final notifier = harness.container.read(onboardingProvider.notifier);

    for (final goal in onboardingGoals.take(4)) {
      notifier.toggleGoal(goal);
    }

    var state = harness.container.read(onboardingProvider);
    expect(state.goals, onboardingGoals.take(3));
    expect(state.goals, isNot(contains(onboardingGoals[3])));

    notifier.toggleGoal(onboardingGoals.first);

    state = harness.container.read(onboardingProvider);
    expect(state.goals.length, 2);
    expect(state.goals, isNot(contains(onboardingGoals.first)));
  });

  test('complete persists onboarding data and updates mock profile', () async {
    final harness = await createTestHarness();
    final notifier = harness.container.read(onboardingProvider.notifier);

    notifier
      ..setNiche('Tech')
      ..toggleGoal('Grow audience')
      ..toggleGoal('Monetize')
      ..setLanguage('Bilingual')
      ..setTier('Premium');

    final data = await notifier.complete();

    expect(data.niche, 'Tech');
    expect(data.goals, ['Grow audience', 'Monetize']);
    expect(data.language, 'Bilingual');
    expect(data.selectedTier, 'Premium');
    expect(
      harness.preferences.getBool(hasCompletedOnboardingKey),
      isTrue,
    );

    final persisted = jsonDecode(
      harness.preferences.getString(onboardingDataKey)!,
    ) as Map<String, Object?>;
    expect(persisted['niche'], 'Tech');
    expect(persisted['selectedTier'], 'Premium');

    expect(harness.userRepository.updatedProfiles, hasLength(1));
    expect(
      harness.userRepository.updatedProfiles.single.tier,
      shared_user.SubscriptionTier.premium,
    );
    expect(
      harness.container.read(onboardingProvider).isCompleting,
      isFalse,
    );
  });
}

class _RecordingUserRepository implements UserRepository {
  final updatedProfiles = <shared_user.User>[];
  final _controller = StreamController<shared_user.User?>.broadcast();

  @override
  Future<shared_user.User?> getById(String id) async {
    return updatedProfiles.where((user) => user.id == id).firstOrNull;
  }

  @override
  Future<shared_user.User?> getProfile(String userId) => getById(userId);

  @override
  Future<shared_user.User> updateProfile(shared_user.User user) async {
    updatedProfiles.add(user);
    _controller.add(user);
    return user;
  }

  @override
  Stream<shared_user.User?> watchProfile(String userId) {
    return _controller.stream;
  }
}
