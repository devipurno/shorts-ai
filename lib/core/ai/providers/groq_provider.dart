import 'dart:io';

import 'package:dio/dio.dart';

import '../../env/env.dart';
import '../../network/dio_client.dart';
import '../../utils/result.dart';
import '../ai_service.dart';
import '../models/ai_request.dart';
import 'provider_utils.dart';

/// Public API surface for `GroqProvider`.
class GroqProvider implements LLMProvider, STTProvider {
  GroqProvider({Dio? dio, String? apiKey})
      : _dio = dio ?? DioClient.instance.dio,
        _apiKey = apiKey ?? Env.groqApiKey;

  static const chatEndpoint = 'https://api.groq.com/openai/v1/chat/completions';
  static const transcriptionEndpoint =
      'https://api.groq.com/openai/v1/audio/transcriptions';
  static const chatModel = 'llama-3.3-70b-versatile';
  static const whisperModel = 'whisper-large-v3';

  final Dio _dio;
  final String? _apiKey;

  @override
  String get providerName => 'groq';

  @override
  Future<AIResult<LLMResponse>> generateText(LLMRequest request) async {
    final key = _apiKey;
    if (key == null || key.isEmpty) {
      return const Result.failure(
        AIProviderError.invalidRequest(
          provider: 'groq',
          message: 'GROQ_API_KEY is not configured.',
        ),
      );
    }
    try {
      final response = await _dio.post<dynamic>(
        chatEndpoint,
        options: Options(headers: bearerHeaders(key)),
        data: {
          'model': chatModel,
          'temperature': request.temperature,
          'max_tokens': request.maxTokens,
          'messages': [
            if (request.systemPrompt != null)
              {'role': 'system', 'content': request.systemPrompt},
            {'role': 'user', 'content': request.prompt},
          ],
        },
      );
      return _parseOpenAiText(response.data, providerName);
    } catch (error) {
      return aiFailure(providerName, error);
    }
  }

  @override
  Future<AIResult<STTResponse>> transcribeAudio(STTRequest request) async {
    final key = _apiKey;
    if (key == null || key.isEmpty) {
      return const Result.failure(
        AIProviderError.invalidRequest(
          provider: 'groq_whisper',
          message: 'GROQ_API_KEY is not configured.',
        ),
      );
    }
    try {
      final file = File(request.filePath);
      final form = FormData.fromMap({
        'model': request.model,
        'language': request.language,
        'file': await MultipartFile.fromFile(file.path),
      });
      final response = await _dio.post<dynamic>(
        transcriptionEndpoint,
        options: Options(headers: {'Authorization': 'Bearer $key'}),
        data: form,
      );
      final data = Map<String, dynamic>.from(response.data as Map);
      final text = data['text']?.toString();
      if (text == null || text.isEmpty) {
        return const Result.failure(
          AIProviderError.invalidResponse(
            provider: 'groq_whisper',
            message: 'Groq transcription response did not include text.',
          ),
        );
      }
      return Result.success(
        STTResponse(
          text: text,
          provider: 'groq_whisper',
          language: request.language,
          raw: data.cast<String, Object?>(),
        ),
      );
    } catch (error) {
      return aiFailure('groq_whisper', error);
    }
  }
}

AIResult<LLMResponse> _parseOpenAiText(Object? raw, String provider) {
  final data = Map<String, dynamic>.from(raw as Map);
  final choices = data['choices'] as List<dynamic>?;
  final first = choices?.firstOrNull as Map<String, dynamic>?;
  final message = first?['message'] as Map<String, dynamic>?;
  final text = message?['content']?.toString();
  if (text == null || text.isEmpty) {
    return Result.failure(
      AIProviderError.invalidResponse(
        provider: provider,
        message: '$provider response did not include message content.',
      ),
    );
  }
  final usage = data['usage'] as Map<String, dynamic>?;
  return Result.success(
    LLMResponse(
      text: text,
      provider: provider,
      inputTokens: (usage?['prompt_tokens'] as num?)?.toInt() ?? 0,
      outputTokens: (usage?['completion_tokens'] as num?)?.toInt() ?? 0,
      raw: data.cast<String, Object?>(),
    ),
  );
}
