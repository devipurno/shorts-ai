// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'brand_kit_provider.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$BrandKitState {
  String? get id;
  String get userId;
  String? get logoUrl;
  Color get primaryColor;
  Color get secondaryColor;
  Color get accentColor;
  String get primaryFont;
  String get secondaryFont;
  String? get watermarkUrl;
  WatermarkPosition get watermarkPosition;
  double get watermarkOpacity;
  double get watermarkSize;
  String? get introVideoUrl;
  String? get outroVideoUrl;
  bool get isDirty;
  bool get isSaving;
  bool get isLoaded;
  int get brandKitCount;
  String? get selectedPaletteName;
  String? get errorMessage;

  /// Create a copy of BrandKitState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $BrandKitStateCopyWith<BrandKitState> get copyWith =>
      _$BrandKitStateCopyWithImpl<BrandKitState>(
          this as BrandKitState, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is BrandKitState &&
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
            (identical(other.watermarkOpacity, watermarkOpacity) ||
                other.watermarkOpacity == watermarkOpacity) &&
            (identical(other.watermarkSize, watermarkSize) ||
                other.watermarkSize == watermarkSize) &&
            (identical(other.introVideoUrl, introVideoUrl) ||
                other.introVideoUrl == introVideoUrl) &&
            (identical(other.outroVideoUrl, outroVideoUrl) ||
                other.outroVideoUrl == outroVideoUrl) &&
            (identical(other.isDirty, isDirty) || other.isDirty == isDirty) &&
            (identical(other.isSaving, isSaving) ||
                other.isSaving == isSaving) &&
            (identical(other.isLoaded, isLoaded) ||
                other.isLoaded == isLoaded) &&
            (identical(other.brandKitCount, brandKitCount) ||
                other.brandKitCount == brandKitCount) &&
            (identical(other.selectedPaletteName, selectedPaletteName) ||
                other.selectedPaletteName == selectedPaletteName) &&
            (identical(other.errorMessage, errorMessage) ||
                other.errorMessage == errorMessage));
  }

  @override
  int get hashCode => Object.hashAll([
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
        watermarkOpacity,
        watermarkSize,
        introVideoUrl,
        outroVideoUrl,
        isDirty,
        isSaving,
        isLoaded,
        brandKitCount,
        selectedPaletteName,
        errorMessage
      ]);

  @override
  String toString() {
    return 'BrandKitState(id: $id, userId: $userId, logoUrl: $logoUrl, primaryColor: $primaryColor, secondaryColor: $secondaryColor, accentColor: $accentColor, primaryFont: $primaryFont, secondaryFont: $secondaryFont, watermarkUrl: $watermarkUrl, watermarkPosition: $watermarkPosition, watermarkOpacity: $watermarkOpacity, watermarkSize: $watermarkSize, introVideoUrl: $introVideoUrl, outroVideoUrl: $outroVideoUrl, isDirty: $isDirty, isSaving: $isSaving, isLoaded: $isLoaded, brandKitCount: $brandKitCount, selectedPaletteName: $selectedPaletteName, errorMessage: $errorMessage)';
  }
}

/// @nodoc
abstract mixin class $BrandKitStateCopyWith<$Res> {
  factory $BrandKitStateCopyWith(
          BrandKitState value, $Res Function(BrandKitState) _then) =
      _$BrandKitStateCopyWithImpl;
  @useResult
  $Res call(
      {String? id,
      String userId,
      String? logoUrl,
      Color primaryColor,
      Color secondaryColor,
      Color accentColor,
      String primaryFont,
      String secondaryFont,
      String? watermarkUrl,
      WatermarkPosition watermarkPosition,
      double watermarkOpacity,
      double watermarkSize,
      String? introVideoUrl,
      String? outroVideoUrl,
      bool isDirty,
      bool isSaving,
      bool isLoaded,
      int brandKitCount,
      String? selectedPaletteName,
      String? errorMessage});
}

