/// Shared timestamp / time-code formatting utilities.
///
/// Each subtitle format has a slightly different timestamp layout but they all
/// decompose milliseconds into hours, minutes, seconds, and a sub-second
/// fraction.  Centralising the logic here removes duplication across the
/// ASS, SRT, and VTT exporters as well as the editor tabs.

/// Decomposes [milliseconds] into `(hours, minutes, seconds, remainderMs)`.
({int hours, int minutes, int seconds, int remainderMs}) decomposeMs(
  int milliseconds,
) {
  final safe = milliseconds.clamp(0, 24 * 60 * 60 * 1000);
  return (
    hours: safe ~/ 3600000,
    minutes: (safe % 3600000) ~/ 60000,
    seconds: (safe % 60000) ~/ 1000,
    remainderMs: safe % 1000,
  );
}

/// Pads [value] to [width] digits with leading zeros.
String _pad(int value, int width) => value.toString().padLeft(width, '0');

/// Formats [milliseconds] as `HH:MM:SS,mmm` (SRT).
String formatSrtTimestamp(int milliseconds) {
  final (:hours, :minutes, :seconds, :remainderMs) =
      decomposeMs(milliseconds);
  return '${_pad(hours, 2)}:${_pad(minutes, 2)}:${_pad(seconds, 2)},'
      '${_pad(remainderMs, 3)}';
}

/// Formats [milliseconds] as `HH:MM:SS.mmm` (WebVTT).
String formatVttTimestamp(int milliseconds) {
  final (:hours, :minutes, :seconds, :remainderMs) =
      decomposeMs(milliseconds);
  return '${_pad(hours, 2)}:${_pad(minutes, 2)}:${_pad(seconds, 2)}.'
      '${_pad(remainderMs, 3)}';
}

/// Formats [milliseconds] as `H:MM:SS.cc` (ASS / SSA).
String formatAssTimestamp(int milliseconds) {
  final (:hours, :minutes, :seconds, :remainderMs) =
      decomposeMs(milliseconds);
  final centiseconds = remainderMs ~/ 10;
  return '$hours:${_pad(minutes, 2)}:${_pad(seconds, 2)}.'
      '${_pad(centiseconds, 2)}';
}

/// Formats [ms] as `MM:SS.mmm` for the editor timeline.
String formatEditorTimeFull(int ms) {
  final minutes = ms ~/ 60000;
  final seconds = (ms % 60000) ~/ 1000;
  final millis = ms % 1000;
  return '${_pad(minutes, 2)}:${_pad(seconds, 2)}.${_pad(millis, 3)}';
}

/// Formats [ms] as `MM:SS` for the editor (no sub-second precision).
String formatEditorTimeShort(int ms) {
  final minutes = ms ~/ 60000;
  final seconds = (ms % 60000) ~/ 1000;
  return '${_pad(minutes, 2)}:${_pad(seconds, 2)}';
}
