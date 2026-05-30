// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'thumbnail_provider.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$ThumbnailState {
  String get projectId;
  Thumbnail get variantA;
  Thumbnail? get variantB;
  ThumbnailVariant get selectedVariant;
  ThumbnailCanvasData get variantACanvas;
  ThumbnailCanvasData get variantBCanvas;
  double? get ctrPredictionA;
  double? get ctrPredictionB;
  List<String> get ctrTips;
  List<AiThumbnailResult> get aiResults;
  bool get isGeneratingAi;
  bool get isPredictingCtr;
  bool get isSaved;

  /// Create a copy of ThumbnailState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $ThumbnailStateCopyWith<ThumbnailState> get copyWith =>
      _$ThumbnailStateCopyWithImpl<ThumbnailState>(
          this as ThumbnailState, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is ThumbnailState &&
            (identical(other.projectId, projectId) ||
                other.projectId == projectId) &&
            (identical(other.variantA, variantA) ||
                other.variantA == variantA) &&
            (identical(other.variantB, variantB) ||
                other.variantB == variantB) &&
            (identical(other.selectedVariant, selectedVariant) ||
                other.selectedVariant == selectedVariant) &&
            (identical(other.variantACanvas, variantACanvas) ||
                other.variantACanvas == variantACanvas) &&
            (identical(other.variantBCanvas, variantBCanvas) ||
                other.variantBCanvas == variantBCanvas) &&
            (identical(other.ctrPredictionA, ctrPredictionA) ||
                other.ctrPredictionA == ctrPredictionA) &&
            (identical(other.ctrPredictionB, ctrPredictionB) ||
                other.ctrPredictionB == ctrPredictionB) &&
            const DeepCollectionEquality().equals(other.ctrTips, ctrTips) &&
            const DeepCollectionEquality().equals(other.aiResults, aiResults) &&
            (identical(other.isGeneratingAi, isGeneratingAi) ||
                other.isGeneratingAi == isGeneratingAi) &&
            (identical(other.isPredictingCtr, isPredictingCtr) ||
                other.isPredictingCtr == isPredictingCtr) &&
            (identical(other.isSaved, isSaved) || other.isSaved == isSaved));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      projectId,
      variantA,
      variantB,
      selectedVariant,
      variantACanvas,
      variantBCanvas,
      ctrPredictionA,
      ctrPredictionB,
      const DeepCollectionEquality().hash(ctrTips),
      const DeepCollectionEquality().hash(aiResults),
      isGeneratingAi,
      isPredictingCtr,
      isSaved);

  @override
  String toString() {
    return 'ThumbnailState(projectId: $projectId, variantA: $variantA, variantB: $variantB, selectedVariant: $selectedVariant, variantACanvas: $variantACanvas, variantBCanvas: $variantBCanvas, ctrPredictionA: $ctrPredictionA, ctrPredictionB: $ctrPredictionB, ctrTips: $ctrTips, aiResults: $aiResults, isGeneratingAi: $isGeneratingAi, isPredictingCtr: $isPredictingCtr, isSaved: $isSaved)';
  }
}

/// @nodoc
abstract mixin class $ThumbnailStateCopyWith<$Res> {
  factory $ThumbnailStateCopyWith(
          ThumbnailState value, $Res Function(ThumbnailState) _then) =
      _$ThumbnailStateCopyWithImpl;
  @useResult
  $Res call(
      {String projectId,
      Thumbnail variantA,
      Thumbnail? variantB,
      ThumbnailVariant selectedVariant,
      ThumbnailCanvasData variantACanvas,
      ThumbnailCanvasData variantBCanvas,
      double? ctrPredictionA,
      double? ctrPredictionB,
      List<String> ctrTips,
      List<AiThumbnailResult> aiResults,
      bool isGeneratingAi,
      bool isPredictingCtr,
      bool isSaved});

  $ThumbnailCopyWith<$Res> get variantA;
  $ThumbnailCopyWith<$Res>? get variantB;
  $ThumbnailCanvasDataCopyWith<$Res> get variantACanvas;
  $ThumbnailCanvasDataCopyWith<$Res> get variantBCanvas;
}

