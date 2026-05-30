// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'analytics_event.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_AnalyticsEvent _$AnalyticsEventFromJson(Map<String, dynamic> json) =>
    _AnalyticsEvent(
      id: json['id'] as String,
      userId: json['user_id'] as String,
      eventName: json['event_name'] as String? ?? '',
      properties: json['properties'] as Map<String, dynamic>? ??
          const <String, dynamic>{},
      timestamp: DateTime.parse(json['timestamp'] as String),
    );

Map<String, dynamic> _$AnalyticsEventToJson(_AnalyticsEvent instance) =>
    <String, dynamic>{
      'id': instance.id,
      'user_id': instance.userId,
      'event_name': instance.eventName,
      'properties': instance.properties,
      'timestamp': instance.timestamp.toIso8601String(),
    };
