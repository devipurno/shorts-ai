// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'subtitle_provider.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$SubtitleState {
  String get projectId;
  List<SubtitleSegment> get segments;
  SubtitleStyle get style;
  SubtitleAnimationPreset get animation;
  SubtitleFormat get format;
  SubtitleBackgroundStyle get backgroundStyle;
  double get strokeWidth;
  String get karaokeColor;
  int get currentPositionMs;
  int get selectedSegmentIndex;
  String? get exportedContent;

  /// Create a copy of SubtitleState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $SubtitleStateCopyWith<SubtitleState> get copyWith =>
      _$SubtitleStateCopyWithImpl<SubtitleState>(
          this as SubtitleState, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is SubtitleState &&
            (identical(other.projectId, projectId) ||
                other.projectId == projectId) &&
            const DeepCollectionEquality().equals(other.segments, segments) &&
            (identical(other.style, style) || other.style == style) &&
            (identical(other.animation, animation) ||
                other.animation == animation) &&
            (identical(other.format, format) || other.format == format) &&
            (identical(other.backgroundStyle, backgroundStyle) ||
                other.backgroundStyle == backgroundStyle) &&
            (identical(other.strokeWidth, strokeWidth) ||
                other.strokeWidth == strokeWidth) &&
            (identical(other.karaokeColor, karaokeColor) ||
                other.karaokeColor == karaokeColor) &&
            (identical(other.currentPositionMs, currentPositionMs) ||
                other.currentPositionMs == currentPositionMs) &&
            (identical(other.selectedSegmentIndex, selectedSegmentIndex) ||
                other.selectedSegmentIndex == selectedSegmentIndex) &&
            (identical(other.exportedContent, exportedContent) ||
                other.exportedContent == exportedContent));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      projectId,
      const DeepCollectionEquality().hash(segments),
      style,
      animation,
      format,
      backgroundStyle,
      strokeWidth,
      karaokeColor,
      currentPositionMs,
      selectedSegmentIndex,
      exportedContent);

  @override
  String toString() {
    return 'SubtitleState(projectId: $projectId, segments: $segments, style: $style, animation: $animation, format: $format, backgroundStyle: $backgroundStyle, strokeWidth: $strokeWidth, karaokeColor: $karaokeColor, currentPositionMs: $currentPositionMs, selectedSegmentIndex: $selectedSegmentIndex, exportedContent: $exportedContent)';
  }
}

/// @nodoc
abstract mixin class $SubtitleStateCopyWith<$Res> {
  factory $SubtitleStateCopyWith(
          SubtitleState value, $Res Function(SubtitleState) _then) =
      _$SubtitleStateCopyWithImpl;
  @useResult
  $Res call(
      {String projectId,
      List<SubtitleSegment> segments,
      SubtitleStyle style,
      SubtitleAnimationPreset animation,
      SubtitleFormat format,
      SubtitleBackgroundStyle backgroundStyle,
      double strokeWidth,
      String karaokeColor,
      int currentPositionMs,
      int selectedSegmentIndex,
      String? exportedContent});

  $SubtitleStyleCopyWith<$Res> get style;
}

