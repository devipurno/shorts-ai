// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'brand_kit.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_BrandKit _$BrandKitFromJson(Map<String, dynamic> json) => _BrandKit(
      id: json['id'] as String,
      userId: json['user_id'] as String,
      logoUrl: json['logo_url'] as String?,
      primaryColor: json['primary_color'] as String? ?? '#D4AF37',
      secondaryColor: json['secondary_color'] as String? ?? '#0B0C10',
      accentColor: json['accent_color'] as String? ?? '#E6C757',
      primaryFont: json['primary_font'] as String? ?? 'Inter',
      secondaryFont: json['secondary_font'] as String? ?? 'JetBrains Mono',
      watermarkUrl: json['watermark_url'] as String?,
      watermarkPosition:
          json['watermark_position'] as String? ?? 'bottom_right',
      introVideoUrl: json['intro_video_url'] as String?,
      outroVideoUrl: json['outro_video_url'] as String?,
    );

Map<String, dynamic> _$BrandKitToJson(_BrandKit instance) => <String, dynamic>{
      'id': instance.id,
      'user_id': instance.userId,
      'logo_url': instance.logoUrl,
      'primary_color': instance.primaryColor,
      'secondary_color': instance.secondaryColor,
      'accent_color': instance.accentColor,
      'primary_font': instance.primaryFont,
      'secondary_font': instance.secondaryFont,
      'watermark_url': instance.watermarkUrl,
      'watermark_position': instance.watermarkPosition,
      'intro_video_url': instance.introVideoUrl,
      'outro_video_url': instance.outroVideoUrl,
    };
