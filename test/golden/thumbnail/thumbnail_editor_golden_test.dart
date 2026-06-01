import 'package:golden_toolkit/golden_toolkit.dart';
import 'package:shorts_ai/features/auth/providers/auth_provider.dart';
import 'package:shorts_ai/features/thumbnail/thumbnail_editor_screen.dart';

import '../golden_test_helper.dart';

void main() {
  setUpGoldenTests();

  testGoldens('thumbnail editor GOLDEN', (tester) async {
    await pumpResponsiveGolden(
      tester,
      authState: Authenticated(goldenUser),
      builder: () => const ThumbnailEditorScreen(videoId: 'golden-video'),
    );
    await expectResponsiveGolden(tester, 'thumbnail_editor');
  });
}
