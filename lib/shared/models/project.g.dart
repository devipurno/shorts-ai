// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'project.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Project _$ProjectFromJson(Map<String, dynamic> json) => _Project(
      id: json['id'] as String,
      userId: json['user_id'] as String,
      title: json['title'] as String? ?? 'Untitled project',
      description: json['description'] as String? ?? '',
      status: $enumDecodeNullable(_$ProjectStatusEnumMap, json['status']) ??
          ProjectStatus.draft,
      originalVideoUrl: json['original_video_url'] as String?,
      processedVideoUrl: json['processed_video_url'] as String?,
      thumbnailUrl: json['thumbnail_url'] as String?,
      duration: (json['duration'] as num?)?.toInt() ?? 0,
      aspectRatio: json['aspect_ratio'] as String? ?? '9:16',
      resolution: json['resolution'] as String? ?? '1080x1920',
      templateId: json['template_id'] as String?,
      brandKitId: json['brand_kit_id'] as String?,
      tags:
          (json['tags'] as List<dynamic>?)?.map((e) => e as String).toList() ??
              const <String>[],
      createdAt: DateTime.parse(json['created_at'] as String),
      updatedAt: DateTime.parse(json['updated_at'] as String),
      publishedAt: json['published_at'] == null
          ? null
          : DateTime.parse(json['published_at'] as String),
    );

Map<String, dynamic> _$ProjectToJson(_Project instance) => <String, dynamic>{
      'id': instance.id,
      'user_id': instance.userId,
      'title': instance.title,
      'description': instance.description,
      'status': _$ProjectStatusEnumMap[instance.status]!,
      'original_video_url': instance.originalVideoUrl,
      'processed_video_url': instance.processedVideoUrl,
      'thumbnail_url': instance.thumbnailUrl,
      'duration': instance.duration,
      'aspect_ratio': instance.aspectRatio,
      'resolution': instance.resolution,
      'template_id': instance.templateId,
      'brand_kit_id': instance.brandKitId,
      'tags': instance.tags,
      'created_at': instance.createdAt.toIso8601String(),
      'updated_at': instance.updatedAt.toIso8601String(),
      'published_at': instance.publishedAt?.toIso8601String(),
    };

const _$ProjectStatusEnumMap = {
  ProjectStatus.draft: 'draft',
  ProjectStatus.processing: 'processing',
  ProjectStatus.ready: 'ready',
  ProjectStatus.published: 'published',
};