/// @nodoc
class _$ThumbnailStateCopyWithImpl<$Res>
    implements $ThumbnailStateCopyWith<$Res> {
  _$ThumbnailStateCopyWithImpl(this._self, this._then);

  final ThumbnailState _self;
  final $Res Function(ThumbnailState) _then;

  /// Create a copy of ThumbnailState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? projectId = null,
    Object? variantA = null,
    Object? variantB = freezed,
    Object? selectedVariant = null,
    Object? variantACanvas = null,
    Object? variantBCanvas = null,
    Object? ctrPredictionA = freezed,
    Object? ctrPredictionB = freezed,
    Object? ctrTips = null,
    Object? aiResults = null,
    Object? isGeneratingAi = null,
    Object? isPredictingCtr = null,
    Object? isSaved = null,
  }) {
    return _then(_self.copyWith(
      projectId: null == projectId
          ? _self.projectId
          : projectId // ignore: cast_nullable_to_non_nullable
              as String,
      variantA: null == variantA
          ? _self.variantA
          : variantA // ignore: cast_nullable_to_non_nullable
              as Thumbnail,
      variantB: freezed == variantB
          ? _self.variantB
          : variantB // ignore: cast_nullable_to_non_nullable
              as Thumbnail?,
      selectedVariant: null == selectedVariant
          ? _self.selectedVariant
          : selectedVariant // ignore: cast_nullable_to_non_nullable
              as ThumbnailVariant,
      variantACanvas: null == variantACanvas
          ? _self.variantACanvas
          : variantACanvas // ignore: cast_nullable_to_non_nullable
              as ThumbnailCanvasData,
      variantBCanvas: null == variantBCanvas
          ? _self.variantBCanvas
          : variantBCanvas // ignore: cast_nullable_to_non_nullable
              as ThumbnailCanvasData,
      ctrPredictionA: freezed == ctrPredictionA
          ? _self.ctrPredictionA
          : ctrPredictionA // ignore: cast_nullable_to_non_nullable
              as double?,
      ctrPredictionB: freezed == ctrPredictionB
          ? _self.ctrPredictionB
          : ctrPredictionB // ignore: cast_nullable_to_non_nullable
              as double?,
      ctrTips: null == ctrTips
          ? _self.ctrTips
          : ctrTips // ignore: cast_nullable_to_non_nullable
              as List<String>,
      aiResults: null == aiResults
          ? _self.aiResults
          : aiResults // ignore: cast_nullable_to_non_nullable
              as List<AiThumbnailResult>,
      isGeneratingAi: null == isGeneratingAi
          ? _self.isGeneratingAi
          : isGeneratingAi // ignore: cast_nullable_to_non_nullable
              as bool,
      isPredictingCtr: null == isPredictingCtr
          ? _self.isPredictingCtr
          : isPredictingCtr // ignore: cast_nullable_to_non_nullable
              as bool,
      isSaved: null == isSaved
          ? _self.isSaved
          : isSaved // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }

  /// Create a copy of ThumbnailState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $ThumbnailCopyWith<$Res> get variantA {
    return $ThumbnailCopyWith<$Res>(_self.variantA, (value) {
      return _then(_self.copyWith(variantA: value));
    });
  }

  /// Create a copy of ThumbnailState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $ThumbnailCopyWith<$Res>? get variantB {
    if (_self.variantB == null) {
      return null;
    }

    return $ThumbnailCopyWith<$Res>(_self.variantB!, (value) {
      return _then(_self.copyWith(variantB: value));
    });
  }

  /// Create a copy of ThumbnailState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $ThumbnailCanvasDataCopyWith<$Res> get variantACanvas {
    return $ThumbnailCanvasDataCopyWith<$Res>(_self.variantACanvas, (value) {
      return _then(_self.copyWith(variantACanvas: value));
    });
  }

  /// Create a copy of ThumbnailState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $ThumbnailCanvasDataCopyWith<$Res> get variantBCanvas {
    return $ThumbnailCanvasDataCopyWith<$Res>(_self.variantBCanvas, (value) {
      return _then(_self.copyWith(variantBCanvas: value));
    });
  }
}

/// Adds pattern-matching-related methods to [ThumbnailState].
extension ThumbnailStatePatterns on ThumbnailState {
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
    TResult Function(_ThumbnailState value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _ThumbnailState() when $default != null:
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
    TResult Function(_ThumbnailState value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _ThumbnailState():
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
    TResult? Function(_ThumbnailState value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _ThumbnailState() when $default != null:
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
            String projectId,
            Thumbnail variantA,
            Thumbnail? variantB,
            ThumbnailVariant selectedVariant,
            ThumbnailCanvasData variantACanvas,
            ThumbnailCanvasData variantBCanvas,
            double? ctrPredictionA,
            double? ctrPredictionB,
            List<String> ctrTips,
            List<AiThumbnailResult> aiResults,
            bool isGeneratingAi,
            bool isPredictingCtr,
            bool isSaved)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _ThumbnailState() when $default != null:
        return $default(
            _that.projectId,
            _that.variantA,
            _that.variantB,
            _that.selectedVariant,
            _that.variantACanvas,
            _that.variantBCanvas,
            _that.ctrPredictionA,
            _that.ctrPredictionB,
            _that.ctrTips,
            _that.aiResults,
            _that.isGeneratingAi,
            _that.isPredictingCtr,
            _that.isSaved);
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
            String projectId,
            Thumbnail variantA,
            Thumbnail? variantB,
            ThumbnailVariant selectedVariant,
            ThumbnailCanvasData variantACanvas,
            ThumbnailCanvasData variantBCanvas,
            double? ctrPredictionA,
            double? ctrPredictionB,
            List<String> ctrTips,
            List<AiThumbnailResult> aiResults,
            bool isGeneratingAi,
            bool isPredictingCtr,
            bool isSaved)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _ThumbnailState():
        return $default(
            _that.projectId,
            _that.variantA,
            _that.variantB,
            _that.selectedVariant,
            _that.variantACanvas,
            _that.variantBCanvas,
            _that.ctrPredictionA,
            _that.ctrPredictionB,
            _that.ctrTips,
            _that.aiResults,
            _that.isGeneratingAi,
            _that.isPredictingCtr,
            _that.isSaved);
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
            String projectId,
            Thumbnail variantA,
            Thumbnail? variantB,
            ThumbnailVariant selectedVariant,
            ThumbnailCanvasData variantACanvas,
            ThumbnailCanvasData variantBCanvas,
            double? ctrPredictionA,
            double? ctrPredictionB,
            List<String> ctrTips,
            List<AiThumbnailResult> aiResults,
            bool isGeneratingAi,
            bool isPredictingCtr,
            bool isSaved)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _ThumbnailState() when $default != null:
        return $default(
            _that.projectId,
            _that.variantA,
            _that.variantB,
            _that.selectedVariant,
            _that.variantACanvas,
            _that.variantBCanvas,
            _that.ctrPredictionA,
            _that.ctrPredictionB,
            _that.ctrTips,
            _that.aiResults,
            _that.isGeneratingAi,
            _that.isPredictingCtr,
            _that.isSaved);
      case _:
        return null;
    }
  }
}

/// @nodoc

