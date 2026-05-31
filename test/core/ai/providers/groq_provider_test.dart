import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http_mock_adapter/http_mock_adapter.dart';
import 'package:shorts_ai/core/ai/models/ai_request.dart';
import 'package:shorts_ai/core/ai/providers/groq_provider.dart';

void main() {
  test('GroqProvider sends OpenAI-compatible chat request', () async {
    final dio = Dio();
    final adapter = DioAdapter(dio: dio, matcher: const UrlRequestMatcher(matchMethod: true));
    late Map<String, dynamic> body;

    adapter.onPost(
      GroqProvider.chatEndpoint,
      (server) => server.replyCallback(200, (options) {
        body = Map<String, dynamic>.from(options.data as Map);
        expect(options.headers['Authorization'], 'Bearer groq-key');
        return {
          'choices': [
            {
              'message': {'content': 'Groq answer'},
            },
          ],
          'usage': {'prompt_tokens': 10, 'completion_tokens': 5},
        };
      }),
    );

    final provider = GroqProvider(dio: dio, apiKey: 'groq-key');
    final result = await provider.generateText(const LLMRequest(prompt: 'Hi'));

    expect(result.getOrThrow().text, 'Groq answer');
    expect(body['model'], GroqProvider.chatModel);
  });

  test('GroqProvider transcribes audio with Whisper Large V3', () async {
    final dio = Dio();
    final adapter = DioAdapter(dio: dio, matcher: const UrlRequestMatcher(matchMethod: true));
    final file = File('${Directory.systemTemp.path}/groq-provider-test.wav');
    await file.writeAsBytes([1, 2, 3]);

    adapter.onPost(
      GroqProvider.transcriptionEndpoint,
      (server) => server.replyCallback(200, (options) {
        expect(options.data, isA<FormData>());
        return {'text': 'transkrip'};
      }),
    );

    final provider = GroqProvider(dio: dio, apiKey: 'groq-key');
    final result = await provider.transcribeAudio(STTRequest(filePath: file.path));

    expect(result.getOrThrow().text, 'transkrip');
  });
}