/// @nodoc
class _$SubtitleStateCopyWithImpl<$Res>
    implements $SubtitleStateCopyWith<$Res> {
  _$SubtitleStateCopyWithImpl(this._self, this._then);

  final SubtitleState _self;
  final $Res Function(SubtitleState) _then;

  /// Create a copy of SubtitleState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? projectId = null,
    Object? segments = null,
    Object? style = null,
    Object? animation = null,
    Object? format = null,
    Object? backgroundStyle = null,
    Object? strokeWidth = null,
    Object? karaokeColor = null,
    Object? currentPositionMs = null,
    Object? selectedSegmentIndex = null,
    Object? exportedContent = freezed,
  }) {
    return _then(_self.copyWith(
      projectId: null == projectId
          ? _self.projectId
          : projectId // ignore: cast_nullable_to_non_nullable
              as String,
      segments: null == segments
          ? _self.segments
          : segments // ignore: cast_nullable_to_non_nullable
              as List<SubtitleSegment>,
      style: null == style
          ? _self.style
          : style // ignore: cast_nullable_to_non_nullable
              as SubtitleStyle,
      animation: null == animation
          ? _self.animation
          : animation // ignore: cast_nullable_to_non_nullable
              as SubtitleAnimationPreset,
      format: null == format
          ? _self.format
          : format // ignore: cast_nullable_to_non_nullable
              as SubtitleFormat,
      backgroundStyle: null == backgroundStyle
          ? _self.backgroundStyle
          : backgroundStyle // ignore: cast_nullable_to_non_nullable
              as SubtitleBackgroundStyle,
      strokeWidth: null == strokeWidth
          ? _self.strokeWidth
          : strokeWidth // ignore: cast_nullable_to_non_nullable
              as double,
      karaokeColor: null == karaokeColor
          ? _self.karaokeColor
          : karaokeColor // ignore: cast_nullable_to_non_nullable
              as String,
      currentPositionMs: null == currentPositionMs
          ? _self.currentPositionMs
          : currentPositionMs // ignore: cast_nullable_to_non_nullable
              as int,
      selectedSegmentIndex: null == selectedSegmentIndex
          ? _self.selectedSegmentIndex
          : selectedSegmentIndex // ignore: cast_nullable_to_non_nullable
              as int,
      exportedContent: freezed == exportedContent
          ? _self.exportedContent
          : exportedContent // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }

  /// Create a copy of SubtitleState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $SubtitleStyleCopyWith<$Res> get style {
    return $SubtitleStyleCopyWith<$Res>(_self.style, (value) {
      return _then(_self.copyWith(style: value));
    });
  }
}

/// Adds pattern-matching-related methods to [SubtitleState].
extension SubtitleStatePatterns on SubtitleState {
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
    TResult Function(_SubtitleState value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _SubtitleState() when $default != null:
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
    TResult Function(_SubtitleState value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _SubtitleState():
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
    TResult? Function(_SubtitleState value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _SubtitleState() when $default != null:
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
            List<SubtitleSegment> segments,
            SubtitleStyle style,
            SubtitleAnimationPreset animation,
            SubtitleFormat format,
            SubtitleBackgroundStyle backgroundStyle,
            double strokeWidth,
            String karaokeColor,
            int currentPositionMs,
            int selectedSegmentIndex,
            String? exportedContent)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _SubtitleState() when $default != null:
        return $default(
            _that.projectId,
            _that.segments,
            _that.style,
            _that.animation,
            _that.format,
            _that.backgroundStyle,
            _that.strokeWidth,
            _that.karaokeColor,
            _that.currentPositionMs,
            _that.selectedSegmentIndex,
            _that.exportedContent);
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
            List<SubtitleSegment> segments,
            SubtitleStyle style,
            SubtitleAnimationPreset animation,
            SubtitleFormat format,
            SubtitleBackgroundStyle backgroundStyle,
            double strokeWidth,
            String karaokeColor,
            int currentPositionMs,
            int selectedSegmentIndex,
            String? exportedContent)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _SubtitleState():
        return $default(
            _that.projectId,
            _that.segments,
            _that.style,
            _that.animation,
            _that.format,
            _that.backgroundStyle,
            _that.strokeWidth,
            _that.karaokeColor,
            _that.currentPositionMs,
            _that.selectedSegmentIndex,
            _that.exportedContent);
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
            List<SubtitleSegment> segments,
            SubtitleStyle style,
            SubtitleAnimationPreset animation,
            SubtitleFormat format,
            SubtitleBackgroundStyle backgroundStyle,
            double strokeWidth,
            String karaokeColor,
            int currentPositionMs,
            int selectedSegmentIndex,
            String? exportedContent)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _SubtitleState() when $default != null:
        return $default(
            _that.projectId,
            _that.segments,
            _that.style,
            _that.animation,
            _that.format,
            _that.backgroundStyle,
            _that.strokeWidth,
            _that.karaokeColor,
            _that.currentPositionMs,
            _that.selectedSegmentIndex,
            _that.exportedContent);
      case _:
        return null;
    }
  }
}

/// @nodoc

class _SubtitleState implements SubtitleState {
  const _SubtitleState(
      {required this.projectId,
      final List<SubtitleSegment> segments = const <SubtitleSegment>[],
      this.style = const SubtitleStyle(),
      this.animation = SubtitleAnimationPreset.karaokeGlow,
      this.format = SubtitleFormat.ass,
      this.backgroundStyle = SubtitleBackgroundStyle.karaokeHighlight,
      this.strokeWidth = 3,
      this.karaokeColor = '#D4AF37',
      this.currentPositionMs = 0,
      this.selectedSegmentIndex = 0,
      this.exportedContent})
      : _segments = segments;

