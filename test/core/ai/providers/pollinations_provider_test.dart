import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http_mock_adapter/http_mock_adapter.dart';
import 'package:shorts_ai/core/ai/models/ai_request.dart';
import 'package:shorts_ai/core/ai/providers/pollinations_provider.dart';

void main() {
  test('PollinationsProvider downloads generated image bytes', () async {
    final dio = Dio();
    final adapter = DioAdapter(dio: dio, matcher: const UrlRequestMatcher(matchMethod: true));
    final path = 'https://image.pollinations.ai/prompt/gold%20shorts';

    adapter.onGet(path, (server) => server.reply(200, [137, 80, 78, 71]));

    final provider = PollinationsProvider(dio: dio);
    final result = await provider.generateImage(
      const ImageRequest(prompt: 'gold shorts', model: 'flux'),
    );

    final response = result.getOrThrow();
    expect(response.model, 'flux');
    expect(await File(response.imagePath).exists(), isTrue);
  });
}
