// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'thumbnail.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Thumbnail _$ThumbnailFromJson(Map<String, dynamic> json) => _Thumbnail(
      id: json['id'] as String,
      projectId: json['project_id'] as String,
      imageUrl: json['image_url'] as String? ?? '',
      isVariantA: json['is_variant_a'] as bool? ?? true,
      variantBImageUrl: json['variant_b_image_url'] as String?,
      ctrPrediction: (json['ctr_prediction'] as num?)?.toDouble() ?? 0,
      selectedVariant: $enumDecodeNullable(
              _$ThumbnailVariantEnumMap, json['selected_variant']) ??
          ThumbnailVariant.a,
    );

Map<String, dynamic> _$ThumbnailToJson(_Thumbnail instance) =>
    <String, dynamic>{
      'id': instance.id,
      'project_id': instance.projectId,
      'image_url': instance.imageUrl,
      'is_variant_a': instance.isVariantA,
      'variant_b_image_url': instance.variantBImageUrl,
      'ctr_prediction': instance.ctrPrediction,
      'selected_variant': _$ThumbnailVariantEnumMap[instance.selectedVariant]!,
    };

const _$ThumbnailVariantEnumMap = {
  ThumbnailVariant.a: 'a',
  ThumbnailVariant.b: 'b',
};