  @override
  final String projectId;
  final List<SubtitleSegment> _segments;
  @override
  @JsonKey()
  List<SubtitleSegment> get segments {
    if (_segments is EqualUnmodifiableListView) return _segments;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_segments);
  }

  @override
  @JsonKey()
  final SubtitleStyle style;
  @override
  @JsonKey()
  final SubtitleAnimationPreset animation;
  @override
  @JsonKey()
  final SubtitleFormat format;
  @override
  @JsonKey()
  final SubtitleBackgroundStyle backgroundStyle;
  @override
  @JsonKey()
  final double strokeWidth;
  @override
  @JsonKey()
  final String karaokeColor;
  @override
  @JsonKey()
  final int currentPositionMs;
  @override
  @JsonKey()
  final int selectedSegmentIndex;
  @override
  final String? exportedContent;

  /// Create a copy of SubtitleState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$SubtitleStateCopyWith<_SubtitleState> get copyWith =>
      __$SubtitleStateCopyWithImpl<_SubtitleState>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _SubtitleState &&
            (identical(other.projectId, projectId) ||
                other.projectId == projectId) &&
            const DeepCollectionEquality().equals(other._segments, _segments) &&
            (identical(other.style, style) || other.style == style) &&
            (identical(other.animation, animation) ||
                other.animation == animation) &&
            (identical(other.format, format) || other.format == format) &&
            (identical(other.backgroundStyle, backgroundStyle) ||
                other.backgroundStyle == backgroundStyle) &&
            (identical(other.strokeWidth, strokeWidth) ||
                other.strokeWidth == strokeWidth) &&
            (identical(other.karaokeColor, karaokeColor) ||
                other.karaokeColor == karaokeColor) &&
            (identical(other.currentPositionMs, currentPositionMs) ||
                other.currentPositionMs == currentPositionMs) &&
            (identical(other.selectedSegmentIndex, selectedSegmentIndex) ||
                other.selectedSegmentIndex == selectedSegmentIndex) &&
            (identical(other.exportedContent, exportedContent) ||
                other.exportedContent == exportedContent));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      projectId,
      const DeepCollectionEquality().hash(_segments),
      style,
      animation,
      format,
      backgroundStyle,
      strokeWidth,
      karaokeColor,
      currentPositionMs,
      selectedSegmentIndex,
      exportedContent);

  @override
  String toString() {
    return 'SubtitleState(projectId: $projectId, segments: $segments, style: $style, animation: $animation, format: $format, backgroundStyle: $backgroundStyle, strokeWidth: $strokeWidth, karaokeColor: $karaokeColor, currentPositionMs: $currentPositionMs, selectedSegmentIndex: $selectedSegmentIndex, exportedContent: $exportedContent)';
  }
}

/// @nodoc
abstract mixin class _$SubtitleStateCopyWith<$Res>
    implements $SubtitleStateCopyWith<$Res> {
  factory _$SubtitleStateCopyWith(
          _SubtitleState value, $Res Function(_SubtitleState) _then) =
      __$SubtitleStateCopyWithImpl;
  @override
  @useResult
  $Res call(
      {String projectId,
      List<SubtitleSegment> segments,
      SubtitleStyle style,
      SubtitleAnimationPreset animation,
      SubtitleFormat format,
      SubtitleBackgroundStyle backgroundStyle,
      double strokeWidth,
      String karaokeColor,
      int currentPositionMs,
      int selectedSegmentIndex,
      String? exportedContent});

  @override
  $SubtitleStyleCopyWith<$Res> get style;
}

/// @nodoc
class __$SubtitleStateCopyWithImpl<$Res>
    implements _$SubtitleStateCopyWith<$Res> {
  __$SubtitleStateCopyWithImpl(this._self, this._then);

  final _SubtitleState _self;
  final $Res Function(_SubtitleState) _then;

  /// Create a copy of SubtitleState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? projectId = null,
    Object? segments = null,
    Object? style = null,
    Object? animation = null,
    Object? format = null,
    Object? backgroundStyle = null,
    Object? strokeWidth = null,
    Object? karaokeColor = null,
    Object? currentPositionMs = null,
    Object? selectedSegmentIndex = null,
    Object? exportedContent = freezed,
  }) {
    return _then(_SubtitleState(
      projectId: null == projectId
          ? _self.projectId
          : projectId // ignore: cast_nullable_to_non_nullable
              as String,
      segments: null == segments
          ? _self._segments
          : segments // ignore: cast_nullable_to_non_nullable
              as List<SubtitleSegment>,
      style: null == style
          ? _self.style
          : style // ignore: cast_nullable_to_non_nullable
              as SubtitleStyle,
      animation: null == animation
          ? _self.animation
          : animation // ignore: cast_nullable_to_non_nullable
              as SubtitleAnimationPreset,
      format: null == format
          ? _self.format
          : format // ignore: cast_nullable_to_non_nullable
              as SubtitleFormat,
      backgroundStyle: null == backgroundStyle
          ? _self.backgroundStyle
          : backgroundStyle // ignore: cast_nullable_to_non_nullable
              as SubtitleBackgroundStyle,
      strokeWidth: null == strokeWidth
          ? _self.strokeWidth
          : strokeWidth // ignore: cast_nullable_to_non_nullable
              as double,
      karaokeColor: null == karaokeColor
          ? _self.karaokeColor
          : karaokeColor // ignore: cast_nullable_to_non_nullable
              as String,
      currentPositionMs: null == currentPositionMs
          ? _self.currentPositionMs
          : currentPositionMs // ignore: cast_nullable_to_non_nullable
              as int,
      selectedSegmentIndex: null == selectedSegmentIndex
          ? _self.selectedSegmentIndex
          : selectedSegmentIndex // ignore: cast_nullable_to_non_nullable
              as int,
      exportedContent: freezed == exportedContent
          ? _self.exportedContent
          : exportedContent // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }

  /// Create a copy of SubtitleState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $SubtitleStyleCopyWith<$Res> get style {
    return $SubtitleStyleCopyWith<$Res>(_self.style, (value) {
      return _then(_self.copyWith(style: value));
    });
  }
}

// dart format on
