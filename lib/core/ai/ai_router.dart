import 'dart:convert';

import 'package:crypto/crypto.dart';

import 'ai_proxy_client.dart';
import 'ai_service.dart';
import 'cache/ai_cache.dart';
import 'models/ai_request.dart';
import 'providers/deepseek_provider.dart';
import 'providers/edge_tts_provider.dart';
import 'providers/gemini_provider.dart';
import 'providers/groq_provider.dart';
import 'providers/pollinations_provider.dart';
import 'providers/provider_utils.dart';
import 'quota_tracker.dart';
import '../error_reporter.dart';
import '../utils/result.dart';

/// Routes AI requests across cache, quotas, and provider fallbacks.
///
/// The router checks [AICache] first, then tries Gemini, Groq, and DeepSeek
/// for text generation. STT uses Groq Whisper, TTS uses Edge TTS, and image
/// generation uses Pollinations in the Phase 0 stack.
///
/// ```dart
/// final response = await aiRouter.generateText(request);
/// ```
class AIRouter implements AIService {
  AIRouter({
    required GeminiProvider gemini,
    required GroqProvider groq,
    required DeepSeekProvider deepSeek,
    required EdgeTTSProvider edgeTts,
    required PollinationsProvider pollinations,
    required QuotaTracker quotaTracker,
    required AICache cache,
    AIProxyClient? proxy,
    ErrorReporter? errorReporter,
  })  : _gemini = gemini,
        _groq = groq,
        _deepSeek = deepSeek,
        _edgeTts = edgeTts,
        _pollinations = pollinations,
        _quota = quotaTracker,
        _cache = cache,
        _proxy = proxy,
        _errorReporter = errorReporter ?? const NoOpErrorReporter();

  final GeminiProvider _gemini;
  final GroqProvider _groq;
  final DeepSeekProvider _deepSeek;
  final EdgeTTSProvider _edgeTts;
  final PollinationsProvider _pollinations;
  final QuotaTracker _quota;
  final AICache _cache;
  final AIProxyClient? _proxy;
  final ErrorReporter _errorReporter;

  @override
  Future<AIResult<LLMResponse>> generateText(LLMRequest request) async {
    final cacheKey = cacheKeyFor('llm', request.toJson());
    final cached = await _cache.get(cacheKey);
    if (cached != null) {
      return Result.success(LLMResponse(text: cached, provider: 'cache'));
    }

    final proxy = _proxy;
    if (proxy != null) {
      _addAiBreadcrumb('proxy', 'generateText');
      final result = await proxy.generateText(request);
      if (result.isSuccess) {
        final value = result.valueOrNull!;
        await _cache.set(cacheKey, value.text, ttl: const Duration(hours: 24));
      }
      _captureAiFailure(result, 'proxy', 'generateText');
      return result;
    }

    final providers = <LLMProvider>[_gemini, _groq, _deepSeek];
    for (final provider in providers) {
      if (!await _quota.canUseProvider(provider.providerName)) {
        continue;
      }
      _addAiBreadcrumb(provider.providerName, 'generateText');
      final result = await provider.generateText(request);
      if (result.isSuccess) {
        final value = result.valueOrNull!;
        await _quota.recordUsage(provider.providerName);
        await _cache.set(cacheKey, value.text, ttl: const Duration(hours: 24));
        return result;
      }
      final error = result.errorOrNull;
      _captureAiFailure(result, provider.providerName, 'generateText');
      if (error is QuotaExceeded) {
        await _quota.recordUsage(provider.providerName, amount: 999999);
      }
    }

    return const Result.failure(AIProviderError.allProvidersExhausted());
  }

  @override
  Future<AIResult<STTResponse>> transcribeAudio(STTRequest request) async {
    final cacheKey = cacheKeyFor('stt', request.toJson());
    final cached = await _cache.get(cacheKey);
    if (cached != null) {
      return Result.success(
        STTResponse(
            text: cached, provider: 'cache', language: request.language),
      );
    }
    if (!await _quota.canUseProvider('groq_whisper')) {
      return const Result.failure(
        AIProviderError.quotaExceeded(provider: 'groq_whisper'),
      );
    }
    _addAiBreadcrumb('groq_whisper', 'transcribeAudio');
    final result = await _groq.transcribeAudio(request);
    if (result.isSuccess) {
      await _quota.recordUsage('groq_whisper');
      await _cache.set(cacheKey, result.valueOrNull!.text,
          ttl: const Duration(hours: 1));
    }
    _captureAiFailure(result, 'groq_whisper', 'transcribeAudio');
    return result;
  }

  @override
  Future<AIResult<TTSResponse>> generateSpeech(TTSRequest request) async {
    _addAiBreadcrumb('edge_tts', 'generateSpeech');
    final result = await _edgeTts.generateSpeech(request);
    _captureAiFailure(result, 'edge_tts', 'generateSpeech');
    return result;
  }

  @override
  Future<AIResult<ImageResponse>> generateImage(ImageRequest request) async {
    _addAiBreadcrumb('pollinations', 'generateImage');
    final result = await _pollinations.generateImage(request);
    _captureAiFailure(result, 'pollinations', 'generateImage');
    return result;
  }

  void _addAiBreadcrumb(String provider, String endpoint) {
    _errorReporter.addBreadcrumb(
      message: 'AI request: $provider/$endpoint',
      category: 'ai_request',
      data: {'provider': provider, 'endpoint': endpoint},
    );
  }

  void _captureAiFailure<T>(
    AIResult<T> result,
    String provider,
    String endpoint,
  ) {
    if (result.isSuccess) {
      return;
    }
    final error = result.errorOrNull;
    if (error == null) {
      return;
    }
    _errorReporter.captureException(
      error,
      extra: {'provider': provider, 'endpoint': endpoint},
      hint: 'ai_router_failure',
    );
  }

  /// Builds a deterministic cache key for an AI request payload.
  static String cacheKeyFor(String type, Map<String, Object?> payload) {
    final canonical = jsonEncode(payload);
    final hash = sha256.convert(utf8.encode(canonical));
    return 'ai:$type:$hash';
  }
}
