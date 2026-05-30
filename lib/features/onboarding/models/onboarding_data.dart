import 'package:freezed_annotation/freezed_annotation.dart';

part 'onboarding_data.freezed.dart';
part 'onboarding_data.g.dart';

@freezed
abstract class OnboardingData with _$OnboardingData {
  const factory OnboardingData({
    String? niche,
    @Default(<String>[]) List<String> goals,
    String? language,
    String? selectedTier,
    @JsonKey(name: 'completed_at') DateTime? completedAt,
  }) = _OnboardingData;

  factory OnboardingData.fromJson(Map<String, Object?> json) =>
      _$OnboardingDataFromJson(json);
}
