import 'package:flutter_test/flutter_test.dart';
import 'package:shorts_ai/features/subtitle/services/ass_exporter.dart';
import 'package:shorts_ai/features/subtitle/services/srt_exporter.dart';
import 'package:shorts_ai/features/subtitle/services/vtt_exporter.dart';
import 'package:shorts_ai/shared/models/subtitle.dart';

void main() {
  final segments = [
    const SubtitleSegment(startMs: 0, endMs: 2500, text: 'Halo dunia'),
    const SubtitleSegment(startMs: 3000, endMs: 5500, text: 'Apa kabar'),
  ];

  group('SrtExporter', () {
    test('exports numbered SRT blocks with comma-separated timestamps', () {
      final result = SrtExporter.export(segments);
      expect(result, contains('1\n'));
      expect(result, contains('00:00:00,000 --> 00:00:02,500'));
      expect(result, contains('Halo dunia'));
      expect(result, contains('2\n'));
      expect(result, contains('00:00:03,000 --> 00:00:05,500'));
      expect(result, contains('Apa kabar'));
    });

    test('formatTimestamp formats milliseconds correctly', () {
      expect(SrtExporter.formatTimestamp(0), '00:00:00,000');
      expect(SrtExporter.formatTimestamp(61500), '00:01:01,500');
      expect(SrtExporter.formatTimestamp(3661999), '01:01:01,999');
    });

    test('formatTimestamp clamps negative and oversize values', () {
      expect(SrtExporter.formatTimestamp(-100), '00:00:00,000');
      // 24*60*60*1000 = 86400000 ms
      expect(SrtExporter.formatTimestamp(90000000), '24:00:00,000');
    });

    test('export handles empty segment list', () {
      expect(SrtExporter.export([]), isEmpty);
    });
  });

  group('VttExporter', () {
    test('exports WEBVTT header with dot-separated timestamps', () {
      final result = VttExporter.export(segments);
      expect(result, startsWith('WEBVTT'));
      expect(result, contains('00:00:00.000 --> 00:00:02.500'));
      expect(result, contains('Halo dunia'));
      expect(result, contains('00:00:03.000 --> 00:00:05.500'));
    });

    test('formatTimestamp uses dot separator', () {
      expect(VttExporter.formatTimestamp(1500), '00:00:01.500');
    });

    test('export handles empty segment list', () {
      final result = VttExporter.export([]);
      expect(result, 'WEBVTT');
    });
  });

  group('AssExporter', () {
    const style = SubtitleStyle(
      fontFamily: 'Inter',
      fontSize: 42,
      fontColor: '#FFFFFF',
      strokeColor: '#0B0C10',
      position: 'bottom',
    );

    test('exports Script Info, Styles, and Events sections', () {
      final result = AssExporter.export(segments: segments, style: style);
      expect(result, contains('[Script Info]'));
      expect(result, contains('Title: AutoShort Subtitle Studio Pro'));
      expect(result, contains('[V4+ Styles]'));
      expect(result, contains('Style: AutoShort,Inter,42'));
      expect(result, contains('[Events]'));
      expect(result, contains('Dialogue:'));
    });

    test('formatTimestamp uses centiseconds with single-digit hour', () {
      expect(AssExporter.formatTimestamp(0), '0:00:00.00');
      expect(AssExporter.formatTimestamp(61500), '0:01:01.50');
      expect(AssExporter.formatTimestamp(3661990), '1:01:01.99');
    });

    test('maps position string to ASS alignment numbers', () {
      // Test through the export output
      final topResult = AssExporter.export(
        segments: segments,
        style: style.copyWith(position: 'top'),
      );
      expect(topResult, contains(',8,')); // top alignment = 8

      final centerResult = AssExporter.export(
        segments: segments,
        style: style.copyWith(position: 'center'),
      );
      expect(centerResult, contains(',5,')); // center alignment = 5
    });

    test('converts hex colors to ASS BGR format', () {
      final result = AssExporter.export(segments: segments, style: style);
      // #FFFFFF → &H00FFFFFF, #0B0C10 → &H00100C0B
      expect(result, contains('&H00FFFFFF'));
      expect(result, contains('&H00100C0B'));
    });

    test('escapes newlines and commas in text', () {
      final segs = [
        const SubtitleSegment(
          startMs: 0,
          endMs: 1000,
          text: 'Line 1\nLine 2, continued',
        ),
      ];
      final result = AssExporter.export(segments: segs, style: style);
      expect(result, contains(r'Line 1\NLine 2\, continued'));
    });

    test('export handles empty segment list', () {
      final result = AssExporter.export(segments: [], style: style);
      expect(result, contains('[Events]'));
      expect(result, isNot(contains('Dialogue:')));
    });
  });
}
