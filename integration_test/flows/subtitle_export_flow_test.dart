import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:shorts_ai/features/auth/providers/auth_provider.dart';
import 'package:shorts_ai/features/subtitle/subtitle_studio_screen.dart';

import 'integration_flow_helper.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('subtitle studio renders export tab entry point', (tester) async {
    await pumpFlowWidget(
      tester,
      const SubtitleStudioScreen(videoId: 'integration-video'),
      authState: Authenticated(integrationUser),
    );
    expect(find.byKey(const Key('subtitle-studio-screen')), findsOneWidget);
    expect(find.text('Export'), findsOneWidget);
  });
}