/// @nodoc
class _$BrandKitStateCopyWithImpl<$Res>
    implements $BrandKitStateCopyWith<$Res> {
  _$BrandKitStateCopyWithImpl(this._self, this._then);

  final BrandKitState _self;
  final $Res Function(BrandKitState) _then;

  /// Create a copy of BrandKitState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? userId = null,
    Object? logoUrl = freezed,
    Object? primaryColor = null,
    Object? secondaryColor = null,
    Object? accentColor = null,
    Object? primaryFont = null,
    Object? secondaryFont = null,
    Object? watermarkUrl = freezed,
    Object? watermarkPosition = null,
    Object? watermarkOpacity = null,
    Object? watermarkSize = null,
    Object? introVideoUrl = freezed,
    Object? outroVideoUrl = freezed,
    Object? isDirty = null,
    Object? isSaving = null,
    Object? isLoaded = null,
    Object? brandKitCount = null,
    Object? selectedPaletteName = freezed,
    Object? errorMessage = freezed,
  }) {
    return _then(_self.copyWith(
      id: freezed == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
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
              as Color,
      secondaryColor: null == secondaryColor
          ? _self.secondaryColor
          : secondaryColor // ignore: cast_nullable_to_non_nullable
              as Color,
      accentColor: null == accentColor
          ? _self.accentColor
          : accentColor // ignore: cast_nullable_to_non_nullable
              as Color,
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
              as WatermarkPosition,
      watermarkOpacity: null == watermarkOpacity
          ? _self.watermarkOpacity
          : watermarkOpacity // ignore: cast_nullable_to_non_nullable
              as double,
      watermarkSize: null == watermarkSize
          ? _self.watermarkSize
          : watermarkSize // ignore: cast_nullable_to_non_nullable
              as double,
      introVideoUrl: freezed == introVideoUrl
          ? _self.introVideoUrl
          : introVideoUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      outroVideoUrl: freezed == outroVideoUrl
          ? _self.outroVideoUrl
          : outroVideoUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      isDirty: null == isDirty
          ? _self.isDirty
          : isDirty // ignore: cast_nullable_to_non_nullable
              as bool,
      isSaving: null == isSaving
          ? _self.isSaving
          : isSaving // ignore: cast_nullable_to_non_nullable
              as bool,
      isLoaded: null == isLoaded
          ? _self.isLoaded
          : isLoaded // ignore: cast_nullable_to_non_nullable
              as bool,
      brandKitCount: null == brandKitCount
          ? _self.brandKitCount
          : brandKitCount // ignore: cast_nullable_to_non_nullable
              as int,
      selectedPaletteName: freezed == selectedPaletteName
          ? _self.selectedPaletteName
          : selectedPaletteName // ignore: cast_nullable_to_non_nullable
              as String?,
      errorMessage: freezed == errorMessage
          ? _self.errorMessage
          : errorMessage // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// Adds pattern-matching-related methods to [BrandKitState].
extension BrandKitStatePatterns on BrandKitState {
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
    TResult Function(_BrandKitState value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _BrandKitState() when $default != null:
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
    TResult Function(_BrandKitState value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _BrandKitState():
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
    TResult? Function(_BrandKitState value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _BrandKitState() when $default != null:
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
            String? id,
            String userId,
            String? logoUrl,
            Color primaryColor,
            Color secondaryColor,
            Color accentColor,
            String primaryFont,
            String secondaryFont,
            String? watermarkUrl,
            WatermarkPosition watermarkPosition,
            double watermarkOpacity,
            double watermarkSize,
            String? introVideoUrl,
            String? outroVideoUrl,
            bool isDirty,
            bool isSaving,
            bool isLoaded,
            int brandKitCount,
            String? selectedPaletteName,
            String? errorMessage)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _BrandKitState() when $default != null:
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
            _that.watermarkOpacity,
            _that.watermarkSize,
            _that.introVideoUrl,
            _that.outroVideoUrl,
            _that.isDirty,
            _that.isSaving,
            _that.isLoaded,
            _that.brandKitCount,
            _that.selectedPaletteName,
            _that.errorMessage);
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
            String? id,
            String userId,
            String? logoUrl,
            Color primaryColor,
            Color secondaryColor,
            Color accentColor,
            String primaryFont,
            String secondaryFont,
            String? watermarkUrl,
            WatermarkPosition watermarkPosition,
            double watermarkOpacity,
            double watermarkSize,
            String? introVideoUrl,
            String? outroVideoUrl,
            bool isDirty,
            bool isSaving,
            bool isLoaded,
            int brandKitCount,
            String? selectedPaletteName,
            String? errorMessage)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _BrandKitState():
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
            _that.watermarkOpacity,
            _that.watermarkSize,
            _that.introVideoUrl,
            _that.outroVideoUrl,
            _that.isDirty,
            _that.isSaving,
            _that.isLoaded,
            _that.brandKitCount,
            _that.selectedPaletteName,
            _that.errorMessage);
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
            String? id,
            String userId,
            String? logoUrl,
            Color primaryColor,
            Color secondaryColor,
            Color accentColor,
            String primaryFont,
            String secondaryFont,
            String? watermarkUrl,
            WatermarkPosition watermarkPosition,
            double watermarkOpacity,
            double watermarkSize,
            String? introVideoUrl,
            String? outroVideoUrl,
            bool isDirty,
            bool isSaving,
            bool isLoaded,
            int brandKitCount,
            String? selectedPaletteName,
            String? errorMessage)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _BrandKitState() when $default != null:
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
            _that.watermarkOpacity,
            _that.watermarkSize,
            _that.introVideoUrl,
            _that.outroVideoUrl,
            _that.isDirty,
            _that.isSaving,
            _that.isLoaded,
            _that.brandKitCount,
            _that.selectedPaletteName,
            _that.errorMessage);
      case _:
        return null;
    }
  }
}

