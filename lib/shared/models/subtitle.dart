import 'package:freezed_annotation/freezed_annotation.dart';

part 'subtitle.freezed.dart';
part 'subtitle.g.dart';

@JsonEnum(fieldRename: FieldRename.snake)
enum SubtitleFormat { ass, srt, vtt }

@freezed
abstract class Subtitle with _$Subtitle {
  @JsonSerializable(explicitToJson: true)
  const factory Subtitle({
    required String id,
    @JsonKey(name: 'project_id') required String projectId,
    @Default('id') String language,
    @Default(SubtitleFormat.ass) SubtitleFormat format,
    @Default(<SubtitleSegment>[]) List<SubtitleSegment> segments,
    @Default(SubtitleStyle()) SubtitleStyle style,
  }) = _Subtitle;

  factory Subtitle.fromJson(Map<String, Object?> json) =>
      _$SubtitleFromJson(json);
}

@freezed
abstract class SubtitleSegment with _$SubtitleSegment {
  @JsonSerializable(explicitToJson: true)
  const factory SubtitleSegment({
    @JsonKey(name: 'start_ms') @Default(0) int startMs,
    @JsonKey(name: 'end_ms') @Default(0) int endMs,
    @Default('') String text,
    @Default(<Word>[]) List<Word> words,
  }) = _SubtitleSegment;

  factory SubtitleSegment.fromJson(Map<String, Object?> json) =>
      _$SubtitleSegmentFromJson(json);
}

@freezed
abstract class Word with _$Word {
  @JsonSerializable(explicitToJson: true)
  const factory Word({
    @Default('') String text,
    @JsonKey(name: 'start_ms') @Default(0) int startMs,
    @JsonKey(name: 'end_ms') @Default(0) int endMs,
  }) = _Word;

  factory Word.fromJson(Map<String, Object?> json) => _$WordFromJson(json);
}

@freezed
abstract class SubtitleStyle with _$SubtitleStyle {
  @JsonSerializable(explicitToJson: true)
  const factory SubtitleStyle({
    @JsonKey(name: 'font_family') @Default('Inter') String fontFamily,
    @JsonKey(name: 'font_size') @Default(42) double fontSize,
    @JsonKey(name: 'font_color') @Default('#FFFFFF') String fontColor,
    @JsonKey(name: 'stroke_color') @Default('#0B0C10') String strokeColor,
    @Default('bottom') String position,
    @Default('karaoke') String animation,
  }) = _SubtitleStyle;

  factory SubtitleStyle.fromJson(Map<String, Object?> json) =>
      _$SubtitleStyleFromJson(json);
}
