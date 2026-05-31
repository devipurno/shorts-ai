import 'package:dio/dio.dart';

import '../../env/env.dart';
import '../../network/dio_client.dart';
import '../../utils/result.dart';
import '../ai_service.dart';
import '../models/ai_request.dart';
import 'provider_utils.dart';

class GeminiProvider implements LLMProvider {
  GeminiProvider({Dio? dio, String? apiKey})
      : _dio = dio ?? DioClient.instance.dio,
        _apiKey = apiKey ?? Env.geminiApiKey;

  static const model = 'gemini-2.0-flash-exp';
  static const endpoint =
      'https://generativelanguage.googleapis.com/v1beta/models/$model:generateContent';

  final Dio _dio;
  final String? _apiKey;

  @override
  String get providerName => 'gemini';

  @override
  Future<AIResult<LLMResponse>> generateText(LLMRequest request) async {
    final key = _apiKey;
    if (key == null || key.isEmpty) {
      return const Result.failure(
        AIProviderError.invalidRequest(
          provider: 'gemini',
          message: 'GEMINI_API_KEY is not configured.',
        ),
      );
    }

    try {
      final prompt = [
        if (request.systemPrompt != null) request.systemPrompt,
        request.prompt,
      ].whereType<String>().join('\n\n');
      final response = await _dio.post<dynamic>(
        endpoint,
        queryParameters: {'key': key},
        data: {
          'contents': [
            {
              'role': 'user',
              'parts': [
                {'text': prompt},
              ],
            },
          ],
          'generationConfig': {
            'temperature': request.temperature,
            'maxOutputTokens': request.maxTokens,
          },
        },
      );
      final data = Map<String, dynamic>.from(response.data as Map);
      final candidates = data['candidates'] as List<dynamic>?;
      final content = candidates?.firstOrNull as Map<String, dynamic>?;
      final parts = (content?['content'] as Map?)?['parts'] as List<dynamic>?;
      final text = (parts?.firstOrNull as Map?)?['text']?.toString();
      if (text == null || text.isEmpty) {
        return const Result.failure(
          AIProviderError.invalidResponse(
            provider: 'gemini',
            message: 'Gemini response did not include text.',
          ),
        );
      }
      return Result.success(
        LLMResponse(text: text, provider: providerName, raw: data.cast<String, Object?>()),
      );
    } catch (error) {
      return aiFailure(providerName, error);
    }
  }
}
