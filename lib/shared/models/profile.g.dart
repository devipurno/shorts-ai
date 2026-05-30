// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'profile.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_CreatorProfile _$CreatorProfileFromJson(Map<String, dynamic> json) =>
    _CreatorProfile(
      userId: json['user_id'] as String,
      displayName: json['display_name'] as String? ?? '',
      bio: json['bio'] as String? ?? '',
      instagramHandle: json['instagram_handle'] as String?,
      youtubeHandle: json['youtube_handle'] as String?,
      tiktokHandle: json['tiktok_handle'] as String?,
      niche: $enumDecodeNullable(_$CreatorNicheEnumMap, json['niche']) ??
          CreatorNiche.other,
      targetAudience: json['target_audience'] as String? ?? '',
      contentLanguage: json['content_language'] as String? ?? 'id',
      brandKitId: json['brand_kit_id'] as String?,
    );

Map<String, dynamic> _$CreatorProfileToJson(_CreatorProfile instance) =>
    <String, dynamic>{
      'user_id': instance.userId,
      'display_name': instance.displayName,
      'bio': instance.bio,
      'instagram_handle': instance.instagramHandle,
      'youtube_handle': instance.youtubeHandle,
      'tiktok_handle': instance.tiktokHandle,
      'niche': _$CreatorNicheEnumMap[instance.niche]!,
      'target_audience': instance.targetAudience,
      'content_language': instance.contentLanguage,
      'brand_kit_id': instance.brandKitId,
    };

const _$CreatorNicheEnumMap = {
  CreatorNiche.lifestyle: 'lifestyle',
  CreatorNiche.tech: 'tech',
  CreatorNiche.food: 'food',
  CreatorNiche.fitness: 'fitness',
  CreatorNiche.finance: 'finance',
  CreatorNiche.education: 'education',
  CreatorNiche.entertainment: 'entertainment',
  CreatorNiche.other: 'other',
};
