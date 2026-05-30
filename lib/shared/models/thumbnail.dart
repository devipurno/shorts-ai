import 'package:freezed_annotation/freezed_annotation.dart';

part 'thumbnail.freezed.dart';
part 'thumbnail.g.dart';

@JsonEnum(fieldRename: FieldRename.snake)
enum ThumbnailVariant { a, b }

@freezed
abstract class Thumbnail with _$Thumbnail {
  const factory Thumbnail({
    required String id,
    @JsonKey(name: 'project_id') required String projectId,
    @JsonKey(name: 'image_url') @Default('') String imageUrl,
    @JsonKey(name: 'is_variant_a') @Default(true) bool isVariantA,
    @JsonKey(name: 'variant_b_image_url') String? variantBImageUrl,
    @JsonKey(name: 'ctr_prediction') @Default(0) double ctrPrediction,
    @JsonKey(name: 'selected_variant')
    @Default(ThumbnailVariant.a)
    ThumbnailVariant selectedVariant,
  }) = _Thumbnail;

  factory Thumbnail.fromJson(Map<String, Object?> json) =>
      _$ThumbnailFromJson(json);
}
