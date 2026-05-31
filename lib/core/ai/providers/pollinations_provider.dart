import 'dart:io';

import 'package:dio/dio.dart';

import '../../network/dio_client.dart';
import '../../utils/result.dart';
import '../ai_service.dart';
import '../models/ai_request.dart';
import 'provider_utils.dart';

class PollinationsProvider implements AIImageProvider {
  PollinationsProvider({Dio? dio}) : _dio = dio ?? DioClient.instance.dio;

  final Dio _dio;

  @override
  String get providerName => 'pollinations';

  @override
  Future<AIResult<ImageResponse>> generateImage(ImageRequest request) async {
    if (request.prompt.trim().isEmpty) {
      return const Result.failure(
        AIProviderError.invalidRequest(
          provider: 'pollinations',
          message: 'Image prompt must not be empty.',
        ),
      );
    }
    try {
      final encodedPrompt = Uri.encodeComponent(request.prompt);
      final response = await _dio.get<List<int>>(
        'https://image.pollinations.ai/prompt/$encodedPrompt',
        queryParameters: {
          'width': request.width,
          'height': request.height,
          'model': request.model,
          if (request.seed != null) 'seed': request.seed,
        },
        options: Options(responseType: ResponseType.bytes),
      );
      final bytes = response.data;
      if (bytes == null || bytes.isEmpty) {
        return const Result.failure(
          AIProviderError.invalidResponse(
            provider: 'pollinations',
            message: 'Pollinations response did not include image bytes.',
          ),
        );
      }
      final output = File(_tempPath('autoshort-image', 'png'));
      await output.parent.create(recursive: true);
      await output.writeAsBytes(bytes);
      return Result.success(
        ImageResponse(
          imagePath: output.path,
          provider: providerName,
          model: request.model,
        ),
      );
    } catch (error) {
      return aiFailure(providerName, error);
    }
  }
}

String _tempPath(String prefix, String extension) {
  final stamp = DateTime.now().microsecondsSinceEpoch;
  return '${Directory.systemTemp.path}${Platform.pathSeparator}$prefix-$stamp.$extension';
}
