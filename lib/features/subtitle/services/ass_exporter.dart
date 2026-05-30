import '../../../shared/models/subtitle.dart';

class AssExporter {
  const AssExporter._();

  static String export({
    required List<SubtitleSegment> segments,
    required SubtitleStyle style,
    double strokeWidth = 3,
    String karaokeColor = '#D4AF37',
  }) {
    final fontColor = _assColor(style.fontColor);
    final strokeColor = _assColor(style.strokeColor);
    final highlightColor = _assColor(karaokeColor);
    final alignment = _alignment(style.position);
    final fontSize = style.fontSize.round();

    final buffer = StringBuffer()
      ..writeln('[Script Info]')
      ..writeln('Title: AutoShort Subtitle Studio Pro')
      ..writeln('ScriptType: v4.00+')
      ..writeln('WrapStyle: 0')
      ..writeln('ScaledBorderAndShadow: yes')
      ..writeln('PlayResX: 1080')
      ..writeln('PlayResY: 1920')
      ..writeln()
      ..writeln('[V4+ Styles]')
      ..writeln(
        'Format: Name, Fontname, Fontsize, PrimaryColour, SecondaryColour, '
        'OutlineColour, BackColour, Bold, Italic, Underline, StrikeOut, '
        'ScaleX, ScaleY, Spacing, Angle, BorderStyle, Outline, Shadow, '
        'Alignment, MarginL, MarginR, MarginV, Encoding',
      )
      ..writeln(
        'Style: AutoShort,${style.fontFamily},$fontSize,$fontColor,'
        '$highlightColor,$strokeColor,&H66000000,-1,0,0,0,100,100,0,0,1,'
        '${strokeWidth.toStringAsFixed(1)},1,$alignment,80,80,120,1',
      )
      ..writeln()
      ..writeln('[Events]')
      ..writeln('Format: Layer, Start, End, Style, Name, MarginL, MarginR, '
          'MarginV, Effect, Text');

    for (final segment in segments) {
      buffer.writeln(
        'Dialogue: 0,${formatTimestamp(segment.startMs)},'
        '${formatTimestamp(segment.endMs)},AutoShort,,0,0,0,,'
        '${_escape(segment.text)}',
      );
    }

    return buffer.toString().trimRight();
  }

  static String formatTimestamp(int milliseconds) {
    final safe = milliseconds.clamp(0, 24 * 60 * 60 * 1000);
    final hours = safe ~/ 3600000;
    final minutes = (safe % 3600000) ~/ 60000;
    final seconds = (safe % 60000) ~/ 1000;
    final centiseconds = (safe % 1000) ~/ 10;
    return '$hours:${_two(minutes)}:${_two(seconds)}.${_two(centiseconds)}';
  }

  static String _assColor(String hex) {
    final clean = hex.replaceAll('#', '').padLeft(6, '0');
    final rr = clean.substring(0, 2);
    final gg = clean.substring(2, 4);
    final bb = clean.substring(4, 6);
    return '&H00$bb$gg$rr';
  }

  static int _alignment(String position) {
    return switch (position) {
      'top_left' => 7,
      'top_center' || 'top' => 8,
      'top_right' => 9,
      'center_left' => 4,
      'center' => 5,
      'center_right' => 6,
      'bottom_left' => 1,
      'bottom_center' || 'bottom' => 2,
      'bottom_right' => 3,
      _ => 2,
    };
  }

  static String _escape(String value) {
    return value.replaceAll('\n', r'\N').replaceAll(',', r'\,');
  }

  static String _two(int value) => value.toString().padLeft(2, '0');
}
