import 'package:golden_toolkit/golden_toolkit.dart';
import 'package:shorts_ai/features/auth/providers/auth_provider.dart';
import 'package:shorts_ai/features/pricing/pricing_screen.dart';

import '../golden_test_helper.dart';

void main() {
  setUpGoldenTests();

  testGoldens('pricing screen GOLDEN', (tester) async {
    await pumpResponsiveGolden(
      tester,
      authState: Authenticated(goldenUser),
      builder: () => const PricingScreen(),
    );
    await expectResponsiveGolden(tester, 'pricing_screen');
  });
}
