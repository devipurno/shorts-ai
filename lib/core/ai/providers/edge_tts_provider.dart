import 'dart:io';

import 'package:edge_tts/edge_tts.dart';

import '../../utils/result.dart';
import '../ai_service.dart';
import '../models/ai_request.dart';

typedef EdgeTtsSynthesizer = Future<void> Function({
  required TTSRequest request,
  required String outputPath,
});

class EdgeTTSProvider implements TTSProvider {
  EdgeTTSProvider({EdgeTtsSynthesizer? synthesizer})
      : _synthesizer = synthesizer ?? _edgeTtsSave;

  final EdgeTtsSynthesizer _synthesizer;

  @override
  String get providerName => 'edge_tts';

  @override
  Future<AIResult<TTSResponse>> generateSpeech(TTSRequest request) async {
    if (request.text.trim().isEmpty) {
      return const Result.failure(
        AIProviderError.invalidRequest(
          provider: 'edge_tts',
          message: 'TTS text must not be empty.',
        ),
      );
    }
    try {
      final output = File(_tempPath('autoshort-tts', 'mp3'));
      await output.parent.create(recursive: true);
      await _synthesizer(request: request, outputPath: output.path);
      return Result.success(
        TTSResponse(
          audioPath: output.path,
          provider: providerName,
          voice: request.voice,
        ),
      );
    } catch (error) {
      return Result.failure(
        AIProviderError.networkError(
          provider: providerName,
          message: error.toString(),
        ),
      );
    }
  }
}

Future<void> _edgeTtsSave({
  required TTSRequest request,
  required String outputPath,
}) {
  final communicate = Communicate(
    text: request.text,
    voice: request.voice,
    rate: request.rate,
    pitch: request.pitch,
    volume: request.volume,
  );
  return communicate.save(outputPath);
}

String _tempPath(String prefix, String extension) {
  final stamp = DateTime.now().microsecondsSinceEpoch;
  return '${Directory.systemTemp.path}${Platform.pathSeparator}$prefix-$stamp.$extension';
}
