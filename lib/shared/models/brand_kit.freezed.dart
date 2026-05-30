// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'brand_kit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$BrandKit {
  String get id;
  @JsonKey(name: 'user_id')
  String get userId;
  @JsonKey(name: 'logo_url')
  String? get logoUrl;
  @JsonKey(name: 'primary_color')
  String get primaryColor;
  @JsonKey(name: 'secondary_color')
  String get secondaryColor;
  @JsonKey(name: 'accent_color')
  String get accentColor;
  @JsonKey(name: 'primary_font')
  String get primaryFont;
  @JsonKey(name: 'secondary_font')
  String get secondaryFont;
  @JsonKey(name: 'watermark_url')
  String? get watermarkUrl;
  @JsonKey(name: 'watermark_position')
  String get watermarkPosition;
  @JsonKey(name: 'intro_video_url')
  String? get introVideoUrl;
  @JsonKey(name: 'outro_video_url')
  String? get outroVideoUrl;

  /// Create a copy of BrandKit
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $BrandKitCopyWith<BrandKit> get copyWith =>
      _$BrandKitCopyWithImpl<BrandKit>(this as BrandKit, _$identity);

  /// Serializes this BrandKit to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is BrandKit &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.logoUrl, logoUrl) || other.logoUrl == logoUrl) &&
            (identical(other.primaryColor, primaryColor) ||
                other.primaryColor == primaryColor) &&
            (identical(other.secondaryColor, secondaryColor) ||
                other.secondaryColor == secondaryColor) &&
            (identical(other.accentColor, accentColor) ||
                other.accentColor == accentColor) &&
            (identical(other.primaryFont, primaryFont) ||
                other.primaryFont == primaryFont) &&
            (identical(other.secondaryFont, secondaryFont) ||
                other.secondaryFont == secondaryFont) &&
            (identical(other.watermarkUrl, watermarkUrl) ||
                other.watermarkUrl == watermarkUrl) &&
            (identical(other.watermarkPosition, watermarkPosition) ||
                other.watermarkPosition == watermarkPosition) &&
            (identical(other.introVideoUrl, introVideoUrl) ||
                other.introVideoUrl == introVideoUrl) &&
            (identical(other.outroVideoUrl, outroVideoUrl) ||
                other.outroVideoUrl == outroVideoUrl));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      userId,
      logoUrl,
      primaryColor,
      secondaryColor,
      accentColor,
      primaryFont,
      secondaryFont,
      watermarkUrl,
      watermarkPosition,
      introVideoUrl,
      outroVideoUrl);

  @override
  String toString() {
    return 'BrandKit(id: $id, userId: $userId, logoUrl: $logoUrl, primaryColor: $primaryColor, secondaryColor: $secondaryColor, accentColor: $accentColor, primaryFont: $primaryFont, secondaryFont: $secondaryFont, watermarkUrl: $watermarkUrl, watermarkPosition: $watermarkPosition, introVideoUrl: $introVideoUrl, outroVideoUrl: $outroVideoUrl)';
  }
}

/// @nodoc
abstract mixin class $BrandKitCopyWith<$Res> {
  factory $BrandKitCopyWith(BrandKit value, $Res Function(BrandKit) _then) =
      _$BrandKitCopyWithImpl;
  @useResult
  $Res call(
      {String id,
      @JsonKey(name: 'user_id') String userId,
      @JsonKey(name: 'logo_url') String? logoUrl,
      @JsonKey(name: 'primary_color') String primaryColor,
      @JsonKey(name: 'secondary_color') String secondaryColor,
      @JsonKey(name: 'accent_color') String accentColor,
      @JsonKey(name: 'primary_font') String primaryFont,
      @JsonKey(name: 'secondary_font') String secondaryFont,
      @JsonKey(name: 'watermark_url') String? watermarkUrl,
      @JsonKey(name: 'watermark_position') String watermarkPosition,
      @JsonKey(name: 'intro_video_url') String? introVideoUrl,
      @JsonKey(name: 'outro_video_url') String? outroVideoUrl});
}

/// @nodoc
class _$BrandKitCopyWithImpl<$Res> implements $BrandKitCopyWith<$Res> {
  _$BrandKitCopyWithImpl(this._self, this._then);

  final BrandKit _self;
  final $Res Function(BrandKit) _then;

