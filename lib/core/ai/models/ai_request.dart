import 'package:freezed_annotation/freezed_annotation.dart';

part 'ai_request.freezed.dart';
part 'ai_request.g.dart';

@freezed
abstract class LLMRequest with _$LLMRequest {
  const factory LLMRequest({
    required String prompt,
    String? systemPrompt,
    @Default(0.7) double temperature,
    @Default(1024) int maxTokens,
    @Default(<String, Object?>{}) Map<String, Object?> metadata,
  }) = _LLMRequest;

  factory LLMRequest.fromJson(Map<String, Object?> json) =>
      _$LLMRequestFromJson(json);
}

@freezed
abstract class STTRequest with _$STTRequest {
  const factory STTRequest({
    required String filePath,
    @Default('id') String language,
    @Default('whisper-large-v3') String model,
  }) = _STTRequest;

  factory STTRequest.fromJson(Map<String, Object?> json) =>
      _$STTRequestFromJson(json);
}

@freezed
abstract class TTSRequest with _$TTSRequest {
  const factory TTSRequest({
    required String text,
    @Default('id-ID-ArdiNeural') String voice,
    @Default('+0%') String rate,
    @Default('+0Hz') String pitch,
    @Default('+0%') String volume,
  }) = _TTSRequest;

  factory TTSRequest.fromJson(Map<String, Object?> json) =>
      _$TTSRequestFromJson(json);
}

@freezed
abstract class ImageRequest with _$ImageRequest {
  const factory ImageRequest({
    required String prompt,
    @Default(1024) int width,
    @Default(1024) int height,
    @Default('flux') String model,
    int? seed,
  }) = _ImageRequest;

  factory ImageRequest.fromJson(Map<String, Object?> json) =>
      _$ImageRequestFromJson(json);
}

@freezed
abstract class LLMResponse with _$LLMResponse {
  const factory LLMResponse({
    required String text,
    required String provider,
    @Default(0) int inputTokens,
    @Default(0) int outputTokens,
    @Default(0) double estimatedCostUsd,
    @Default(<String, Object?>{}) Map<String, Object?> raw,
  }) = _LLMResponse;

  factory LLMResponse.fromJson(Map<String, Object?> json) =>
      _$LLMResponseFromJson(json);
}

@freezed
abstract class STTResponse with _$STTResponse {
  const factory STTResponse({
    required String text,
    required String provider,
    @Default('id') String language,
    @Default(<String, Object?>{}) Map<String, Object?> raw,
  }) = _STTResponse;

  factory STTResponse.fromJson(Map<String, Object?> json) =>
      _$STTResponseFromJson(json);
}

@freezed
abstract class TTSResponse with _$TTSResponse {
  const factory TTSResponse({
    required String audioPath,
    required String provider,
    required String voice,
    @Default('audio/mpeg') String mimeType,
  }) = _TTSResponse;

  factory TTSResponse.fromJson(Map<String, Object?> json) =>
      _$TTSResponseFromJson(json);
}

@freezed
abstract class ImageResponse with _$ImageResponse {
  const factory ImageResponse({
    required String imagePath,
    required String provider,
    required String model,
    @Default('image/png') String mimeType,
  }) = _ImageResponse;

  factory ImageResponse.fromJson(Map<String, Object?> json) =>
      _$ImageResponseFromJson(json);
}

@freezed
sealed class AIProviderError with _$AIProviderError {
  const factory AIProviderError.quotaExceeded({
    required String provider,
    String? message,
  }) = QuotaExceeded;

  const factory AIProviderError.networkError({
    required String provider,
    required String message,
  }) = NetworkAIError;

  const factory AIProviderError.invalidResponse({
    required String provider,
    required String message,
  }) = InvalidAIResponse;

  const factory AIProviderError.timeout({
    required String provider,
    required String message,
  }) = TimeoutAIError;

  const factory AIProviderError.invalidRequest({
    required String provider,
    required String message,
  }) = InvalidAIRequest;

  const factory AIProviderError.allProvidersExhausted({
    @Default('All configured AI providers are exhausted or unavailable.')
    String message,
  }) = AllProvidersExhausted;
}
