// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'template.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Template _$TemplateFromJson(Map<String, dynamic> json) => _Template(
      id: json['id'] as String,
      name: json['name'] as String? ?? '',
      description: json['description'] as String? ?? '',
      category: json['category'] as String? ?? 'general',
      thumbnailUrl: json['thumbnail_url'] as String?,
      previewVideoUrl: json['preview_video_url'] as String?,
      structure: json['structure'] == null
          ? const TemplateStructure()
          : TemplateStructure.fromJson(
              json['structure'] as Map<String, dynamic>),
      difficulty: $enumDecodeNullable(
              _$TemplateDifficultyEnumMap, json['difficulty']) ??
          TemplateDifficulty.easy,
      tier: $enumDecodeNullable(_$TemplateTierEnumMap, json['tier']) ??
          TemplateTier.free,
      timesUsed: (json['times_used'] as num?)?.toInt() ?? 0,
      rating: (json['rating'] as num?)?.toDouble() ?? 0,
    );

Map<String, dynamic> _$TemplateToJson(_Template instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'description': instance.description,
      'category': instance.category,
      'thumbnail_url': instance.thumbnailUrl,
      'preview_video_url': instance.previewVideoUrl,
      'structure': instance.structure.toJson(),
      'difficulty': _$TemplateDifficultyEnumMap[instance.difficulty]!,
      'tier': _$TemplateTierEnumMap[instance.tier]!,
      'times_used': instance.timesUsed,
      'rating': instance.rating,
    };

const _$TemplateDifficultyEnumMap = {
  TemplateDifficulty.easy: 'easy',
  TemplateDifficulty.medium: 'medium',
  TemplateDifficulty.advanced: 'advanced',
};

const _$TemplateTierEnumMap = {
  TemplateTier.free: 'free',
  TemplateTier.premium: 'premium',
};

_TemplateStructure _$TemplateStructureFromJson(Map<String, dynamic> json) =>
    _TemplateStructure(
      duration: (json['duration'] as num?)?.toInt() ?? 0,
      hooks:
          (json['hooks'] as List<dynamic>?)?.map((e) => e as String).toList() ??
              const <String>[],
      segments: (json['segments'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const <String>[],
      transitions: (json['transitions'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const <String>[],
      music:
          (json['music'] as List<dynamic>?)?.map((e) => e as String).toList() ??
              const <String>[],
    );

Map<String, dynamic> _$TemplateStructureToJson(_TemplateStructure instance) =>
    <String, dynamic>{
      'duration': instance.duration,
      'hooks': instance.hooks,
      'segments': instance.segments,
      'transitions': instance.transitions,
      'music': instance.music,
    };
