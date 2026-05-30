import 'dart:convert';

import 'package:crypto/crypto.dart' as crypto;

extension AutoShortStringX on String {
  bool get isEmail {
    return RegExp(r'^[^\s@]+@[^\s@]+\.[^\s@]+$').hasMatch(trim());
  }

  bool get isPhone {
    return RegExp(r'^\+?[0-9][0-9\s\-()]{7,}$').hasMatch(trim());
  }

  bool get isUrl {
    final uri = Uri.tryParse(trim());
    return uri != null &&
        (uri.scheme == 'http' || uri.scheme == 'https') &&
        uri.host.isNotEmpty;
  }

  String get capitalize {
    if (isEmpty) return this;
    return '${this[0].toUpperCase()}${substring(1)}';
  }

  String truncate(int maxLength) {
    if (maxLength <= 0) return '';
    if (length <= maxLength) return this;
    if (maxLength <= 3) return substring(0, maxLength);
    return '${substring(0, maxLength - 3)}...';
  }

  String get hashSha256 {
    return crypto.sha256.convert(utf8.encode(this)).toString();
  }

  String get base64Encode {
    return base64.encode(utf8.encode(this));
  }

  String get base64Decode {
    return utf8.decode(base64.decode(this));
  }
}
