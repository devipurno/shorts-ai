import 'package:golden_toolkit/golden_toolkit.dart';
import 'package:shorts_ai/features/auth/providers/auth_provider.dart';
import 'package:shorts_ai/features/subtitle/subtitle_studio_screen.dart';

import '../golden_test_helper.dart';

void main() {
  setUpGoldenTests();

  testGoldens('subtitle studio GOLDEN', (tester) async {
    await pumpResponsiveGolden(
      tester,
      authState: Authenticated(goldenUser),
      builder: () => const SubtitleStudioScreen(videoId: 'golden-video'),
    );
    await expectResponsiveGolden(tester, 'subtitle_studio');
  });
}