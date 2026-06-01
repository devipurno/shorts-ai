import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http_mock_adapter/http_mock_adapter.dart';
import 'package:shorts_ai/core/ai/models/ai_request.dart';
import 'package:shorts_ai/core/ai/providers/gemini_provider.dart';

void main() {
  test('GeminiProvider sends generateContent request and parses text',
      () async {
    final dio = Dio();
    final adapter = DioAdapter(
        dio: dio, matcher: const UrlRequestMatcher(matchMethod: true));
    late Map<String, dynamic> body;

    adapter.onPost(
      GeminiProvider.endpoint,
      (server) => server.replyCallback(200, (options) {
        body = Map<String, dynamic>.from(options.data as Map);
        return {
          'candidates': [
            {
              'content': {
                'parts': [
                  {'text': 'Hook generated'},
                ],
              },
            },
          ],
        };
      }),
    );

    final provider = GeminiProvider(dio: dio, apiKey: 'gemini-key');
    final result = await provider.generateText(
      const LLMRequest(prompt: 'Topik', systemPrompt: 'Sistem'),
    );

    expect(result.getOrThrow().text, 'Hook generated');
    expect(body['contents'], isA<List<dynamic>>());
    expect(body['generationConfig']['maxOutputTokens'], 1024);
  });
}
