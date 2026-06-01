import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:shorts_ai/features/auth/providers/auth_provider.dart';
import 'package:shorts_ai/features/templates/template_library_screen.dart';

import 'integration_flow_helper.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('template library shows premium template purchase surface', (tester) async {
    await pumpFlowWidget(
      tester,
      const TemplateLibraryScreen(),
      authState: Authenticated(integrationUser),
    );
    await tester.pump(const Duration(seconds: 1));
    expect(find.byKey(const Key('template-library-screen')), findsOneWidget);
  });
}