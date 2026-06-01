import 'package:golden_toolkit/golden_toolkit.dart';
import 'package:shorts_ai/features/auth/providers/auth_provider.dart';
import 'package:shorts_ai/features/auth/screens/login_screen.dart';

import '../golden_test_helper.dart';

void main() {
  setUpGoldenTests();

  testGoldens('login screen variants GOLDEN', (tester) async {
    await pumpResponsiveGolden(
      tester,
      builder: () => const LoginScreen(),
      authState: const AuthError('Invalid mock credentials.'),
    );
    await expectResponsiveGolden(tester, 'auth_login_screen');
  });
}