class _ThumbnailState implements ThumbnailState {
  const _ThumbnailState(
      {required this.projectId,
      required this.variantA,
      this.variantB,
      this.selectedVariant = ThumbnailVariant.a,
      this.variantACanvas = const ThumbnailCanvasData(),
      this.variantBCanvas = const ThumbnailCanvasData(),
      this.ctrPredictionA,
      this.ctrPredictionB,
      final List<String> ctrTips = const <String>[],
      final List<AiThumbnailResult> aiResults = const <AiThumbnailResult>[],
      this.isGeneratingAi = false,
      this.isPredictingCtr = false,
      this.isSaved = false})
      : _ctrTips = ctrTips,
        _aiResults = aiResults;

  @override
  final String projectId;
  @override
  final Thumbnail variantA;
  @override
  final Thumbnail? variantB;
  @override
  @JsonKey()
  final ThumbnailVariant selectedVariant;
  @override
  @JsonKey()
  final ThumbnailCanvasData variantACanvas;
  @override
  @JsonKey()
  final ThumbnailCanvasData variantBCanvas;
  @override
  final double? ctrPredictionA;
  @override
  final double? ctrPredictionB;
  final List<String> _ctrTips;
  @override
  @JsonKey()
  List<String> get ctrTips {
    if (_ctrTips is EqualUnmodifiableListView) return _ctrTips;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_ctrTips);
  }

  final List<AiThumbnailResult> _aiResults;
  @override
  @JsonKey()
  List<AiThumbnailResult> get aiResults {
    if (_aiResults is EqualUnmodifiableListView) return _aiResults;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_aiResults);
  }

  @override
  @JsonKey()
  final bool isGeneratingAi;
  @override
  @JsonKey()
  final bool isPredictingCtr;
  @override
  @JsonKey()
  final bool isSaved;

  /// Create a copy of ThumbnailState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$ThumbnailStateCopyWith<_ThumbnailState> get copyWith =>
      __$ThumbnailStateCopyWithImpl<_ThumbnailState>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _ThumbnailState &&
            (identical(other.projectId, projectId) ||
                other.projectId == projectId) &&
            (identical(other.variantA, variantA) ||
                other.variantA == variantA) &&
            (identical(other.variantB, variantB) ||
                other.variantB == variantB) &&
            (identical(other.selectedVariant, selectedVariant) ||
                other.selectedVariant == selectedVariant) &&
            (identical(other.variantACanvas, variantACanvas) ||
                other.variantACanvas == variantACanvas) &&
            (identical(other.variantBCanvas, variantBCanvas) ||
                other.variantBCanvas == variantBCanvas) &&
            (identical(other.ctrPredictionA, ctrPredictionA) ||
                other.ctrPredictionA == ctrPredictionA) &&
            (identical(other.ctrPredictionB, ctrPredictionB) ||
                other.ctrPredictionB == ctrPredictionB) &&
            const DeepCollectionEquality().equals(other._ctrTips, _ctrTips) &&
            const DeepCollectionEquality()
                .equals(other._aiResults, _aiResults) &&
            (identical(other.isGeneratingAi, isGeneratingAi) ||
                other.isGeneratingAi == isGeneratingAi) &&
            (identical(other.isPredictingCtr, isPredictingCtr) ||
                other.isPredictingCtr == isPredictingCtr) &&
            (identical(other.isSaved, isSaved) || other.isSaved == isSaved));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      projectId,
      variantA,
      variantB,
      selectedVariant,
      variantACanvas,
      variantBCanvas,
      ctrPredictionA,
      ctrPredictionB,
      const DeepCollectionEquality().hash(_ctrTips),
      const DeepCollectionEquality().hash(_aiResults),
      isGeneratingAi,
      isPredictingCtr,
      isSaved);

  @override
  String toString() {
    return 'ThumbnailState(projectId: $projectId, variantA: $variantA, variantB: $variantB, selectedVariant: $selectedVariant, variantACanvas: $variantACanvas, variantBCanvas: $variantBCanvas, ctrPredictionA: $ctrPredictionA, ctrPredictionB: $ctrPredictionB, ctrTips: $ctrTips, aiResults: $aiResults, isGeneratingAi: $isGeneratingAi, isPredictingCtr: $isPredictingCtr, isSaved: $isSaved)';
  }
}

/// @nodoc
abstract mixin class _$ThumbnailStateCopyWith<$Res>
    implements $ThumbnailStateCopyWith<$Res> {
  factory _$ThumbnailStateCopyWith(
          _ThumbnailState value, $Res Function(_ThumbnailState) _then) =
      __$ThumbnailStateCopyWithImpl;
  @override
  @useResult
  $Res call(
      {String projectId,
      Thumbnail variantA,
      Thumbnail? variantB,
      ThumbnailVariant selectedVariant,
      ThumbnailCanvasData variantACanvas,
      ThumbnailCanvasData variantBCanvas,
      double? ctrPredictionA,
      double? ctrPredictionB,
      List<String> ctrTips,
      List<AiThumbnailResult> aiResults,
      bool isGeneratingAi,
      bool isPredictingCtr,
      bool isSaved});

  @override
  $ThumbnailCopyWith<$Res> get variantA;
  @override
  $ThumbnailCopyWith<$Res>? get variantB;
  @override
  $ThumbnailCanvasDataCopyWith<$Res> get variantACanvas;
  @override
  $ThumbnailCanvasDataCopyWith<$Res> get variantBCanvas;
}

