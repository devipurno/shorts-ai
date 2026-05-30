import 'package:freezed_annotation/freezed_annotation.dart';

part 'brand_kit.freezed.dart';
part 'brand_kit.g.dart';

@freezed
abstract class BrandKit with _$BrandKit {
  const factory BrandKit({
    required String id,
    @JsonKey(name: 'user_id') required String userId,
    @JsonKey(name: 'logo_url') String? logoUrl,
    @JsonKey(name: 'primary_color') @Default('#D4AF37') String primaryColor,
    @JsonKey(name: 'secondary_color') @Default('#0B0C10') String secondaryColor,
    @JsonKey(name: 'accent_color') @Default('#E6C757') String accentColor,
    @JsonKey(name: 'primary_font') @Default('Inter') String primaryFont,
    @JsonKey(name: 'secondary_font')
    @Default('JetBrains Mono')
    String secondaryFont,
    @JsonKey(name: 'watermark_url') String? watermarkUrl,
    @JsonKey(name: 'watermark_position')
    @Default('bottom_right')
    String watermarkPosition,
    @JsonKey(name: 'intro_video_url') String? introVideoUrl,
    @JsonKey(name: 'outro_video_url') String? outroVideoUrl,
  }) = _BrandKit;

  factory BrandKit.fromJson(Map<String, Object?> json) =>
      _$BrandKitFromJson(json);
}
