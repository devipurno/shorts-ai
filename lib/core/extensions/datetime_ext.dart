extension AutoShortDateTimeX on DateTime {
  static const Duration _bangkokOffset = Duration(hours: 7);

  String get timeAgo {
    final now = DateTime.now().toUtc();
    final value = toUtc();
    final difference = now.difference(value);

    if (difference.inSeconds < 60) return 'baru saja';
    if (difference.inMinutes < 60) return '${difference.inMinutes} menit lalu';
    if (difference.inHours < 24) return '${difference.inHours} jam lalu';
    if (difference.inDays < 7) return '${difference.inDays} hari lalu';
    if (difference.inDays < 30) return '${difference.inDays ~/ 7} minggu lalu';
    if (difference.inDays < 365) {
      return '${difference.inDays ~/ 30} bulan lalu';
    }
    return '${difference.inDays ~/ 365} tahun lalu';
  }

  String get formatLocal {
    final value = _asBangkok;
    return '${value.year.toString().padLeft(4, '0')}-'
        '${value.month.toString().padLeft(2, '0')}-'
        '${value.day.toString().padLeft(2, '0')} '
        '${value.hour.toString().padLeft(2, '0')}:'
        '${value.minute.toString().padLeft(2, '0')} WIB';
  }

  bool get isToday {
    final today = _dateOnly(_bangkokNow);
    return _dateOnly(_asBangkok) == today;
  }

  bool get isYesterday {
    final yesterday = _dateOnly(_bangkokNow).subtract(const Duration(days: 1));
    return _dateOnly(_asBangkok) == yesterday;
  }

  bool get isThisWeek {
    final now = _bangkokNow;
    final startOfWeek =
        _dateOnly(now).subtract(Duration(days: now.weekday - 1));
    final endOfWeek = startOfWeek.add(const Duration(days: 7));
    final value = _dateOnly(_asBangkok);
    return !value.isBefore(startOfWeek) && value.isBefore(endOfWeek);
  }

  DateTime get _asBangkok => toUtc().add(_bangkokOffset);

  static DateTime get _bangkokNow => DateTime.now().toUtc().add(_bangkokOffset);

  static DateTime _dateOnly(DateTime value) {
    return DateTime(value.year, value.month, value.day);
  }
}
