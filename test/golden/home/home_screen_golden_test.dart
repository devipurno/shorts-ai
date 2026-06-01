import 'package:golden_toolkit/golden_toolkit.dart';
import 'package:shorts_ai/features/auth/providers/auth_provider.dart';
import 'package:shorts_ai/features/home/home_screen.dart';
import 'package:shorts_ai/features/home/providers/home_provider.dart';
import 'package:shorts_ai/shared/models/project.dart';
import 'package:shorts_ai/shared/models/template.dart';

import '../golden_test_helper.dart';

void main() {
  setUpGoldenTests();

  testGoldens('home screen with projects GOLDEN', (tester) async {
    await pumpResponsiveGolden(
      tester,
      authState: Authenticated(goldenUser),
      overrides: [
        homeDataProvider.overrideWith((ref) async => _homeData()),
      ],
      builder: () => const HomeScreen(),
    );
    await expectResponsiveGolden(tester, 'home_screen');
  });
}

HomeData _homeData() {
  final now = DateTime(2026, 6, 1, 9);
  return HomeData(
    recentProjects: [
      Project(
        id: 'golden-project-1',
        userId: goldenUser.id,
        title: 'Viral launch clip',
        status: ProjectStatus.ready,
        duration: 42,
        createdAt: now,
        updatedAt: now,
      ),
    ],
    spotlightTemplates: const [
      Template(
        id: 'golden-template-1',
        name: 'Podcast Gold',
        category: 'Podcast Split',
        tier: TemplateTier.premium,
        timesUsed: 1400,
      ),
    ],
    streakCount: 7,
    tipOfTheDay: 'Buka video dengan hasil akhir dalam 3 detik pertama.',
    hasUnreadNotifications: true,
  );
}