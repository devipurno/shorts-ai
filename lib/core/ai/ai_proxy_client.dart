import 'package:dio/dio.dart';

import '../../shared/services/supabase_service.dart';
import '../env/env.dart';
import '../network/dio_client.dart';
import '../utils/result.dart';
import 'ai_service.dart';
import 'models/ai_request.dart';
import 'providers/provider_utils.dart';

/// Text-generation provider that calls the Cloudflare AI proxy gateway.
///
/// The mobile client keeps the [AIRouter] facade, but provider API keys live in
/// the Worker. A Supabase access token is attached as bearer auth for the proxy.
class AIProxyClient implements LLMProvider {
  AIProxyClient({
    Dio? dio,
    String? baseUrl,
    String? provider,
    Future<String?> Function()? accessTokenProvider,
  })  : _dio = dio ?? DioClient.instance.dio,
        _baseUrl =
            (baseUrl ?? Env.aiProxyBaseUrl).replaceAll(RegExp(r'/+$'), ''),
        _provider = provider ?? Env.defaultLlmProvider ?? 'gemini',
        _accessTokenProvider = accessTokenProvider ?? _defaultAccessToken;

  final Dio _dio;
  final String _baseUrl;
  final String _provider;
  final Future<String?> Function() _accessTokenProvider;

  @override
  String get providerName => 'ai_proxy';

  @override
  Future<AIResult<LLMResponse>> generateText(LLMRequest request) async {
    final token = await _accessTokenProvider();
    if (token == null || token.isEmpty) {
      return const Result.failure(
        AIProviderError.invalidRequest(
          provider: 'ai_proxy',
          message: 'Login required before using AI features.',
        ),
      );
    }

    final provider = (request.metadata['provider']?.toString() ?? _provider)
        .toLowerCase()
        .trim();
    final path = switch (provider) {
      'groq' => '/ai/groq/chat',
      'deepseek' => '/ai/deepseek/chat',
      _ => '/ai/gemini/generate',
    };

    try {
      final response = await _dio.post<dynamic>(
        '$_baseUrl$path',
        options: Options(headers: {'Authorization': 'Bearer $token'}),
        data: request.toJson(),
      );
      final data = Map<String, dynamic>.from(response.data as Map);
      final text = data['text']?.toString();
      if (text == null || text.isEmpty) {
        return const Result.failure(
          AIProviderError.invalidResponse(
            provider: 'ai_proxy',
            message: 'AI proxy response did not include text.',
          ),
        );
      }
      return Result.success(
        LLMResponse(
          text: text,
          provider: data['provider']?.toString() ?? provider,
          inputTokens: (data['inputTokens'] as num?)?.toInt() ?? 0,
          outputTokens: (data['outputTokens'] as num?)?.toInt() ?? 0,
          raw: data.cast<String, Object?>(),
        ),
      );
    } on DioException catch (error) {
      if (error.response?.statusCode == 429) {
        return const Result.failure(
          AIProviderError.quotaExceeded(
            provider: 'ai_proxy',
            message:
                'Limit AI harian sudah habis. Coba lagi besok atau upgrade plan.',
          ),
        );
      }
      if (error.response?.statusCode == 401) {
        return const Result.failure(
          AIProviderError.invalidRequest(
            provider: 'ai_proxy',
            message: 'Sesi login kedaluwarsa. Silakan masuk ulang.',
          ),
        );
      }
      return aiFailure('ai_proxy', error);
    } catch (error) {
      return aiFailure('ai_proxy', error);
    }
  }

  static Future<String?> _defaultAccessToken() async {
    if (!SupabaseService.isInitialized) {
      return null;
    }
    return SupabaseService().accessToken;
  }
}
