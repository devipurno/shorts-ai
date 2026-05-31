import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:shorts_ai/core/ai/models/ai_request.dart';
import 'package:shorts_ai/core/ai/providers/edge_tts_provider.dart';

void main() {
  test('EdgeTTSProvider saves synthesized MP3 file', () async {
    final provider = EdgeTTSProvider(
      synthesizer: ({required request, required outputPath}) async {
        expect(request.voice, 'id-ID-GadisNeural');
        await File(outputPath).writeAsBytes([1, 2, 3, 4]);
      },
    );

    final result = await provider.generateSpeech(
      const TTSRequest(text: 'Halo kreator', voice: 'id-ID-GadisNeural'),
    );

    final response = result.getOrThrow();
    expect(response.provider, 'edge_tts');
    expect(await File(response.audioPath).exists(), isTrue);
  });
}
