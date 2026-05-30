// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'subtitle.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Subtitle _$SubtitleFromJson(Map<String, dynamic> json) => _Subtitle(
      id: json['id'] as String,
      projectId: json['project_id'] as String,
      language: json['language'] as String? ?? 'id',
      format: $enumDecodeNullable(_$SubtitleFormatEnumMap, json['format']) ??
          SubtitleFormat.ass,
      segments: (json['segments'] as List<dynamic>?)
              ?.map((e) => SubtitleSegment.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const <SubtitleSegment>[],
      style: json['style'] == null
          ? const SubtitleStyle()
          : SubtitleStyle.fromJson(json['style'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$SubtitleToJson(_Subtitle instance) => <String, dynamic>{
      'id': instance.id,
      'project_id': instance.projectId,
      'language': instance.language,
      'format': _$SubtitleFormatEnumMap[instance.format]!,
      'segments': instance.segments.map((e) => e.toJson()).toList(),
      'style': instance.style.toJson(),
    };

const _$SubtitleFormatEnumMap = {
  SubtitleFormat.ass: 'ass',
  SubtitleFormat.srt: 'srt',
  SubtitleFormat.vtt: 'vtt',
};

_SubtitleSegment _$SubtitleSegmentFromJson(Map<String, dynamic> json) =>
    _SubtitleSegment(
      startMs: (json['start_ms'] as num?)?.toInt() ?? 0,
      endMs: (json['end_ms'] as num?)?.toInt() ?? 0,
      text: json['text'] as String? ?? '',
      words: (json['words'] as List<dynamic>?)
              ?.map((e) => Word.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const <Word>[],
    );

Map<String, dynamic> _$SubtitleSegmentToJson(_SubtitleSegment instance) =>
    <String, dynamic>{
      'start_ms': instance.startMs,
      'end_ms': instance.endMs,
      'text': instance.text,
      'words': instance.words.map((e) => e.toJson()).toList(),
    };

_Word _$WordFromJson(Map<String, dynamic> json) => _Word(
      text: json['text'] as String? ?? '',
      startMs: (json['start_ms'] as num?)?.toInt() ?? 0,
      endMs: (json['end_ms'] as num?)?.toInt() ?? 0,
    );

Map<String, dynamic> _$WordToJson(_Word instance) => <String, dynamic>{
      'text': instance.text,
      'start_ms': instance.startMs,
      'end_ms': instance.endMs,
    };

_SubtitleStyle _$SubtitleStyleFromJson(Map<String, dynamic> json) =>
    _SubtitleStyle(
      fontFamily: json['font_family'] as String? ?? 'Inter',
      fontSize: (json['font_size'] as num?)?.toDouble() ?? 42,
      fontColor: json['font_color'] as String? ?? '#FFFFFF',
      strokeColor: json['stroke_color'] as String? ?? '#0B0C10',
      position: json['position'] as String? ?? 'bottom',
      animation: json['animation'] as String? ?? 'karaoke',
    );

Map<String, dynamic> _$SubtitleStyleToJson(_SubtitleStyle instance) =>
    <String, dynamic>{
      'font_family': instance.fontFamily,
      'font_size': instance.fontSize,
      'font_color': instance.fontColor,
      'stroke_color': instance.strokeColor,
      'position': instance.position,
      'animation': instance.animation,
    };
