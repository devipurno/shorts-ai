// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ai_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_LLMRequest _$LLMRequestFromJson(Map<String, dynamic> json) => _LLMRequest(
      prompt: json['prompt'] as String,
      systemPrompt: json['systemPrompt'] as String?,
      temperature: (json['temperature'] as num?)?.toDouble() ?? 0.7,
      maxTokens: (json['maxTokens'] as num?)?.toInt() ?? 1024,
      metadata: json['metadata'] as Map<String, dynamic>? ??
          const <String, Object?>{},
    );

Map<String, dynamic> _$LLMRequestToJson(_LLMRequest instance) =>
    <String, dynamic>{
      'prompt': instance.prompt,
      'systemPrompt': instance.systemPrompt,
      'temperature': instance.temperature,
      'maxTokens': instance.maxTokens,
      'metadata': instance.metadata,
    };

_STTRequest _$STTRequestFromJson(Map<String, dynamic> json) => _STTRequest(
      filePath: json['filePath'] as String,
      language: json['language'] as String? ?? 'id',
      model: json['model'] as String? ?? 'whisper-large-v3',
    );

Map<String, dynamic> _$STTRequestToJson(_STTRequest instance) =>
    <String, dynamic>{
      'filePath': instance.filePath,
      'language': instance.language,
      'model': instance.model,
    };

_TTSRequest _$TTSRequestFromJson(Map<String, dynamic> json) => _TTSRequest(
      text: json['text'] as String,
      voice: json['voice'] as String? ?? 'id-ID-ArdiNeural',
      rate: json['rate'] as String? ?? '+0%',
      pitch: json['pitch'] as String? ?? '+0Hz',
      volume: json['volume'] as String? ?? '+0%',
    );

Map<String, dynamic> _$TTSRequestToJson(_TTSRequest instance) =>
    <String, dynamic>{
      'text': instance.text,
      'voice': instance.voice,
      'rate': instance.rate,
      'pitch': instance.pitch,
      'volume': instance.volume,
    };

_ImageRequest _$ImageRequestFromJson(Map<String, dynamic> json) =>
    _ImageRequest(
      prompt: json['prompt'] as String,
      width: (json['width'] as num?)?.toInt() ?? 1024,
      height: (json['height'] as num?)?.toInt() ?? 1024,
      model: json['model'] as String? ?? 'flux',
      seed: (json['seed'] as num?)?.toInt(),
    );

Map<String, dynamic> _$ImageRequestToJson(_ImageRequest instance) =>
    <String, dynamic>{
      'prompt': instance.prompt,
      'width': instance.width,
      'height': instance.height,
      'model': instance.model,
      'seed': instance.seed,
    };

_LLMResponse _$LLMResponseFromJson(Map<String, dynamic> json) => _LLMResponse(
      text: json['text'] as String,
      provider: json['provider'] as String,
      inputTokens: (json['inputTokens'] as num?)?.toInt() ?? 0,
      outputTokens: (json['outputTokens'] as num?)?.toInt() ?? 0,
      estimatedCostUsd: (json['estimatedCostUsd'] as num?)?.toDouble() ?? 0,
      raw: json['raw'] as Map<String, dynamic>? ?? const <String, Object?>{},
    );

Map<String, dynamic> _$LLMResponseToJson(_LLMResponse instance) =>
    <String, dynamic>{
      'text': instance.text,
      'provider': instance.provider,
      'inputTokens': instance.inputTokens,
      'outputTokens': instance.outputTokens,
      'estimatedCostUsd': instance.estimatedCostUsd,
      'raw': instance.raw,
    };

_STTResponse _$STTResponseFromJson(Map<String, dynamic> json) => _STTResponse(
      text: json['text'] as String,
      provider: json['provider'] as String,
      language: json['language'] as String? ?? 'id',
      raw: json['raw'] as Map<String, dynamic>? ?? const <String, Object?>{},
    );

Map<String, dynamic> _$STTResponseToJson(_STTResponse instance) =>
    <String, dynamic>{
      'text': instance.text,
      'provider': instance.provider,
      'language': instance.language,
      'raw': instance.raw,
    };

_TTSResponse _$TTSResponseFromJson(Map<String, dynamic> json) => _TTSResponse(
      audioPath: json['audioPath'] as String,
      provider: json['provider'] as String,
      voice: json['voice'] as String,
      mimeType: json['mimeType'] as String? ?? 'audio/mpeg',
    );

Map<String, dynamic> _$TTSResponseToJson(_TTSResponse instance) =>
    <String, dynamic>{
      'audioPath': instance.audioPath,
      'provider': instance.provider,
      'voice': instance.voice,
      'mimeType': instance.mimeType,
    };

_ImageResponse _$ImageResponseFromJson(Map<String, dynamic> json) =>
    _ImageResponse(
      imagePath: json['imagePath'] as String,
      provider: json['provider'] as String,
      model: json['model'] as String,
      mimeType: json['mimeType'] as String? ?? 'image/png',
    );

Map<String, dynamic> _$ImageResponseToJson(_ImageResponse instance) =>
    <String, dynamic>{
      'imagePath': instance.imagePath,
      'provider': instance.provider,
      'model': instance.model,
      'mimeType': instance.mimeType,
    };
