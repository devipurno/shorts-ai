import 'package:freezed_annotation/freezed_annotation.dart';

part 'script.freezed.dart';
part 'script.g.dart';

@JsonEnum(fieldRename: FieldRename.snake)
enum HookStyle { question, statement, shock, story, curiosity }

@freezed
abstract class Script with _$Script {
  @JsonSerializable(explicitToJson: true)
  const factory Script({
    required String id,
    @JsonKey(name: 'project_id') required String projectId,
    @Default('') String content,
    @JsonKey(name: 'hook_options')
    @Default(<HookOption>[])
    List<HookOption> hookOptions,
    @JsonKey(name: 'selected_hook_id') String? selectedHookId,
    @Default('id') String language,
    @JsonKey(name: 'duration_estimate') @Default(0) int durationEstimate,
    @JsonKey(name: 'ai_model_used') @Default('') String aiModelUsed,
    @JsonKey(name: 'generated_at') required DateTime generatedAt,
  }) = _Script;

  factory Script.fromJson(Map<String, Object?> json) => _$ScriptFromJson(json);
}

@freezed
abstract class HookOption with _$HookOption {
  @JsonSerializable(explicitToJson: true)
  const factory HookOption({
    required String id,
    @Default('') String text,
    @Default(HookStyle.statement) HookStyle style,
    @Default(0) double score,
  }) = _HookOption;

  factory HookOption.fromJson(Map<String, Object?> json) =>
      _$HookOptionFromJson(json);
}
