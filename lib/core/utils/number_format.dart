/// Formats a large [value] into a compact human-readable string.
///
/// - `>= 1 000 000` → `1.2M`
/// - `>= 1 000`     → `1.2K` (int) or `1K` (double)
/// - otherwise       → plain `toString()`
String compactNumber(num value) {
  if (value >= 1000000) {
    return '${(value / 1000000).toStringAsFixed(1)}M';
  }
  if (value >= 1000) {
    if (value is int) {
      return '${(value / 1000).toStringAsFixed(1)}K';
    }
    return '${(value / 1000).toStringAsFixed(0)}K';
  }
  return value is int ? value.toString() : value.round().toString();
}
