import 'package:golden_toolkit/golden_toolkit.dart';
import 'package:shorts_ai/features/onboarding/onboarding_screen.dart';

import '../golden_test_helper.dart';

void main() {
  setUpGoldenTests();

  testGoldens('onboarding step 1 GOLDEN', (tester) async {
    await pumpResponsiveGolden(tester, builder: () => const OnboardingScreen());
    await expectResponsiveGolden(tester, 'onboarding_step_1');
  });
}
