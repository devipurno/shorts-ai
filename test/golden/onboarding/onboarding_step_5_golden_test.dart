import 'package:flutter/material.dart';
import 'package:golden_toolkit/golden_toolkit.dart';
import 'package:shorts_ai/features/onboarding/steps/step_tier.dart';

import '../golden_test_helper.dart';

void main() {
  setUpGoldenTests();

  testGoldens('onboarding step 5 GOLDEN', (tester) async {
    await pumpResponsiveGolden(
      tester,
      builder: () => const Scaffold(
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.all(24),
            child: StepTier(),
          ),
        ),
      ),
    );
    await expectResponsiveGolden(tester, 'onboarding_step_5');
  });
}