import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shorts_ai/features/editor/providers/editor_provider.dart';
import 'package:shorts_ai/features/editor/widgets/timeline/timeline_widget.dart';

@Tags(['perf'])
void main() {
  testWidgets(
    'Mini editor timeline renders within baseline',
    (tester) async {
      final stopwatch = Stopwatch()..start();
      await tester.pumpWidget(
        const MaterialApp(
          home: TimelineWidget(state: EditorState(videoId: 'perf-video')),
        ),
      );
      await tester.pump();
      stopwatch.stop();

      expect(stopwatch.elapsedMilliseconds, lessThan(300));
    },
    skip: true,
  );
}