/// @nodoc
class __$ThumbnailStateCopyWithImpl<$Res>
    implements _$ThumbnailStateCopyWith<$Res> {
  __$ThumbnailStateCopyWithImpl(this._self, this._then);

  final _ThumbnailState _self;
  final $Res Function(_ThumbnailState) _then;

  /// Create a copy of ThumbnailState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? projectId = null,
    Object? variantA = null,
    Object? variantB = freezed,
    Object? selectedVariant = null,
    Object? variantACanvas = null,
    Object? variantBCanvas = null,
    Object? ctrPredictionA = freezed,
    Object? ctrPredictionB = freezed,
    Object? ctrTips = null,
    Object? aiResults = null,
    Object? isGeneratingAi = null,
    Object? isPredictingCtr = null,
    Object? isSaved = null,
  }) {
    return _then(_ThumbnailState(
      projectId: null == projectId
          ? _self.projectId
          : projectId // ignore: cast_nullable_to_non_nullable
              as String,
      variantA: null == variantA
          ? _self.variantA
          : variantA // ignore: cast_nullable_to_non_nullable
              as Thumbnail,
      variantB: freezed == variantB
          ? _self.variantB
          : variantB // ignore: cast_nullable_to_non_nullable
              as Thumbnail?,
      selectedVariant: null == selectedVariant
          ? _self.selectedVariant
          : selectedVariant // ignore: cast_nullable_to_non_nullable
              as ThumbnailVariant,
      variantACanvas: null == variantACanvas
          ? _self.variantACanvas
          : variantACanvas // ignore: cast_nullable_to_non_nullable
              as ThumbnailCanvasData,
      variantBCanvas: null == variantBCanvas
          ? _self.variantBCanvas
          : variantBCanvas // ignore: cast_nullable_to_non_nullable
              as ThumbnailCanvasData,
      ctrPredictionA: freezed == ctrPredictionA
          ? _self.ctrPredictionA
          : ctrPredictionA // ignore: cast_nullable_to_non_nullable
              as double?,
      ctrPredictionB: freezed == ctrPredictionB
          ? _self.ctrPredictionB
          : ctrPredictionB // ignore: cast_nullable_to_non_nullable
              as double?,
      ctrTips: null == ctrTips
          ? _self._ctrTips
          : ctrTips // ignore: cast_nullable_to_non_nullable
              as List<String>,
      aiResults: null == aiResults
          ? _self._aiResults
          : aiResults // ignore: cast_nullable_to_non_nullable
              as List<AiThumbnailResult>,
      isGeneratingAi: null == isGeneratingAi
          ? _self.isGeneratingAi
          : isGeneratingAi // ignore: cast_nullable_to_non_nullable
              as bool,
      isPredictingCtr: null == isPredictingCtr
          ? _self.isPredictingCtr
          : isPredictingCtr // ignore: cast_nullable_to_non_nullable
              as bool,
      isSaved: null == isSaved
          ? _self.isSaved
          : isSaved // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }

  /// Create a copy of ThumbnailState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $ThumbnailCopyWith<$Res> get variantA {
    return $ThumbnailCopyWith<$Res>(_self.variantA, (value) {
      return _then(_self.copyWith(variantA: value));
    });
  }

  /// Create a copy of ThumbnailState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $ThumbnailCopyWith<$Res>? get variantB {
    if (_self.variantB == null) {
      return null;
    }

    return $ThumbnailCopyWith<$Res>(_self.variantB!, (value) {
      return _then(_self.copyWith(variantB: value));
    });
  }

  /// Create a copy of ThumbnailState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $ThumbnailCanvasDataCopyWith<$Res> get variantACanvas {
    return $ThumbnailCanvasDataCopyWith<$Res>(_self.variantACanvas, (value) {
      return _then(_self.copyWith(variantACanvas: value));
    });
  }

  /// Create a copy of ThumbnailState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $ThumbnailCanvasDataCopyWith<$Res> get variantBCanvas {
    return $ThumbnailCanvasDataCopyWith<$Res>(_self.variantBCanvas, (value) {
      return _then(_self.copyWith(variantBCanvas: value));
    });
  }
}

/// @nodoc
mixin _$ThumbnailCanvasData {
  ThumbnailCanvasAspect get aspect;
  String get baseFrameId;
  String get baseFrameLabel;
  List<ThumbnailLayer> get layers;
  Color get colorOverlay;
  double get overlayOpacity;
  double get gradientIndex;
  String? get aiImageLabel;
  Uint8List? get aiImageBytes;

  /// Create a copy of ThumbnailCanvasData
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $ThumbnailCanvasDataCopyWith<ThumbnailCanvasData> get copyWith =>
      _$ThumbnailCanvasDataCopyWithImpl<ThumbnailCanvasData>(
          this as ThumbnailCanvasData, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is ThumbnailCanvasData &&
            (identical(other.aspect, aspect) || other.aspect == aspect) &&
            (identical(other.baseFrameId, baseFrameId) ||
                other.baseFrameId == baseFrameId) &&
            (identical(other.baseFrameLabel, baseFrameLabel) ||
                other.baseFrameLabel == baseFrameLabel) &&
            const DeepCollectionEquality().equals(other.layers, layers) &&
            (identical(other.colorOverlay, colorOverlay) ||
                other.colorOverlay == colorOverlay) &&
            (identical(other.overlayOpacity, overlayOpacity) ||
                other.overlayOpacity == overlayOpacity) &&
            (identical(other.gradientIndex, gradientIndex) ||
                other.gradientIndex == gradientIndex) &&
            (identical(other.aiImageLabel, aiImageLabel) ||
                other.aiImageLabel == aiImageLabel) &&
            const DeepCollectionEquality()
                .equals(other.aiImageBytes, aiImageBytes));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      aspect,
      baseFrameId,
      baseFrameLabel,
      const DeepCollectionEquality().hash(layers),
      colorOverlay,
      overlayOpacity,
      gradientIndex,
      aiImageLabel,
      const DeepCollectionEquality().hash(aiImageBytes));

  @override
  String toString() {
    return 'ThumbnailCanvasData(aspect: $aspect, baseFrameId: $baseFrameId, baseFrameLabel: $baseFrameLabel, layers: $layers, colorOverlay: $colorOverlay, overlayOpacity: $overlayOpacity, gradientIndex: $gradientIndex, aiImageLabel: $aiImageLabel, aiImageBytes: $aiImageBytes)';
  }
}

