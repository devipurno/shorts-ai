import 'package:flutter_test/flutter_test.dart';
import 'package:shorts_ai/core/extensions/string_ext.dart';

void main() {
  test('validates common string formats', () {
    expect('devi@example.com'.isEmail, isTrue);
    expect('not email'.isEmail, isFalse);
    expect('+62 812-3456-7890'.isPhone, isTrue);
    expect('abc'.isPhone, isFalse);
    expect('https://autoshort.id'.isUrl, isTrue);
    expect('autoshort.id'.isUrl, isFalse);
  });

  test('capitalizes and truncates text', () {
    expect('autoShort'.capitalize, 'AutoShort');
    expect(''.capitalize, '');
    expect('AutoShort creator'.truncate(9), 'AutoSh...');
    expect('AutoShort'.truncate(20), 'AutoShort');
  });

  test('hashes and base64 encodes text', () {
    expect(
      'AutoShort'.hashSha256,
      'd2933f4d238aadaed3b5c339df64ab61ba18eaca8dcd0497fa91f8b672f2a245',
    );

    final encoded = 'AutoShort'.base64Encode;
    expect(encoded, 'QXV0b1Nob3J0');
    expect(encoded.base64Decode, 'AutoShort');
  });
}
