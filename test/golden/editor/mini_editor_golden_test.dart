import 'package:golden_toolkit/golden_toolkit.dart';
import 'package:shorts_ai/features/auth/providers/auth_provider.dart';
import 'package:shorts_ai/features/editor/mini_editor_screen.dart';

import '../golden_test_helper.dart';

void main() {
  setUpGoldenTests();

  testGoldens('mini editor timeline GOLDEN', (tester) async {
    await pumpResponsiveGolden(
      tester,
      authState: Authenticated(goldenUser),
      builder: () => const MiniEditorScreen(videoId: 'golden-video'),
    );
    await expectResponsiveGolden(tester, 'mini_editor');
  });
}