import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http_mock_adapter/http_mock_adapter.dart';
import 'package:shorts_ai/core/ai/ai_proxy_client.dart';
import 'package:shorts_ai/core/ai/ai_router.dart';
import 'package:shorts_ai/core/ai/cache/ai_cache.dart';
import 'package:shorts_ai/core/ai/models/ai_request.dart';
import 'package:shorts_ai/core/ai/providers/deepseek_provider.dart';
import 'package:shorts_ai/core/ai/providers/edge_tts_provider.dart';
import 'package:shorts_ai/core/ai/providers/gemini_provider.dart';
import 'package:shorts_ai/core/ai/providers/groq_provider.dart';
import 'package:shorts_ai/core/ai/providers/pollinations_provider.dart';
import 'package:shorts_ai/core/ai/providers/provider_utils.dart';
import 'package:shorts_ai/core/ai/quota_tracker.dart';

void main() {
  test('AIRouter routes Gemini failure to Groq and caches successful text',
      () async {
    final dio = Dio();
    final adapter = DioAdapter(
        dio: dio, matcher: const UrlRequestMatcher(matchMethod: true));
    var groqCalls = 0;

    adapter.onPost(
      GeminiProvider.endpoint,
      (server) => server.reply(500, {'error': 'quota'}),
    );
    adapter.onPost(
      GroqProvider.chatEndpoint,
      (server) => server.replyCallback(200, (_) {
        groqCalls += 1;
        return {
          'choices': [
            {
              'message': {'content': 'Groq fallback text'},
            },
          ],
        };
      }),
    );

    final router = _router(
      dio: dio,
      quotaTracker: QuotaTracker(),
      cache: AICache(),
    );

    final first = await router.generateText(const LLMRequest(prompt: 'Topik'));
    final second = await router.generateText(const LLMRequest(prompt: 'Topik'));

    expect(first.getOrThrow().provider, 'groq');
    expect(first.getOrThrow().text, 'Groq fallback text');
    expect(second.getOrThrow().provider, 'cache');
    expect(groqCalls, 1);
  });

  test('AIRouter uses DeepSeek overflow when free quotas are exhausted',
      () async {
    final dio = Dio();
    final adapter = DioAdapter(
        dio: dio, matcher: const UrlRequestMatcher(matchMethod: true));

    adapter.onPost(
      DeepSeekProvider.endpoint,
      (server) => server.reply(200, {
        'choices': [
          {
            'message': {'content': 'DeepSeek overflow'},
          },
        ],
      }),
    );

    final router = _router(
      dio: dio,
      quotaTracker: QuotaTracker(
        quotas: const {
          'gemini': 0,
          'groq': 0,
          'groq_whisper': 30,
          'deepseek': null,
        },
      ),
      cache: AICache(),
    );

    final result = await router.generateText(const LLMRequest(prompt: 'Topik'));

    expect(result.getOrThrow().provider, 'deepseek');
    expect(result.getOrThrow().text, 'DeepSeek overflow');
  });

  test('AIRouter caches STT transcription by request payload', () async {
    final dio = Dio();
    final adapter = DioAdapter(
        dio: dio, matcher: const UrlRequestMatcher(matchMethod: true));
    var calls = 0;
    final file = File('${Directory.systemTemp.path}/ai-router-test.wav');
    await file.writeAsBytes([1, 2, 3]);

    adapter.onPost(
      GroqProvider.transcriptionEndpoint,
      (server) => server.replyCallback(200, (_) {
        calls += 1;
        return {'text': 'hasil transkrip'};
      }),
    );

    final router = _router(
      dio: dio,
      quotaTracker: QuotaTracker(),
      cache: AICache(),
    );

    final request = STTRequest(filePath: file.path, language: 'id');
    final first = await router.transcribeAudio(request);
    final second = await router.transcribeAudio(request);

    expect(first.getOrThrow().provider, 'groq_whisper');
    expect(second.getOrThrow().provider, 'cache');
    expect(calls, 1);
  });

  test('AIRouter can use Cloudflare AI proxy with Supabase bearer auth',
      () async {
    final dio = Dio();
    final adapter = DioAdapter(
        dio: dio, matcher: const UrlRequestMatcher(matchMethod: true));

    adapter.onPost(
      'https://proxy.example.com/ai/gemini/generate',
      (server) => server.reply(200, {
        'text': 'Proxy text',
        'provider': 'gemini',
        'inputTokens': 3,
        'outputTokens': 5,
      }),
      headers: {'Authorization': 'Bearer supabase-token'},
    );

    final router = _router(
      dio: dio,
      quotaTracker: QuotaTracker(),
      cache: AICache(),
      proxy: AIProxyClient(
        dio: dio,
        baseUrl: 'https://proxy.example.com',
        accessTokenProvider: () async => 'supabase-token',
      ),
    );

    final result = await router.generateText(const LLMRequest(prompt: 'Topik'));

    expect(result.getOrThrow().provider, 'gemini');
    expect(result.getOrThrow().text, 'Proxy text');
  });

  test('AIProxyClient maps 429 into quotaExceeded with friendly message',
      () async {
    final dio = Dio();
    final adapter = DioAdapter(
        dio: dio, matcher: const UrlRequestMatcher(matchMethod: true));
    adapter.onPost(
      'https://proxy.example.com/ai/gemini/generate',
      (server) => server.reply(429, {
        'error': {'code': 'rate_limit_exceeded'}
      }),
    );

    final client = AIProxyClient(
      dio: dio,
      baseUrl: 'https://proxy.example.com',
      accessTokenProvider: () async => 'supabase-token',
    );

    final result = await client.generateText(const LLMRequest(prompt: 'Topik'));

    expect(result.errorOrNull, isA<QuotaExceeded>());
    expect((result.errorOrNull as QuotaExceeded).message, contains('Limit AI'));
  });
  test('QuotaTracker resets daily using Asia/Bangkok date boundary', () async {
    var now = DateTime.utc(2026, 6, 1, 16, 30);
    final tracker = QuotaTracker(
      now: () => now,
      quotas: const {'gemini': 1},
    );

    expect(await tracker.getRemainingQuota('gemini'), 1);
    await tracker.recordUsage('gemini');
    expect(await tracker.getRemainingQuota('gemini'), 0);

    now = DateTime.utc(2026, 6, 1, 17, 30);
    expect(await tracker.getRemainingQuota('gemini'), 1);
  });
}

AIRouter _router({
  required Dio dio,
  required QuotaTracker quotaTracker,
  required AICache cache,
  AIProxyClient? proxy,
}) {
  return AIRouter(
    gemini: GeminiProvider(dio: dio, apiKey: 'gemini-key'),
    groq: GroqProvider(dio: dio, apiKey: 'groq-key'),
    deepSeek: DeepSeekProvider(dio: dio, apiKey: 'deepseek-key'),
    edgeTts: EdgeTTSProvider(synthesizer: _fakeSynthesizer),
    pollinations: PollinationsProvider(dio: dio),
    quotaTracker: quotaTracker,
    cache: cache,
    proxy: proxy,
  );
}

Future<void> _fakeSynthesizer({
  required TTSRequest request,
  required String outputPath,
}) async {
  await File(outputPath).writeAsBytes([1, 2, 3]);
}
