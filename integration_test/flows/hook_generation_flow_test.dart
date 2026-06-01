import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:shorts_ai/features/auth/providers/auth_provider.dart';
import 'package:shorts_ai/features/hook_generator/hook_generator_screen.dart';

import 'integration_flow_helper.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('hook generator accepts a topic and exposes generate CTA', (tester) async {
    await pumpFlowWidget(
      tester,
      const HookGeneratorScreen(),
      authState: Authenticated(integrationUser),
    );
    await tester.enterText(find.byType(EditableText).first, 'Tips jualan online');
    await tester.pumpAndSettle();
    expect(find.text('Generate 5 Hook'), findsOneWidget);
  });
}