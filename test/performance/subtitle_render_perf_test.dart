import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shorts_ai/features/subtitle/widgets/word_timing_editor.dart';
import 'package:shorts_ai/shared/models/subtitle.dart';

@Tags(['perf'])
void main() {
  testWidgets(
    'Subtitle word timing editor handles 500 words',
    (tester) async {
      final words = List.generate(
        500,
        (index) => Word(
          text: 'w$index',
          startMs: index * 120,
          endMs: index * 120 + 90,
        ),
      );
      final stopwatch = Stopwatch()..start();
      await tester.pumpWidget(MaterialApp(
        home: WordTimingEditor(
          segment: SubtitleSegment(text: 'performance', words: words),
          onChanged: (_, __, ___) {},
        ),
      ));
      await tester.pump();
      stopwatch.stop();

      expect(stopwatch.elapsedMilliseconds, lessThan(500));
    },
    skip: true,
  );
}