  /// Create a copy of BrandKit
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? userId = null,
    Object? logoUrl = freezed,
    Object? primaryColor = null,
    Object? secondaryColor = null,
    Object? accentColor = null,
    Object? primaryFont = null,
    Object? secondaryFont = null,
    Object? watermarkUrl = freezed,
    Object? watermarkPosition = null,
    Object? introVideoUrl = freezed,
    Object? outroVideoUrl = freezed,
  }) {
    return _then(_self.copyWith(
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      userId: null == userId
          ? _self.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
      logoUrl: freezed == logoUrl
          ? _self.logoUrl
          : logoUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      primaryColor: null == primaryColor
          ? _self.primaryColor
          : primaryColor // ignore: cast_nullable_to_non_nullable
              as String,
      secondaryColor: null == secondaryColor
          ? _self.secondaryColor
          : secondaryColor // ignore: cast_nullable_to_non_nullable
              as String,
      accentColor: null == accentColor
          ? _self.accentColor
          : accentColor // ignore: cast_nullable_to_non_nullable
              as String,
      primaryFont: null == primaryFont
          ? _self.primaryFont
          : primaryFont // ignore: cast_nullable_to_non_nullable
              as String,
      secondaryFont: null == secondaryFont
          ? _self.secondaryFont
          : secondaryFont // ignore: cast_nullable_to_non_nullable
              as String,
      watermarkUrl: freezed == watermarkUrl
          ? _self.watermarkUrl
          : watermarkUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      watermarkPosition: null == watermarkPosition
          ? _self.watermarkPosition
          : watermarkPosition // ignore: cast_nullable_to_non_nullable
              as String,
      introVideoUrl: freezed == introVideoUrl
          ? _self.introVideoUrl
          : introVideoUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      outroVideoUrl: freezed == outroVideoUrl
          ? _self.outroVideoUrl
          : outroVideoUrl // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// Adds pattern-matching-related methods to [BrandKit].
extension BrandKitPatterns on BrandKit {
  /// A variant of `map` that fallback to returning `orElse`.
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case final Subclass value:
  ///     return ...;
  ///   case _:
  ///     return orElse();
  /// }
  /// ```

  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>(
    TResult Function(_BrandKit value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _BrandKit() when $default != null:
        return $default(_that);
      case _:
        return orElse();
    }
  }

  /// A `switch`-like method, using callbacks.
  ///
  /// Callbacks receives the raw object, upcasted.
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case final Subclass value:
  ///     return ...;
  ///   case final Subclass2 value:
  ///     return ...;
  /// }
  /// ```

  @optionalTypeArgs
  TResult map<TResult extends Object?>(
    TResult Function(_BrandKit value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _BrandKit():
        return $default(_that);
      case _:
        throw StateError('Unexpected subclass');
    }
  }

  /// A variant of `map` that fallback to returning `null`.
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case final Subclass value:
  ///     return ...;
  ///   case _:
  ///     return null;
  /// }
  /// ```

  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>(
    TResult? Function(_BrandKit value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _BrandKit() when $default != null:
        return $default(_that);
      case _:
        return null;
    }
  }

  /// A variant of `when` that fallback to an `orElse` callback.
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case Subclass(:final field):
  ///     return ...;
  ///   case _:
  ///     return orElse();
  /// }
  /// ```

  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>(
    TResult Function(
            String id,
            @JsonKey(name: 'user_id') String userId,
            @JsonKey(name: 'logo_url') String? logoUrl,
            @JsonKey(name: 'primary_color') String primaryColor,
            @JsonKey(name: 'secondary_color') String secondaryColor,
            @JsonKey(name: 'accent_color') String accentColor,
            @JsonKey(name: 'primary_font') String primaryFont,
            @JsonKey(name: 'secondary_font') String secondaryFont,
            @JsonKey(name: 'watermark_url') String? watermarkUrl,
            @JsonKey(name: 'watermark_position') String watermarkPosition,
            @JsonKey(name: 'intro_video_url') String? introVideoUrl,
            @JsonKey(name: 'outro_video_url') String? outroVideoUrl)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _BrandKit() when $default != null:
        return $default(
            _that.id,
            _that.userId,
            _that.logoUrl,
            _that.primaryColor,
            _that.secondaryColor,
            _that.accentColor,
            _that.primaryFont,
            _that.secondaryFont,
            _that.watermarkUrl,
            _that.watermarkPosition,
            _that.introVideoUrl,
            _that.outroVideoUrl);
      case _:
        return orElse();
    }
  }

  /// A `switch`-like method, using callbacks.
  ///
  /// As opposed to `map`, this offers destructuring.
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case Subclass(:final field):
  ///     return ...;
  ///   case Subclass2(:final field2):
  ///     return ...;
  /// }
  /// ```

  @optionalTypeArgs
  TResult when<TResult extends Object?>(
    TResult Function(
            String id,
            @JsonKey(name: 'user_id') String userId,
            @JsonKey(name: 'logo_url') String? logoUrl,
            @JsonKey(name: 'primary_color') String primaryColor,
            @JsonKey(name: 'secondary_color') String secondaryColor,
            @JsonKey(name: 'accent_color') String accentColor,
            @JsonKey(name: 'primary_font') String primaryFont,
            @JsonKey(name: 'secondary_font') String secondaryFont,
            @JsonKey(name: 'watermark_url') String? watermarkUrl,
            @JsonKey(name: 'watermark_position') String watermarkPosition,
            @JsonKey(name: 'intro_video_url') String? introVideoUrl,
            @JsonKey(name: 'outro_video_url') String? outroVideoUrl)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _BrandKit():
        return $default(
            _that.id,
            _that.userId,
            _that.logoUrl,
            _that.primaryColor,
            _that.secondaryColor,
            _that.accentColor,
            _that.primaryFont,
            _that.secondaryFont,
            _that.watermarkUrl,
            _that.watermarkPosition,
            _that.introVideoUrl,
            _that.outroVideoUrl);
      case _:
        throw StateError('Unexpected subclass');
    }
  }

  /// A variant of `when` that fallback to returning `null`
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case Subclass(:final field):
  ///     return ...;
  ///   case _:
  ///     return null;
  /// }
  /// ```

  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>(
    TResult? Function(
            String id,
            @JsonKey(name: 'user_id') String userId,
            @JsonKey(name: 'logo_url') String? logoUrl,
            @JsonKey(name: 'primary_color') String primaryColor,
            @JsonKey(name: 'secondary_color') String secondaryColor,
            @JsonKey(name: 'accent_color') String accentColor,
            @JsonKey(name: 'primary_font') String primaryFont,
            @JsonKey(name: 'secondary_font') String secondaryFont,
            @JsonKey(name: 'watermark_url') String? watermarkUrl,
            @JsonKey(name: 'watermark_position') String watermarkPosition,
            @JsonKey(name: 'intro_video_url') String? introVideoUrl,
            @JsonKey(name: 'outro_video_url') String? outroVideoUrl)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _BrandKit() when $default != null:
        return $default(
            _that.id,
            _that.userId,
            _that.logoUrl,
            _that.primaryColor,
            _that.secondaryColor,
            _that.accentColor,
            _that.primaryFont,
            _that.secondaryFont,
            _that.watermarkUrl,
            _that.watermarkPosition,
            _that.introVideoUrl,
            _that.outroVideoUrl);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _BrandKit implements BrandKit {
  const _BrandKit(
      {required this.id,
      @JsonKey(name: 'user_id') required this.userId,
      @JsonKey(name: 'logo_url') this.logoUrl,
      @JsonKey(name: 'primary_color') this.primaryColor = '#D4AF37',
      @JsonKey(name: 'secondary_color') this.secondaryColor = '#0B0C10',
      @JsonKey(name: 'accent_color') this.accentColor = '#E6C757',
      @JsonKey(name: 'primary_font') this.primaryFont = 'Inter',
      @JsonKey(name: 'secondary_font') this.secondaryFont = 'JetBrains Mono',
      @JsonKey(name: 'watermark_url') this.watermarkUrl,
      @JsonKey(name: 'watermark_position')
      this.watermarkPosition = 'bottom_right',
      @JsonKey(name: 'intro_video_url') this.introVideoUrl,
      @JsonKey(name: 'outro_video_url') this.outroVideoUrl});
  factory _BrandKit.fromJson(Map<String, dynamic> json) =>
      _$BrandKitFromJson(json);

  @override
  final String id;
  @override
  @JsonKey(name: 'user_id')
  final String userId;
  @override
  @JsonKey(name: 'logo_url')
  final String? logoUrl;
  @override
  @JsonKey(name: 'primary_color')
  final String primaryColor;
  @override
  @JsonKey(name: 'secondary_color')
  final String secondaryColor;
  @override
  @JsonKey(name: 'accent_color')
  final String accentColor;
  @override
  @JsonKey(name: 'primary_font')
  final String primaryFont;
  @override
  @JsonKey(name: 'secondary_font')
  final String secondaryFont;
  @override
  @JsonKey(name: 'watermark_url')
  final String? watermarkUrl;
  @override
  @JsonKey(name: 'watermark_position')
  final String watermarkPosition;
  @override
  @JsonKey(name: 'intro_video_url')
  final String? introVideoUrl;
  @override
  @JsonKey(name: 'outro_video_url')
  final String? outroVideoUrl;

  /// Create a copy of BrandKit
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$BrandKitCopyWith<_BrandKit> get copyWith =>
      __$BrandKitCopyWithImpl<_BrandKit>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$BrandKitToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _BrandKit &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.logoUrl, logoUrl) || other.logoUrl == logoUrl) &&
            (identical(other.primaryColor, primaryColor) ||
                other.primaryColor == primaryColor) &&
            (identical(other.secondaryColor, secondaryColor) ||
                other.secondaryColor == secondaryColor) &&
            (identical(other.accentColor, accentColor) ||
                other.accentColor == accentColor) &&
            (identical(other.primaryFont, primaryFont) ||
                other.primaryFont == primaryFont) &&
            (identical(other.secondaryFont, secondaryFont) ||
                other.secondaryFont == secondaryFont) &&
            (identical(other.watermarkUrl, watermarkUrl) ||
                other.watermarkUrl == watermarkUrl) &&
            (identical(other.watermarkPosition, watermarkPosition) ||
                other.watermarkPosition == watermarkPosition) &&
            (identical(other.introVideoUrl, introVideoUrl) ||
                other.introVideoUrl == introVideoUrl) &&
            (identical(other.outroVideoUrl, outroVideoUrl) ||
                other.outroVideoUrl == outroVideoUrl));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      userId,
      logoUrl,
      primaryColor,
      secondaryColor,
      accentColor,
      primaryFont,
      secondaryFont,
      watermarkUrl,
      watermarkPosition,
      introVideoUrl,
      outroVideoUrl);

  @override
  String toString() {
    return 'BrandKit(id: $id, userId: $userId, logoUrl: $logoUrl, primaryColor: $primaryColor, secondaryColor: $secondaryColor, accentColor: $accentColor, primaryFont: $primaryFont, secondaryFont: $secondaryFont, watermarkUrl: $watermarkUrl, watermarkPosition: $watermarkPosition, introVideoUrl: $introVideoUrl, outroVideoUrl: $outroVideoUrl)';
  }
}

