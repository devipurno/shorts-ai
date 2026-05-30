import 'package:flutter_test/flutter_test.dart';
import 'package:shorts_ai/core/env/env.dart';

void main() {
  tearDown(Env.resetForTest);

  test('returns null for empty optional Supabase values', () {
    Env.loadFromStringForTest('', failFast: false);

    expect(Env.supabaseUrl, isNull);
    expect(Env.supabaseAnonKey, isNull);
  });

  test('returns configured values from dotenv', () {
    Env.loadFromStringForTest(
      [
        'SUPABASE_URL=https://example.supabase.co',
        'SUPABASE_ANON_KEY=anon-key',
        'API_BASE_URL=https://api.example.com',
        'OPENAI_API_KEY=openai-key',
      ].join('\n'),
      failFast: true,
    );

    expect(Env.supabaseUrl, 'https://example.supabase.co');
    expect(Env.supabaseAnonKey, 'anon-key');
    expect(Env.apiBaseUrl, 'https://api.example.com');
    expect(Env.openaiApiKey, 'openai-key');
  });

  test('fails fast with a clear missing variable message', () {
    expect(
      () => Env.loadFromStringForTest(
        '',
        failFast: true,
        requiredKeys: {'SUPABASE_URL'},
      ),
      throwsA(
        isA<StateError>().having(
          (error) => error.message,
          'message',
          contains('SUPABASE_URL'),
        ),
      ),
    );
  });

  test('uses default API base URL when optional env is absent', () {
    Env.loadFromStringForTest('', failFast: false);

    expect(Env.apiBaseUrl, Env.defaultApiBaseUrl);
  });
}