/// @nodoc
abstract mixin class $ThumbnailCanvasDataCopyWith<$Res> {
  factory $ThumbnailCanvasDataCopyWith(
          ThumbnailCanvasData value, $Res Function(ThumbnailCanvasData) _then) =
      _$ThumbnailCanvasDataCopyWithImpl;
  @useResult
  $Res call(
      {ThumbnailCanvasAspect aspect,
      String baseFrameId,
      String baseFrameLabel,
      List<ThumbnailLayer> layers,
      Color colorOverlay,
      double overlayOpacity,
      double gradientIndex,
      String? aiImageLabel,
      Uint8List? aiImageBytes});
}

/// @nodoc
class _$ThumbnailCanvasDataCopyWithImpl<$Res>
    implements $ThumbnailCanvasDataCopyWith<$Res> {
  _$ThumbnailCanvasDataCopyWithImpl(this._self, this._then);

  final ThumbnailCanvasData _self;
  final $Res Function(ThumbnailCanvasData) _then;

  /// Create a copy of ThumbnailCanvasData
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? aspect = null,
    Object? baseFrameId = null,
    Object? baseFrameLabel = null,
    Object? layers = null,
    Object? colorOverlay = null,
    Object? overlayOpacity = null,
    Object? gradientIndex = null,
    Object? aiImageLabel = freezed,
    Object? aiImageBytes = freezed,
  }) {
    return _then(_self.copyWith(
      aspect: null == aspect
          ? _self.aspect
          : aspect // ignore: cast_nullable_to_non_nullable
              as ThumbnailCanvasAspect,
      baseFrameId: null == baseFrameId
          ? _self.baseFrameId
          : baseFrameId // ignore: cast_nullable_to_non_nullable
              as String,
      baseFrameLabel: null == baseFrameLabel
          ? _self.baseFrameLabel
          : baseFrameLabel // ignore: cast_nullable_to_non_nullable
              as String,
      layers: null == layers
          ? _self.layers
          : layers // ignore: cast_nullable_to_non_nullable
              as List<ThumbnailLayer>,
      colorOverlay: null == colorOverlay
          ? _self.colorOverlay
          : colorOverlay // ignore: cast_nullable_to_non_nullable
              as Color,
      overlayOpacity: null == overlayOpacity
          ? _self.overlayOpacity
          : overlayOpacity // ignore: cast_nullable_to_non_nullable
              as double,
      gradientIndex: null == gradientIndex
          ? _self.gradientIndex
          : gradientIndex // ignore: cast_nullable_to_non_nullable
              as double,
      aiImageLabel: freezed == aiImageLabel
          ? _self.aiImageLabel
          : aiImageLabel // ignore: cast_nullable_to_non_nullable
              as String?,
      aiImageBytes: freezed == aiImageBytes
          ? _self.aiImageBytes
          : aiImageBytes // ignore: cast_nullable_to_non_nullable
              as Uint8List?,
    ));
  }
}

/// Adds pattern-matching-related methods to [ThumbnailCanvasData].
extension ThumbnailCanvasDataPatterns on ThumbnailCanvasData {
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
    TResult Function(_ThumbnailCanvasData value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _ThumbnailCanvasData() when $default != null:
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
    TResult Function(_ThumbnailCanvasData value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _ThumbnailCanvasData():
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
    TResult? Function(_ThumbnailCanvasData value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _ThumbnailCanvasData() when $default != null:
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
            ThumbnailCanvasAspect aspect,
            String baseFrameId,
            String baseFrameLabel,
            List<ThumbnailLayer> layers,
            Color colorOverlay,
            double overlayOpacity,
            double gradientIndex,
            String? aiImageLabel,
            Uint8List? aiImageBytes)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _ThumbnailCanvasData() when $default != null:
        return $default(
            _that.aspect,
            _that.baseFrameId,
            _that.baseFrameLabel,
            _that.layers,
            _that.colorOverlay,
            _that.overlayOpacity,
            _that.gradientIndex,
            _that.aiImageLabel,
            _that.aiImageBytes);
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
            ThumbnailCanvasAspect aspect,
            String baseFrameId,
            String baseFrameLabel,
            List<ThumbnailLayer> layers,
            Color colorOverlay,
            double overlayOpacity,
            double gradientIndex,
            String? aiImageLabel,
            Uint8List? aiImageBytes)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _ThumbnailCanvasData():
        return $default(
            _that.aspect,
            _that.baseFrameId,
            _that.baseFrameLabel,
            _that.layers,
            _that.colorOverlay,
            _that.overlayOpacity,
            _that.gradientIndex,
            _that.aiImageLabel,
            _that.aiImageBytes);
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
            ThumbnailCanvasAspect aspect,
            String baseFrameId,
            String baseFrameLabel,
            List<ThumbnailLayer> layers,
            Color colorOverlay,
            double overlayOpacity,
            double gradientIndex,
            String? aiImageLabel,
            Uint8List? aiImageBytes)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _ThumbnailCanvasData() when $default != null:
        return $default(
            _that.aspect,
            _that.baseFrameId,
            _that.baseFrameLabel,
            _that.layers,
            _that.colorOverlay,
            _that.overlayOpacity,
            _that.gradientIndex,
            _that.aiImageLabel,
            _that.aiImageBytes);
      case _:
        return null;
    }
  }
}

/// @nodoc

class _ThumbnailCanvasData implements ThumbnailCanvasData {
  const _ThumbnailCanvasData(
      {this.aspect = ThumbnailCanvasAspect.portrait,
      this.baseFrameId = 'frame_1',
      this.baseFrameLabel = 'Frame 1',
      final List<ThumbnailLayer> layers = const <ThumbnailLayer>[],
      this.colorOverlay = const Color(0x00000000),
      this.overlayOpacity = 0,
      this.gradientIndex = 0,
      this.aiImageLabel,
      this.aiImageBytes})
      : _layers = layers;

