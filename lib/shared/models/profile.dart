import 'package:freezed_annotation/freezed_annotation.dart';

part 'profile.freezed.dart';
part 'profile.g.dart';

@JsonEnum(fieldRename: FieldRename.snake)
enum CreatorNiche {
  lifestyle,
  tech,
  food,
  fitness,
  finance,
  education,
  entertainment,
  other,
}

@freezed
abstract class CreatorProfile with _$CreatorProfile {
  const factory CreatorProfile({
    @JsonKey(name: 'user_id') required String userId,
    @JsonKey(name: 'display_name') @Default('') String displayName,
    @Default('') String bio,
    @JsonKey(name: 'instagram_handle') String? instagramHandle,
    @JsonKey(name: 'youtube_handle') String? youtubeHandle,
    @JsonKey(name: 'tiktok_handle') String? tiktokHandle,
    @Default(CreatorNiche.other) CreatorNiche niche,
    @JsonKey(name: 'target_audience') @Default('') String targetAudience,
    @JsonKey(name: 'content_language') @Default('id') String contentLanguage,
    @JsonKey(name: 'brand_kit_id') String? brandKitId,
  }) = _CreatorProfile;

  factory CreatorProfile.fromJson(Map<String, Object?> json) =>
      _$CreatorProfileFromJson(json);
}