/// @nodoc
abstract mixin class _$BrandKitCopyWith<$Res>
    implements $BrandKitCopyWith<$Res> {
  factory _$BrandKitCopyWith(_BrandKit value, $Res Function(_BrandKit) _then) =
      __$BrandKitCopyWithImpl;
  @override
  @useResult
  $Res call(
      {String id,
      @JsonKey(name: 'user_id') String userId,
      @JsonKey(name: 'logo_url') String? logoUrl,
      @JsonKey(name: 'primary_color') String primaryColor,
      @JsonKey(name: 'secondary_color') String secondaryColor,
      @JsonKey(name: 'accent_color') String accentColor,
      @JsonKey(name: 'primary_font') String primaryFont,
      @JsonKey(name: 'secondary_font') String secondaryFont,
      @JsonKey(name: 'watermark_url') String? watermarkUrl,
      @JsonKey(name: 'watermark_position') String watermarkPosition,
      @JsonKey(name: 'intro_video_url') String? introVideoUrl,
      @JsonKey(name: 'outro_video_url') String? outroVideoUrl});
}

/// @nodoc
class __$BrandKitCopyWithImpl<$Res> implements _$BrandKitCopyWith<$Res> {
  __$BrandKitCopyWithImpl(this._self, this._then);

  final _BrandKit _self;
  final $Res Function(_BrandKit) _then;