  @override
  @JsonKey()
  final ThumbnailCanvasAspect aspect;
  @override
  @JsonKey()
  final String baseFrameId;
  @override
  @JsonKey()
  final String baseFrameLabel;
  final List<ThumbnailLayer> _layers;
  @override
  @JsonKey()
  List<ThumbnailLayer> get layers {
    if (_layers is EqualUnmodifiableListView) return _layers;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_layers);
  }

  @override
  @JsonKey()
  final Color colorOverlay;
  @override
  @JsonKey()
  final double overlayOpacity;
  @override
  @JsonKey()
  final double gradientIndex;
  @override
  final String? aiImageLabel;
  @override
  final Uint8List? aiImageBytes;

  /// Create a copy of ThumbnailCanvasData
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$ThumbnailCanvasDataCopyWith<_ThumbnailCanvasData> get copyWith =>
      __$ThumbnailCanvasDataCopyWithImpl<_ThumbnailCanvasData>(
          this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _ThumbnailCanvasData &&
            (identical(other.aspect, aspect) || other.aspect == aspect) &&
            (identical(other.baseFrameId, baseFrameId) ||
                other.baseFrameId == baseFrameId) &&
            (identical(other.baseFrameLabel, baseFrameLabel) ||
                other.baseFrameLabel == baseFrameLabel) &&
            const DeepCollectionEquality().equals(other._layers, _layers) &&
            (identical(other.colorOverlay, colorOverlay) ||
                other.colorOverlay == colorOverlay) &&
            (identical(other.overlayOpacity, overlayOpacity) ||
                other.overlayOpacity == overlayOpacity) &&
            (identical(other.gradientIndex, gradientIndex) ||
                other.gradientIndex == gradientIndex) &&
            (identical(other.aiImageLabel, aiImageLabel) ||
                other.aiImageLabel == aiImageLabel) &&
            const DeepCollectionEquality()
                .equals(other.aiImageBytes, aiImageBytes));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      aspect,
      baseFrameId,
      baseFrameLabel,
      const DeepCollectionEquality().hash(_layers),
      colorOverlay,
      overlayOpacity,
      gradientIndex,
      aiImageLabel,
      const DeepCollectionEquality().hash(aiImageBytes));

  @override
  String toString() {
    return 'ThumbnailCanvasData(aspect: $aspect, baseFrameId: $baseFrameId, baseFrameLabel: $baseFrameLabel, layers: $layers, colorOverlay: $colorOverlay, overlayOpacity: $overlayOpacity, gradientIndex: $gradientIndex, aiImageLabel: $aiImageLabel, aiImageBytes: $aiImageBytes)';
  }
}

/// @nodoc
abstract mixin class _$ThumbnailCanvasDataCopyWith<$Res>
    implements $ThumbnailCanvasDataCopyWith<$Res> {
  factory _$ThumbnailCanvasDataCopyWith(_ThumbnailCanvasData value,
          $Res Function(_ThumbnailCanvasData) _then) =
      __$ThumbnailCanvasDataCopyWithImpl;
  @override
  @useResult
  $Res call(
      {ThumbnailCanvasAspect aspect,
      String baseFrameId,
      String baseFrameLabel,
      List<ThumbnailLayer> layers,
      Color colorOverlay,
      double overlayOpacity,
      double gradientIndex,
      String? aiImageLabel,
      Uint8List? aiImageBytes});
}

/// @nodoc
class __$ThumbnailCanvasDataCopyWithImpl<$Res>
    implements _$ThumbnailCanvasDataCopyWith<$Res> {
  __$ThumbnailCanvasDataCopyWithImpl(this._self, this._then);

  final _ThumbnailCanvasData _self;
  final $Res Function(_ThumbnailCanvasData) _then;

  /// Create a copy of ThumbnailCanvasData
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? aspect = null,
    Object? baseFrameId = null,
    Object? baseFrameLabel = null,
    Object? layers = null,
    Object? colorOverlay = null,
    Object? overlayOpacity = null,
    Object? gradientIndex = null,
    Object? aiImageLabel = freezed,
    Object? aiImageBytes = freezed,
  }) {
    return _then(_ThumbnailCanvasData(
      aspect: null == aspect
          ? _self.aspect
          : aspect // ignore: cast_nullable_to_non_nullable
              as ThumbnailCanvasAspect,
      baseFrameId: null == baseFrameId
          ? _self.baseFrameId
          : baseFrameId // ignore: cast_nullable_to_non_nullable
              as String,
      baseFrameLabel: null == baseFrameLabel
          ? _self.baseFrameLabel
          : baseFrameLabel // ignore: cast_nullable_to_non_nullable
              as String,
      layers: null == layers
          ? _self._layers
          : layers // ignore: cast_nullable_to_non_nullable
              as List<ThumbnailLayer>,
      colorOverlay: null == colorOverlay
          ? _self.colorOverlay
          : colorOverlay // ignore: cast_nullable_to_non_nullable
              as Color,
      overlayOpacity: null == overlayOpacity
          ? _self.overlayOpacity
          : overlayOpacity // ignore: cast_nullable_to_non_nullable
              as double,
      gradientIndex: null == gradientIndex
          ? _self.gradientIndex
          : gradientIndex // ignore: cast_nullable_to_non_nullable
              as double,
      aiImageLabel: freezed == aiImageLabel
          ? _self.aiImageLabel
          : aiImageLabel // ignore: cast_nullable_to_non_nullable
              as String?,
      aiImageBytes: freezed == aiImageBytes
          ? _self.aiImageBytes
          : aiImageBytes // ignore: cast_nullable_to_non_nullable
              as Uint8List?,
    ));
  }
}

