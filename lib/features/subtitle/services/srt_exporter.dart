import '../../../core/utils/time_format.dart';
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
          '${formatSrtTimestamp(segment.startMs)} --> '
          '${formatSrtTimestamp(segment.endMs)}',
        )
        ..writeln(segment.text)
        ..writeln();
    }
    return buffer.toString().trimRight();
  }
}
