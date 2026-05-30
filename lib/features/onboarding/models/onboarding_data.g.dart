// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'onboarding_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_OnboardingData _$OnboardingDataFromJson(Map<String, dynamic> json) =>
    _OnboardingData(
      niche: json['niche'] as String?,
      goals:
          (json['goals'] as List<dynamic>?)?.map((e) => e as String).toList() ??
              const <String>[],
      language: json['language'] as String?,
      selectedTier: json['selectedTier'] as String?,
      completedAt: json['completed_at'] == null
          ? null
          : DateTime.parse(json['completed_at'] as String),
    );

Map<String, dynamic> _$OnboardingDataToJson(_OnboardingData instance) =>
    <String, dynamic>{
      'niche': instance.niche,
      'goals': instance.goals,
      'language': instance.language,
      'selectedTier': instance.selectedTier,
      'completed_at': instance.completedAt?.toIso8601String(),
    };