/// @nodoc
mixin _$ThumbnailLayer {
  String get id;
  ThumbnailLayerType get type;
  String get text;
  String get sticker;
  Offset get position;
  double get scale;
  double get rotation;
  double get fontSize;
  String get fontFamily;
  Color get color;
  Color get strokeColor;
  bool get shadow;

  /// Create a copy of ThumbnailLayer
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $ThumbnailLayerCopyWith<ThumbnailLayer> get copyWith =>
      _$ThumbnailLayerCopyWithImpl<ThumbnailLayer>(
          this as ThumbnailLayer, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is ThumbnailLayer &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.text, text) || other.text == text) &&
            (identical(other.sticker, sticker) || other.sticker == sticker) &&
            (identical(other.position, position) ||
                other.position == position) &&
            (identical(other.scale, scale) || other.scale == scale) &&
            (identical(other.rotation, rotation) ||
                other.rotation == rotation) &&
            (identical(other.fontSize, fontSize) ||
                other.fontSize == fontSize) &&
            (identical(other.fontFamily, fontFamily) ||
                other.fontFamily == fontFamily) &&
            (identical(other.color, color) || other.color == color) &&
            (identical(other.strokeColor, strokeColor) ||
                other.strokeColor == strokeColor) &&
            (identical(other.shadow, shadow) || other.shadow == shadow));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      type,
      text,
      sticker,
      position,
      scale,
      rotation,
      fontSize,
      fontFamily,
      color,
      strokeColor,
      shadow);

  @override
  String toString() {
    return 'ThumbnailLayer(id: $id, type: $type, text: $text, sticker: $sticker, position: $position, scale: $scale, rotation: $rotation, fontSize: $fontSize, fontFamily: $fontFamily, color: $color, strokeColor: $strokeColor, shadow: $shadow)';
  }
}

/// @nodoc
abstract mixin class $ThumbnailLayerCopyWith<$Res> {
  factory $ThumbnailLayerCopyWith(
          ThumbnailLayer value, $Res Function(ThumbnailLayer) _then) =
      _$ThumbnailLayerCopyWithImpl;
  @useResult
  $Res call(
      {String id,
      ThumbnailLayerType type,
      String text,
      String sticker,
      Offset position,
      double scale,
      double rotation,
      double fontSize,
      String fontFamily,
      Color color,
      Color strokeColor,
      bool shadow});
}

/// @nodoc
class _$ThumbnailLayerCopyWithImpl<$Res>
    implements $ThumbnailLayerCopyWith<$Res> {
  _$ThumbnailLayerCopyWithImpl(this._self, this._then);

  final ThumbnailLayer _self;
  final $Res Function(ThumbnailLayer) _then;

  /// Create a copy of ThumbnailLayer
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? type = null,
    Object? text = null,
    Object? sticker = null,
    Object? position = null,
    Object? scale = null,
    Object? rotation = null,
    Object? fontSize = null,
    Object? fontFamily = null,
    Object? color = null,
    Object? strokeColor = null,
    Object? shadow = null,
  }) {
    return _then(_self.copyWith(
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      type: null == type
          ? _self.type
          : type // ignore: cast_nullable_to_non_nullable
              as ThumbnailLayerType,
      text: null == text
          ? _self.text
          : text // ignore: cast_nullable_to_non_nullable
              as String,
      sticker: null == sticker
          ? _self.sticker
          : sticker // ignore: cast_nullable_to_non_nullable
              as String,
      position: null == position
          ? _self.position
          : position // ignore: cast_nullable_to_non_nullable
              as Offset,
      scale: null == scale
          ? _self.scale
          : scale // ignore: cast_nullable_to_non_nullable
              as double,
      rotation: null == rotation
          ? _self.rotation
          : rotation // ignore: cast_nullable_to_non_nullable
              as double,
      fontSize: null == fontSize
          ? _self.fontSize
          : fontSize // ignore: cast_nullable_to_non_nullable
              as double,
      fontFamily: null == fontFamily
          ? _self.fontFamily
          : fontFamily // ignore: cast_nullable_to_non_nullable
              as String,
      color: null == color
          ? _self.color
          : color // ignore: cast_nullable_to_non_nullable
              as Color,
      strokeColor: null == strokeColor
          ? _self.strokeColor
          : strokeColor // ignore: cast_nullable_to_non_nullable
              as Color,
      shadow: null == shadow
          ? _self.shadow
          : shadow // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// Adds pattern-matching-related methods to [ThumbnailLayer].
extension ThumbnailLayerPatterns on ThumbnailLayer {
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
    TResult Function(_ThumbnailLayer value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _ThumbnailLayer() when $default != null:
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
    TResult Function(_ThumbnailLayer value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _ThumbnailLayer():
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
    TResult? Function(_ThumbnailLayer value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _ThumbnailLayer() when $default != null:
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
            ThumbnailLayerType type,
            String text,
            String sticker,
            Offset position,
            double scale,
            double rotation,
            double fontSize,
            String fontFamily,
            Color color,
            Color strokeColor,
            bool shadow)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _ThumbnailLayer() when $default != null:
        return $default(
            _that.id,
            _that.type,
            _that.text,
            _that.sticker,
            _that.position,
            _that.scale,
            _that.rotation,
            _that.fontSize,
            _that.fontFamily,
            _that.color,
            _that.strokeColor,
            _that.shadow);
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
            ThumbnailLayerType type,
            String text,
            String sticker,
            Offset position,
            double scale,
            double rotation,
            double fontSize,
            String fontFamily,
            Color color,
            Color strokeColor,
            bool shadow)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _ThumbnailLayer():
        return $default(
            _that.id,
            _that.type,
            _that.text,
            _that.sticker,
            _that.position,
            _that.scale,
            _that.rotation,
            _that.fontSize,
            _that.fontFamily,
            _that.color,
            _that.strokeColor,
            _that.shadow);
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
            ThumbnailLayerType type,
            String text,
            String sticker,
            Offset position,
            double scale,
            double rotation,
            double fontSize,
            String fontFamily,
            Color color,
            Color strokeColor,
            bool shadow)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _ThumbnailLayer() when $default != null:
        return $default(
            _that.id,
            _that.type,
            _that.text,
            _that.sticker,
            _that.position,
            _that.scale,
            _that.rotation,
            _that.fontSize,
            _that.fontFamily,
            _that.color,
            _that.strokeColor,
            _that.shadow);
      case _:
        return null;
    }
  }
}

/// @nodoc

class _ThumbnailLayer implements ThumbnailLayer {
  const _ThumbnailLayer(
      {required this.id,
      required this.type,
      this.text = 'Headline',
      this.sticker = '🔥',
      this.position = const Offset(120, 220),
      this.scale = 1,
      this.rotation = 0,
      this.fontSize = 48,
      this.fontFamily = 'Impact',
      this.color = const Color(0xFFFFFFFF),
      this.strokeColor = const Color(0xFF0B0C10),
      this.shadow = true});

  @override
  final String id;
  @override
  final ThumbnailLayerType type;
  @override
  @JsonKey()
  final String text;
  @override
  @JsonKey()
  final String sticker;
  @override
  @JsonKey()
  final Offset position;
  @override
  @JsonKey()
  final double scale;
  @override
  @JsonKey()
  final double rotation;
  @override
  @JsonKey()
  final double fontSize;
  @override
  @JsonKey()
  final String fontFamily;
  @override
  @JsonKey()
  final Color color;
  @override
  @JsonKey()
  final Color strokeColor;
  @override
  @JsonKey()
  final bool shadow;

  /// Create a copy of ThumbnailLayer
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$ThumbnailLayerCopyWith<_ThumbnailLayer> get copyWith =>
      __$ThumbnailLayerCopyWithImpl<_ThumbnailLayer>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _ThumbnailLayer &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.text, text) || other.text == text) &&
            (identical(other.sticker, sticker) || other.sticker == sticker) &&
            (identical(other.position, position) ||
                other.position == position) &&
            (identical(other.scale, scale) || other.scale == scale) &&
            (identical(other.rotation, rotation) ||
                other.rotation == rotation) &&
            (identical(other.fontSize, fontSize) ||
                other.fontSize == fontSize) &&
            (identical(other.fontFamily, fontFamily) ||
                other.fontFamily == fontFamily) &&
            (identical(other.color, color) || other.color == color) &&
            (identical(other.strokeColor, strokeColor) ||
                other.strokeColor == strokeColor) &&
            (identical(other.shadow, shadow) || other.shadow == shadow));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      type,
      text,
      sticker,
      position,
      scale,
      rotation,
      fontSize,
      fontFamily,
      color,
      strokeColor,
      shadow);

  @override
  String toString() {
    return 'ThumbnailLayer(id: $id, type: $type, text: $text, sticker: $sticker, position: $position, scale: $scale, rotation: $rotation, fontSize: $fontSize, fontFamily: $fontFamily, color: $color, strokeColor: $strokeColor, shadow: $shadow)';
  }
}

