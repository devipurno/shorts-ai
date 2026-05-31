// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'script.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Script _$ScriptFromJson(Map<String, dynamic> json) => _Script(
      id: json['id'] as String,
      projectId: json['project_id'] as String,
      content: json['content'] as String? ?? '',
      hookOptions: (json['hook_options'] as List<dynamic>?)
              ?.map((e) => HookOption.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const <HookOption>[],
      selectedHookId: json['selected_hook_id'] as String?,
      language: json['language'] as String? ?? 'id',
      durationEstimate: (json['duration_estimate'] as num?)?.toInt() ?? 0,
      aiModelUsed: json['ai_model_used'] as String? ?? '',
      generatedAt: DateTime.parse(json['generated_at'] as String),
    );

Map<String, dynamic> _$ScriptToJson(_Script instance) => <String, dynamic>{
      'id': instance.id,
      'project_id': instance.projectId,
      'content': instance.content,
      'hook_options': instance.hookOptions.map((e) => e.toJson()).toList(),
      'selected_hook_id': instance.selectedHookId,
      'language': instance.language,
      'duration_estimate': instance.durationEstimate,
      'ai_model_used': instance.aiModelUsed,
      'generated_at': instance.generatedAt.toIso8601String(),
    };

_HookOption _$HookOptionFromJson(Map<String, dynamic> json) => _HookOption(
      id: json['id'] as String,
      text: json['text'] as String? ?? '',
      style: $enumDecodeNullable(_$HookStyleEnumMap, json['style']) ??
          HookStyle.statement,
      score: (json['score'] as num?)?.toDouble() ?? 0,
    );

Map<String, dynamic> _$HookOptionToJson(_HookOption instance) =>
    <String, dynamic>{
      'id': instance.id,
      'text': instance.text,
      'style': _$HookStyleEnumMap[instance.style]!,
      'score': instance.score,
    };

const _$HookStyleEnumMap = {
  HookStyle.question: 'question',
  HookStyle.statement: 'statement',
  HookStyle.shock: 'shock',
  HookStyle.story: 'story',
  HookStyle.curiosity: 'curiosity',
};
