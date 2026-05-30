import 'package:freezed_annotation/freezed_annotation.dart';

part 'analytics_event.freezed.dart';
part 'analytics_event.g.dart';

@freezed
abstract class AnalyticsEvent with _$AnalyticsEvent {
  const factory AnalyticsEvent({
    required String id,
    @JsonKey(name: 'user_id') required String userId,
    @JsonKey(name: 'event_name') @Default('') String eventName,
    @Default(<String, dynamic>{}) Map<String, dynamic> properties,
    required DateTime timestamp,
  }) = _AnalyticsEvent;

  factory AnalyticsEvent.fromJson(Map<String, Object?> json) =>
      _$AnalyticsEventFromJson(json);
}
