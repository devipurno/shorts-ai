import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shorts_ai/core/theme/app_theme.dart';
import 'package:shorts_ai/core/theme/app_typography.dart';
import 'package:shorts_ai/features/onboarding/onboarding_screen.dart';
import 'package:shorts_ai/features/onboarding/providers/onboarding_provider.dart';
import 'package:shorts_ai/routing/app_router.dart';
import 'package:shorts_ai/routing/routes.dart';
import 'package:shorts_ai/shared/models/user.dart' as shared_user;
import 'package:shorts_ai/shared/repositories/providers.dart';
import 'package:shorts_ai/shared/repositories/user_repository.dart';
import 'package:shorts_ai/shared/services/preferences_service.dart';
import 'package:shorts_ai/shared/services/providers.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  setUpAll(() {
    AppTypography.setUseGoogleFontsForTest(false);
  });

  testWidgets('renders the 5-step onboarding flow and completes to login',
      (tester) async {
    SharedPreferences.setMockInitialValues({});
    final preferences = await SharedPreferences.getInstance();
    final userRepository = _RecordingUserRepository();
    final container = ProviderContainer(
      overrides: [
        preferencesServiceProvider.overrideWith(
          (ref) async => PreferencesService(preferences),
        ),
        userRepositoryProvider.overrideWithValue(userRepository),
      ],
    );
    addTearDown(container.dispose);

    await tester.pumpWidget(
      UncontrolledProviderScope(
        container: container,
        child: MaterialApp.router(
          theme: darkTheme(),
          routerConfig: createAppRouter(
            initialLocation: AppRoutes.onboarding,
          ),
        ),
      ),
    );
    await tester.pump(const Duration(milliseconds: 500));

    expect(find.byType(OnboardingScreen), findsOneWidget);
    expect(find.byKey(const Key('onboarding-screen')), findsOneWidget);
    expect(
        find.text('Buat Shorts viral dalam menit, bukan jam'), findsOneWidget);
    expect(find.byKey(const Key('onboarding-dot-0')), findsOneWidget);
    expect(find.byKey(const Key('onboarding-dot-4')), findsOneWidget);

    await _tapContinue(tester);
    expect(container.read(onboardingProvider).currentStep, 1);
    expect(find.text('Pilih niche utama'), findsOneWidget);

    await tester.tap(find.text('Tech'));
    await tester.pump();
    await _tapContinue(tester);
    expect(container.read(onboardingProvider).currentStep, 2);
    expect(find.text('Apa target kreatormu?'), findsOneWidget);

    await tester.tap(find.text('Grow audience'));
    await tester.pump();
    await tester.tap(find.text('Monetize'));
    await tester.pump();
    await _tapContinue(tester);
    expect(container.read(onboardingProvider).currentStep, 3);
    expect(find.text('Bahasa utama konten'), findsOneWidget);

    await tester.tap(find.text('Bilingual'));
    await tester.pump();
    await _tapContinue(tester);
    expect(container.read(onboardingProvider).currentStep, 4);
    expect(find.text('Mulai dengan paket yang pas'), findsOneWidget);

    await tester.tap(find.text('Premium'));
    await tester.pump();
    await _tapContinue(tester);
    await tester.pump(const Duration(milliseconds: 500));

    expect(find.byKey(const Key('login-screen')), findsOneWidget);
    expect(preferences.getBool(hasCompletedOnboardingKey), isTrue);
    expect(userRepository.updatedProfiles.single.tier,
        shared_user.SubscriptionTier.premium);
  });
}

Future<void> _tapContinue(WidgetTester tester) async {
  await tester.ensureVisible(find.byKey(const Key('onboarding-continue')));
  await tester.tap(find.textContaining(RegExp('Continue|Mulai')).last);
  await tester.pump();
  await tester.pump(const Duration(milliseconds: 180));
  await tester.pump(const Duration(milliseconds: 360));
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
  Future<String> uploadAvatar(File file, {required String userId}) async {
    return 'mock://avatar/$userId';
  }

  @override
  Stream<shared_user.User?> watchProfile(String userId) {
    return _controller.stream;
  }
}
