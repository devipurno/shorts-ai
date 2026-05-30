import 'package:flutter_test/flutter_test.dart';
import 'package:shorts_ai/features/subtitle/providers/subtitle_provider.dart';
import 'package:shorts_ai/features/subtitle/services/ass_exporter.dart';
import 'package:shorts_ai/features/subtitle/services/srt_exporter.dart';
import 'package:shorts_ai/features/subtitle/services/vtt_exporter.dart';
import 'package:shorts_ai/shared/models/subtitle.dart';

void main() {
  test('autoSplitFromTranscript creates timed segments and word timings', () {
    final notifier = SubtitleNotifier(projectId: 'project_1');

    notifier.autoSplitFromTranscript(
      'Satu dua tiga empat lima enam tujuh delapan sembilan sepuluh sebelas',
    );

    expect(notifier.state.segments, hasLength(2));
    expect(notifier.state.segments.first.words, hasLength(6));
    expect(notifier.state.segments.first.startMs, 0);
    expect(notifier.state.segments.first.endMs, greaterThan(0));
    expect(notifier.state.segments.last.text,
        'tujuh delapan sembilan sepuluh sebelas');
  });

  test('state management adds, updates, deletes, reorders, and edits words',
      () {
    final notifier = SubtitleNotifier(projectId: 'project_1');
    final originalCount = notifier.state.segments.length;
    final segment = const SubtitleSegment(
      startMs: 9000,
      endMs: 10400,
      text: 'manual segment',
      words: [Word(text: 'manual', startMs: 9000, endMs: 9400)],
    );

    notifier.addSegment(segment);
    expect(notifier.state.segments, hasLength(originalCount + 1));

    notifier.updateSegment(
        0, notifier.state.segments.first.copyWith(text: 'updated'));
    expect(notifier.state.segments.first.text, 'updated');

    notifier.setWordTiming(
      segmentIndex: 0,
      wordIndex: 0,
      startMs: 120,
      endMs: 420,
    );
    expect(notifier.state.segments.first.words.first.startMs, 120);

    notifier.reorderSegments(0, 2);
    expect(notifier.state.selectedSegmentIndex, 1);

    notifier.deleteSegment(0);
    expect(notifier.state.segments, hasLength(originalCount));
  });

  test('ASS exporter generates a valid ASS document structure', () {
    final content = AssExporter.export(
      segments: _segments,
      style: const SubtitleStyle(
        fontFamily: 'Inter',
        fontSize: 44,
        fontColor: '#FFFFFF',
        strokeColor: '#0B0C10',
        position: 'bottom_center',
      ),
    );

    expect(content, contains('[Script Info]'));
    expect(content, contains('[V4+ Styles]'));
    expect(content, contains('[Events]'));
    expect(content, contains('Style: AutoShort,Inter,44'));
    expect(content, contains('Dialogue: 0,0:00:00.00,0:00:02.10'));
  });

  test('SRT exporter formats timestamps as hh:mm:ss,ms', () {
    final content = SrtExporter.export(_segments);

    expect(content, startsWith('1'));
    expect(content, contains('00:00:00,000 --> 00:00:02,100'));
    expect(content, contains('AutoShort makes captions glow'));
  });

  test('VTT exporter emits WEBVTT header and dot timestamps', () {
    final content = VttExporter.export(_segments);

    expect(content, startsWith('WEBVTT'));
    expect(content, contains('00:00:00.000 --> 00:00:02.100'));
  });
}

const _segments = [
  SubtitleSegment(
    startMs: 0,
    endMs: 2100,
    text: 'AutoShort makes captions glow',
    words: [
      Word(text: 'AutoShort', startMs: 0, endMs: 420),
      Word(text: 'makes', startMs: 420, endMs: 840),
      Word(text: 'captions', startMs: 840, endMs: 1260),
      Word(text: 'glow', startMs: 1260, endMs: 1680),
    ],
  ),
];