/// @nodoc

class _BrandKitState implements BrandKitState {
  const _BrandKitState(
      {this.id,
      this.userId = _fallbackUserId,
      this.logoUrl,
      this.primaryColor = AppColors.gold,
      this.secondaryColor = AppColors.obsidian,
      this.accentColor = AppColors.goldLight,
      this.primaryFont = 'Inter',
      this.secondaryFont = 'JetBrains Mono',
      this.watermarkUrl,
      this.watermarkPosition = WatermarkPosition.bottomRight,
      this.watermarkOpacity = 0.72,
      this.watermarkSize = 0.18,
      this.introVideoUrl,
      this.outroVideoUrl,
      this.isDirty = false,
      this.isSaving = false,
      this.isLoaded = false,
      this.brandKitCount = 1,
      this.selectedPaletteName,
      this.errorMessage});

  @override
  final String? id;
  @override
  @JsonKey()
  final String userId;
  @override
  final String? logoUrl;
  @override
  @JsonKey()
  final Color primaryColor;
  @override
  @JsonKey()
  final Color secondaryColor;
  @override
  @JsonKey()
  final Color accentColor;
  @override
  @JsonKey()
  final String primaryFont;
  @override
  @JsonKey()
  final String secondaryFont;
  @override
  final String? watermarkUrl;
  @override
  @JsonKey()
  final WatermarkPosition watermarkPosition;
  @override
  @JsonKey()
  final double watermarkOpacity;
  @override
  @JsonKey()
  final double watermarkSize;
  @override
  final String? introVideoUrl;
  @override
  final String? outroVideoUrl;
  @override
  @JsonKey()
  final bool isDirty;
  @override
  @JsonKey()
  final bool isSaving;
  @override
  @JsonKey()
  final bool isLoaded;
  @override
  @JsonKey()
  final int brandKitCount;
  @override
  final String? selectedPaletteName;
  @override
  final String? errorMessage;

  /// Create a copy of BrandKitState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$BrandKitStateCopyWith<_BrandKitState> get copyWith =>
      __$BrandKitStateCopyWithImpl<_BrandKitState>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _BrandKitState &&
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
            (identical(other.watermarkOpacity, watermarkOpacity) ||
                other.watermarkOpacity == watermarkOpacity) &&
            (identical(other.watermarkSize, watermarkSize) ||
                other.watermarkSize == watermarkSize) &&
            (identical(other.introVideoUrl, introVideoUrl) ||
                other.introVideoUrl == introVideoUrl) &&
            (identical(other.outroVideoUrl, outroVideoUrl) ||
                other.outroVideoUrl == outroVideoUrl) &&
            (identical(other.isDirty, isDirty) || other.isDirty == isDirty) &&
            (identical(other.isSaving, isSaving) ||
                other.isSaving == isSaving) &&
            (identical(other.isLoaded, isLoaded) ||
                other.isLoaded == isLoaded) &&
            (identical(other.brandKitCount, brandKitCount) ||
                other.brandKitCount == brandKitCount) &&
            (identical(other.selectedPaletteName, selectedPaletteName) ||
                other.selectedPaletteName == selectedPaletteName) &&
            (identical(other.errorMessage, errorMessage) ||
                other.errorMessage == errorMessage));
  }

  @override
  int get hashCode => Object.hashAll([
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
        watermarkOpacity,
        watermarkSize,
        introVideoUrl,
        outroVideoUrl,
        isDirty,
        isSaving,
        isLoaded,
        brandKitCount,
        selectedPaletteName,
        errorMessage
      ]);

  @override
  String toString() {
    return 'BrandKitState(id: $id, userId: $userId, logoUrl: $logoUrl, primaryColor: $primaryColor, secondaryColor: $secondaryColor, accentColor: $accentColor, primaryFont: $primaryFont, secondaryFont: $secondaryFont, watermarkUrl: $watermarkUrl, watermarkPosition: $watermarkPosition, watermarkOpacity: $watermarkOpacity, watermarkSize: $watermarkSize, introVideoUrl: $introVideoUrl, outroVideoUrl: $outroVideoUrl, isDirty: $isDirty, isSaving: $isSaving, isLoaded: $isLoaded, brandKitCount: $brandKitCount, selectedPaletteName: $selectedPaletteName, errorMessage: $errorMessage)';
  }
}

