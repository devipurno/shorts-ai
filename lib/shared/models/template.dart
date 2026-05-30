import 'package:freezed_annotation/freezed_annotation.dart';

part 'template.freezed.dart';
part 'template.g.dart';

@JsonEnum(fieldRename: FieldRename.snake)
enum TemplateDifficulty { easy, medium, advanced }

@JsonEnum(fieldRename: FieldRename.snake)
enum TemplateTier { free, premium }

@freezed
abstract class Template with _$Template {
  @JsonSerializable(explicitToJson: true)
  const factory Template({
    required String id,
    @Default('') String name,
    @Default('') String description,
    @Default('general') String category,
    @JsonKey(name: 'thumbnail_url') String? thumbnailUrl,
    @JsonKey(name: 'preview_video_url') String? previewVideoUrl,
    @Default(TemplateStructure()) TemplateStructure structure,
    @Default(TemplateDifficulty.easy) TemplateDifficulty difficulty,
    @Default(TemplateTier.free) TemplateTier tier,
    @JsonKey(name: 'times_used') @Default(0) int timesUsed,
    @Default(0) double rating,
  }) = _Template;

  factory Template.fromJson(Map<String, Object?> json) =>
      _$TemplateFromJson(json);
}

@freezed
abstract class TemplateStructure with _$TemplateStructure {
  @JsonSerializable(explicitToJson: true)
  const factory TemplateStructure({
    @Default(0) int duration,
    @Default(<String>[]) List<String> hooks,
    @Default(<String>[]) List<String> segments,
    @Default(<String>[]) List<String> transitions,
    @Default(<String>[]) List<String> music,
  }) = _TemplateStructure;

  factory TemplateStructure.fromJson(Map<String, Object?> json) =>
      _$TemplateStructureFromJson(json);
}
