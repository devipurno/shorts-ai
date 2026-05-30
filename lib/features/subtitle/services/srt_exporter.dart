import '../../../shared/models/subtitle.dart';

class SrtExporter {
  const SrtExporter._();

  static String export(List<SubtitleSegment> segments) {
    final buffer = StringBuffer();
    for (var index = 0; index < segments.length; index++) {
      final segment = segments[index];
      buffer
        ..writeln(index + 1)
        ..writeln(
          '${formatTimestamp(segment.startMs)} --> '
          '${formatTimestamp(segment.endMs)}',
        )
        ..writeln(segment.text)
        ..writeln();
    }
    return buffer.toString().trimRight();
  }

  static String formatTimestamp(int milliseconds) {
    final safe = milliseconds.clamp(0, 24 * 60 * 60 * 1000);
    final hours = safe ~/ 3600000;
    final minutes = (safe % 3600000) ~/ 60000;
    final seconds = (safe % 60000) ~/ 1000;
    final millis = safe % 1000;
    return '${_two(hours)}:${_two(minutes)}:${_two(seconds)},'
        '${_three(millis)}';
  }

  static String _two(int value) => value.toString().padLeft(2, '0');

  static String _three(int value) => value.toString().padLeft(3, '0');
}
