import 'package:golden_toolkit/golden_toolkit.dart';
import 'package:shorts_ai/features/auth/screens/signup_screen.dart';

import '../golden_test_helper.dart';

void main() {
  setUpGoldenTests();

  testGoldens('signup screen GOLDEN', (tester) async {
    await pumpResponsiveGolden(tester, builder: () => const SignupScreen());
    await expectResponsiveGolden(tester, 'auth_signup_screen');
  });
}