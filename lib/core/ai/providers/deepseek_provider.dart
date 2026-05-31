import 'package:dio/dio.dart';

import '../../env/env.dart';
import '../../network/dio_client.dart';
import '../../utils/result.dart';
import '../ai_service.dart';
import '../models/ai_request.dart';
import 'provider_utils.dart';

class DeepSeekProvider implements LLMProvider {
  DeepSeekProvider({Dio? dio, String? apiKey})
      : _dio = dio ?? DioClient.instance.dio,
        _apiKey = apiKey ?? Env.deepSeekApiKey;

  static const endpoint = 'https://api.deepseek.com/v1/chat/completions';
  static const model = 'deepseek-chat';
  static const inputUsdPerMillion = 0.14;
  static const outputUsdPerMillion = 0.28;

  final Dio _dio;
  final String? _apiKey;

  @override
  String get providerName => 'deepseek';

  @override
  Future<AIResult<LLMResponse>> generateText(LLMRequest request) async {
    final key = _apiKey;
    if (key == null || key.isEmpty) {
      return const Result.failure(
        AIProviderError.invalidRequest(
          provider: 'deepseek',
          message: 'DEEPSEEK_API_KEY is not configured.',
        ),
      );
    }
    try {
      final response = await _dio.post<dynamic>(
        endpoint,
        options: Options(headers: bearerHeaders(key)),
        data: {
          'model': model,
          'temperature': request.temperature,
          'max_tokens': request.maxTokens,
          'messages': [
            if (request.systemPrompt != null)
              {'role': 'system', 'content': request.systemPrompt},
            {'role': 'user', 'content': request.prompt},
          ],
        },
      );
      final data = Map<String, dynamic>.from(response.data as Map);
      final choices = data['choices'] as List<dynamic>?;
      final first = choices?.firstOrNull as Map<String, dynamic>?;
      final message = first?['message'] as Map<String, dynamic>?;
      final text = message?['content']?.toString();
      if (text == null || text.isEmpty) {
        return const Result.failure(
          AIProviderError.invalidResponse(
            provider: 'deepseek',
            message: 'DeepSeek response did not include message content.',
          ),
        );
      }
      final usage = data['usage'] as Map<String, dynamic>?;
      final input = (usage?['prompt_tokens'] as num?)?.toInt() ?? 0;
      final output = (usage?['completion_tokens'] as num?)?.toInt() ?? 0;
      return Result.success(
        LLMResponse(
          text: text,
          provider: providerName,
          inputTokens: input,
          outputTokens: output,
          estimatedCostUsd: estimateCost(input, output),
          raw: data.cast<String, Object?>(),
        ),
      );
    } catch (error) {
      return aiFailure(providerName, error);
    }
  }

  static double estimateCost(int inputTokens, int outputTokens) {
    return inputTokens / 1000000 * inputUsdPerMillion +
        outputTokens / 1000000 * outputUsdPerMillion;
  }
}
