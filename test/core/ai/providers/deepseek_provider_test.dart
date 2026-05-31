import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http_mock_adapter/http_mock_adapter.dart';
import 'package:shorts_ai/core/ai/models/ai_request.dart';
import 'package:shorts_ai/core/ai/providers/deepseek_provider.dart';

void main() {
  test('DeepSeekProvider parses OpenAI-compatible response and estimates cost',
      () async {
    final dio = Dio();
    final adapter = DioAdapter(dio: dio, matcher: const UrlRequestMatcher(matchMethod: true));

    adapter.onPost(
      DeepSeekProvider.endpoint,
      (server) => server.reply(200, {
        'choices': [
          {
            'message': {'content': 'Overflow answer'},
          },
        ],
        'usage': {'prompt_tokens': 1000000, 'completion_tokens': 1000000},
      }),
    );

    final provider = DeepSeekProvider(dio: dio, apiKey: 'deepseek-key');
    final result = await provider.generateText(const LLMRequest(prompt: 'Hi'));

    final response = result.getOrThrow();
    expect(response.text, 'Overflow answer');
    expect(response.estimatedCostUsd, closeTo(0.42, 0.001));
  });
}
