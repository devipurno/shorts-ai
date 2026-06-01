import 'models/ai_request.dart';
import '../utils/result.dart';

/// Result type used by AI services to avoid throwing provider-specific errors.
typedef AIResult<T> = Result<T, AIProviderError>;

/// Unified AI facade for text, speech-to-text, text-to-speech, and images.
///
/// ```dart
/// final result = await aiService.generateText(request);
/// ```
///
/// Returns [AIProviderError] failures when all configured providers are
/// exhausted, unavailable, or return invalid data.
abstract interface class AIService {
  Future<AIResult<LLMResponse>> generateText(LLMRequest request);

  Future<AIResult<STTResponse>> transcribeAudio(STTRequest request);

  Future<AIResult<TTSResponse>> generateSpeech(TTSRequest request);

  Future<AIResult<ImageResponse>> generateImage(ImageRequest request);
}

/// Text generation provider used by [AIRouter] fallback chains.
abstract interface class LLMProvider {
  String get providerName;

  Future<AIResult<LLMResponse>> generateText(LLMRequest request);
}

/// Speech-to-text provider used for transcript generation.
abstract interface class STTProvider {
  String get providerName;

  Future<AIResult<STTResponse>> transcribeAudio(STTRequest request);
}

/// Text-to-speech provider used for voice draft generation.
abstract interface class TTSProvider {
  String get providerName;

  Future<AIResult<TTSResponse>> generateSpeech(TTSRequest request);
}

/// Image generation provider used for thumbnail concepts.
abstract interface class AIImageProvider {
  String get providerName;

  Future<AIResult<ImageResponse>> generateImage(ImageRequest request);
}
