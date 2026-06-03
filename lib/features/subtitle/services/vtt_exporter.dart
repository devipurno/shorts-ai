import '../../../core/utils/time_format.dart';
import '../../../shared/models/subtitle.dart';

class VttExporter {
  const VttExporter._();

  static String export(List<SubtitleSegment> segments) {
    final buffer = StringBuffer('WEBVTT\n\n');
    for (final segment in segments) {
      buffer
        ..writeln(
          '${formatVttTimestamp(segment.startMs)} --> '
          '${formatVttTimestamp(segment.endMs)}',
        )
        ..writeln(segment.text)
        ..writeln();
    }
    return buffer.toString().trimRight();
  }
}
