import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:shorts_ai/features/auth/providers/auth_provider.dart';
import 'package:shorts_ai/features/thumbnail/thumbnail_editor_screen.dart';

import 'integration_flow_helper.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('thumbnail editor renders A/B canvas and toolbar',
      (tester) async {
    await pumpFlowWidget(
      tester,
      const ThumbnailEditorScreen(videoId: 'integration-video'),
      authState: Authenticated(integrationUser),
    );
    expect(find.byKey(const Key('thumbnail-editor-screen')), findsOneWidget);
    expect(find.byKey(const Key('thumbnail-ab-toggle')), findsOneWidget);
  });
}
