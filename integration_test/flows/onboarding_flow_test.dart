import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:shorts_ai/features/onboarding/onboarding_screen.dart';

import 'integration_flow_helper.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('5-step onboarding wizard advances through selections', (tester) async {
    await pumpFlowWidget(tester, const OnboardingScreen());
    expect(find.text('Buat Shorts viral dalam menit, bukan jam'), findsOneWidget);

    await tester.tap(find.byKey(const Key('onboarding-continue')));
    await tester.pumpAndSettle();
    expect(find.text('Pilih niche utama kamu'), findsOneWidget);
  });
}