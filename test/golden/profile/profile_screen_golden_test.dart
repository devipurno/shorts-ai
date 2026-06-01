import 'package:golden_toolkit/golden_toolkit.dart';
import 'package:shorts_ai/features/auth/providers/auth_provider.dart';
import 'package:shorts_ai/features/profile/profile_screen.dart';
import 'package:shorts_ai/features/profile/providers/profile_provider.dart';

import '../golden_test_helper.dart';

void main() {
  setUpGoldenTests();

  testGoldens('profile screen premium tier GOLDEN', (tester) async {
    await pumpResponsiveGolden(
      tester,
      authState: Authenticated(goldenUser),
      overrides: [
        profileStatsProvider.overrideWith(
          (ref) async => const ProfileStats(
            videosCreated: 12,
            totalViews: 42000,
            followersGained: 720,
          ),
        ),
        profileSubscriptionProvider.overrideWith((ref) async => null),
      ],
      builder: () => const ProfileScreen(),
    );
    await expectResponsiveGolden(tester, 'profile_screen');
  });
}