/// @nodoc
abstract mixin class _$ThumbnailLayerCopyWith<$Res>
    implements $ThumbnailLayerCopyWith<$Res> {
  factory _$ThumbnailLayerCopyWith(
          _ThumbnailLayer value, $Res Function(_ThumbnailLayer) _then) =
      __$ThumbnailLayerCopyWithImpl;
  @override
  @useResult
  $Res call(
      {String id,
      ThumbnailLayerType type,
      String text,
      String sticker,
      Offset position,
      double scale,
      double rotation,
      double fontSize,
      String fontFamily,
      Color color,
      Color strokeColor,
      bool shadow});
}

/// @nodoc
class __$ThumbnailLayerCopyWithImpl<$Res>
    implements _$ThumbnailLayerCopyWith<$Res> {
  __$ThumbnailLayerCopyWithImpl(this._self, this._then);

  final _ThumbnailLayer _self;
  final $Res Function(_ThumbnailLayer) _then;

  /// Create a copy of ThumbnailLayer
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? id = null,
    Object? type = null,
    Object? text = null,
    Object? sticker = null,
    Object? position = null,
    Object? scale = null,
    Object? rotation = null,
    Object? fontSize = null,
    Object? fontFamily = null,
    Object? color = null,
    Object? strokeColor = null,
    Object? shadow = null,
  }) {
    return _then(_ThumbnailLayer(
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      type: null == type
          ? _self.type
          : type // ignore: cast_nullable_to_non_nullable
              as ThumbnailLayerType,
      text: null == text
          ? _self.text
          : text // ignore: cast_nullable_to_non_nullable
              as String,
      sticker: null == sticker
          ? _self.sticker
          : sticker // ignore: cast_nullable_to_non_nullable
              as String,
      position: null == position
          ? _self.position
          : position // ignore: cast_nullable_to_non_nullable
              as Offset,
      scale: null == scale
          ? _self.scale
          : scale // ignore: cast_nullable_to_non_nullable
              as double,
      rotation: null == rotation
          ? _self.rotation
          : rotation // ignore: cast_nullable_to_non_nullable
              as double,
      fontSize: null == fontSize
          ? _self.fontSize
          : fontSize // ignore: cast_nullable_to_non_nullable
              as double,
      fontFamily: null == fontFamily
          ? _self.fontFamily
          : fontFamily // ignore: cast_nullable_to_non_nullable
              as String,
      color: null == color
          ? _self.color
          : color // ignore: cast_nullable_to_non_nullable
              as Color,
      strokeColor: null == strokeColor
          ? _self.strokeColor
          : strokeColor // ignore: cast_nullable_to_non_nullable
              as Color,
      shadow: null == shadow
          ? _self.shadow
          : shadow // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

// dart format on
