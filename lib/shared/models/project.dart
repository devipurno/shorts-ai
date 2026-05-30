import 'package:freezed_annotation/freezed_annotation.dart';

part 'project.freezed.dart';
part 'project.g.dart';

@JsonEnum(fieldRename: FieldRename.snake)
enum ProjectStatus { draft, processing, ready, published }

@freezed
abstract class Project with _$Project {
  const factory Project({
    required String id,
    @JsonKey(name: 'user_id') required String userId,
    @Default('Untitled project') String title,
    @Default('') String description,
    @Default(ProjectStatus.draft) ProjectStatus status,
    @JsonKey(name: 'original_video_url') String? originalVideoUrl,
    @JsonKey(name: 'processed_video_url') String? processedVideoUrl,
    @JsonKey(name: 'thumbnail_url') String? thumbnailUrl,
    @Default(0) int duration,
    @JsonKey(name: 'aspect_ratio') @Default('9:16') String aspectRatio,
    @Default('1080x1920') String resolution,
    @JsonKey(name: 'template_id') String? templateId,
    @JsonKey(name: 'brand_kit_id') String? brandKitId,
    @Default(<String>[]) List<String> tags,
    @JsonKey(name: 'created_at') required DateTime createdAt,
    @JsonKey(name: 'updated_at') required DateTime updatedAt,
    @JsonKey(name: 'published_at') DateTime? publishedAt,
  }) = _Project;

  factory Project.fromJson(Map<String, Object?> json) =>
      _$ProjectFromJson(json);
}