  /// Create a copy of BrandKit
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? id = null,
    Object? userId = null,
    Object? logoUrl = freezed,
    Object? primaryColor = null,
    Object? secondaryColor = null,
    Object? accentColor = null,
    Object? primaryFont = null,
    Object? secondaryFont = null,
    Object? watermarkUrl = freezed,
    Object? watermarkPosition = null,
    Object? introVideoUrl = freezed,
    Object? outroVideoUrl = freezed,
  }) {
    return _then(_BrandKit(
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      userId: null == userId
          ? _self.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
      logoUrl: freezed == logoUrl
          ? _self.logoUrl
          : logoUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      primaryColor: null == primaryColor
          ? _self.primaryColor
          : primaryColor // ignore: cast_nullable_to_non_nullable
              as String,
      secondaryColor: null == secondaryColor
          ? _self.secondaryColor
          : secondaryColor // ignore: cast_nullable_to_non_nullable
              as String,
      accentColor: null == accentColor
          ? _self.accentColor
          : accentColor // ignore: cast_nullable_to_non_nullable
              as String,
      primaryFont: null == primaryFont
          ? _self.primaryFont
          : primaryFont // ignore: cast_nullable_to_non_nullable
              as String,
      secondaryFont: null == secondaryFont
          ? _self.secondaryFont
          : secondaryFont // ignore: cast_nullable_to_non_nullable
              as String,
      watermarkUrl: freezed == watermarkUrl
          ? _self.watermarkUrl
          : watermarkUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      watermarkPosition: null == watermarkPosition
          ? _self.watermarkPosition
          : watermarkPosition // ignore: cast_nullable_to_non_nullable
              as String,
      introVideoUrl: freezed == introVideoUrl
          ? _self.introVideoUrl
          : introVideoUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      outroVideoUrl: freezed == outroVideoUrl
          ? _self.outroVideoUrl
          : outroVideoUrl // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

// dart format on
