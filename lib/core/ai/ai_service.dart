import 'models/ai_request.dart';
import '../utils/result.dart';

typedef AIResult<T> = Result<T, AIProviderError>;

abstract interface class AIService {
  Future<AIResult<LLMResponse>> generateText(LLMRequest request);

  Future<AIResult<STTResponse>> transcribeAudio(STTRequest request);

  Future<AIResult<TTSResponse>> generateSpeech(TTSRequest request);

  Future<AIResult<ImageResponse>> generateImage(ImageRequest request);
}

abstract interface class LLMProvider {
  String get providerName;

  Future<AIResult<LLMResponse>> generateText(LLMRequest request);
}

abstract interface class STTProvider {
  String get providerName;

  Future<AIResult<STTResponse>> transcribeAudio(STTRequest request);
}

abstract interface class TTSProvider {
  String get providerName;

  Future<AIResult<TTSResponse>> generateSpeech(TTSRequest request);
}

abstract interface class AIImageProvider {
  String get providerName;

  Future<AIResult<ImageResponse>> generateImage(ImageRequest request);
}