/// @nodoc
abstract mixin class _$BrandKitStateCopyWith<$Res>
    implements $BrandKitStateCopyWith<$Res> {
  factory _$BrandKitStateCopyWith(
          _BrandKitState value, $Res Function(_BrandKitState) _then) =
      __$BrandKitStateCopyWithImpl;
  @override
  @useResult
  $Res call(
      {String? id,
      String userId,
      String? logoUrl,
      Color primaryColor,
      Color secondaryColor,
      Color accentColor,
      String primaryFont,
      String secondaryFont,
      String? watermarkUrl,
      WatermarkPosition watermarkPosition,
      double watermarkOpacity,
      double watermarkSize,
      String? introVideoUrl,
      String? outroVideoUrl,
      bool isDirty,
      bool isSaving,
      bool isLoaded,
      int brandKitCount,
      String? selectedPaletteName,
      String? errorMessage});
}

/// @nodoc
class __$BrandKitStateCopyWithImpl<$Res>
    implements _$BrandKitStateCopyWith<$Res> {
  __$BrandKitStateCopyWithImpl(this._self, this._then);

  final _BrandKitState _self;
  final $Res Function(_BrandKitState) _then;

  /// Create a copy of BrandKitState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? id = freezed,
    Object? userId = null,
    Object? logoUrl = freezed,
    Object? primaryColor = null,
    Object? secondaryColor = null,
    Object? accentColor = null,
    Object? primaryFont = null,
    Object? secondaryFont = null,
    Object? watermarkUrl = freezed,
    Object? watermarkPosition = null,
    Object? watermarkOpacity = null,
    Object? watermarkSize = null,
    Object? introVideoUrl = freezed,
    Object? outroVideoUrl = freezed,
    Object? isDirty = null,
    Object? isSaving = null,
    Object? isLoaded = null,
    Object? brandKitCount = null,
    Object? selectedPaletteName = freezed,
    Object? errorMessage = freezed,
  }) {
    return _then(_BrandKitState(
      id: freezed == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
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
              as Color,
      secondaryColor: null == secondaryColor
          ? _self.secondaryColor
          : secondaryColor // ignore: cast_nullable_to_non_nullable
              as Color,
      accentColor: null == accentColor
          ? _self.accentColor
          : accentColor // ignore: cast_nullable_to_non_nullable
              as Color,
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
              as WatermarkPosition,
      watermarkOpacity: null == watermarkOpacity
          ? _self.watermarkOpacity
          : watermarkOpacity // ignore: cast_nullable_to_non_nullable
              as double,
      watermarkSize: null == watermarkSize
          ? _self.watermarkSize
          : watermarkSize // ignore: cast_nullable_to_non_nullable
              as double,
      introVideoUrl: freezed == introVideoUrl
          ? _self.introVideoUrl
          : introVideoUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      outroVideoUrl: freezed == outroVideoUrl
          ? _self.outroVideoUrl
          : outroVideoUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      isDirty: null == isDirty
          ? _self.isDirty
          : isDirty // ignore: cast_nullable_to_non_nullable
              as bool,
      isSaving: null == isSaving
          ? _self.isSaving
          : isSaving // ignore: cast_nullable_to_non_nullable
              as bool,
      isLoaded: null == isLoaded
          ? _self.isLoaded
          : isLoaded // ignore: cast_nullable_to_non_nullable
              as bool,
      brandKitCount: null == brandKitCount
          ? _self.brandKitCount
          : brandKitCount // ignore: cast_nullable_to_non_nullable
              as int,
      selectedPaletteName: freezed == selectedPaletteName
          ? _self.selectedPaletteName
          : selectedPaletteName // ignore: cast_nullable_to_non_nullable
              as String?,
      errorMessage: freezed == errorMessage
          ? _self.errorMessage
          : errorMessage // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

// dart format on
