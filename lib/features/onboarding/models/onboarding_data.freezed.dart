// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'onboarding_data.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$OnboardingData {
  String? get niche;
  List<String> get goals;
  String? get language;
  String? get selectedTier;
  @JsonKey(name: 'completed_at')
  DateTime? get completedAt;

  /// Create a copy of OnboardingData
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $OnboardingDataCopyWith<OnboardingData> get copyWith =>
      _$OnboardingDataCopyWithImpl<OnboardingData>(
          this as OnboardingData, _$identity);

  /// Serializes this OnboardingData to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is OnboardingData &&
            (identical(other.niche, niche) || other.niche == niche) &&
            const DeepCollectionEquality().equals(other.goals, goals) &&
            (identical(other.language, language) ||
                other.language == language) &&
            (identical(other.selectedTier, selectedTier) ||
                other.selectedTier == selectedTier) &&
            (identical(other.completedAt, completedAt) ||
                other.completedAt == completedAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      niche,
      const DeepCollectionEquality().hash(goals),
      language,
      selectedTier,
      completedAt);

  @override
  String toString() {
    return 'OnboardingData(niche: $niche, goals: $goals, language: $language, selectedTier: $selectedTier, completedAt: $completedAt)';
  }
}

/// @nodoc
abstract mixin class $OnboardingDataCopyWith<$Res> {
  factory $OnboardingDataCopyWith(
          OnboardingData value, $Res Function(OnboardingData) _then) =
      _$OnboardingDataCopyWithImpl;
  @useResult
  $Res call(
      {String? niche,
      List<String> goals,
      String? language,
      String? selectedTier,
      @JsonKey(name: 'completed_at') DateTime? completedAt});
}

/// @nodoc
class _$OnboardingDataCopyWithImpl<$Res>
    implements $OnboardingDataCopyWith<$Res> {
  _$OnboardingDataCopyWithImpl(this._self, this._then);

  final OnboardingData _self;
  final $Res Function(OnboardingData) _then;

  /// Create a copy of OnboardingData
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? niche = freezed,
    Object? goals = null,
    Object? language = freezed,
    Object? selectedTier = freezed,
    Object? completedAt = freezed,
  }) {
    return _then(_self.copyWith(
      niche: freezed == niche
          ? _self.niche
          : niche // ignore: cast_nullable_to_non_nullable
              as String?,
      goals: null == goals
          ? _self.goals
          : goals // ignore: cast_nullable_to_non_nullable
              as List<String>,
      language: freezed == language
          ? _self.language
          : language // ignore: cast_nullable_to_non_nullable
              as String?,
      selectedTier: freezed == selectedTier
          ? _self.selectedTier
          : selectedTier // ignore: cast_nullable_to_non_nullable
              as String?,
      completedAt: freezed == completedAt
          ? _self.completedAt
          : completedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ));
  }
}

/// Adds pattern-matching-related methods to [OnboardingData].
extension OnboardingDataPatterns on OnboardingData {
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
    TResult Function(_OnboardingData value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _OnboardingData() when $default != null:
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
    TResult Function(_OnboardingData value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _OnboardingData():
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
    TResult? Function(_OnboardingData value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _OnboardingData() when $default != null:
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
            String? niche,
            List<String> goals,
            String? language,
            String? selectedTier,
            @JsonKey(name: 'completed_at') DateTime? completedAt)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _OnboardingData() when $default != null:
        return $default(_that.niche, _that.goals, _that.language,
            _that.selectedTier, _that.completedAt);
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
            String? niche,
            List<String> goals,
            String? language,
            String? selectedTier,
            @JsonKey(name: 'completed_at') DateTime? completedAt)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _OnboardingData():
        return $default(_that.niche, _that.goals, _that.language,
            _that.selectedTier, _that.completedAt);
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
            String? niche,
            List<String> goals,
            String? language,
            String? selectedTier,
            @JsonKey(name: 'completed_at') DateTime? completedAt)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _OnboardingData() when $default != null:
        return $default(_that.niche, _that.goals, _that.language,
            _that.selectedTier, _that.completedAt);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _OnboardingData implements OnboardingData {
  const _OnboardingData(
      {this.niche,
      final List<String> goals = const <String>[],
      this.language,
      this.selectedTier,
      @JsonKey(name: 'completed_at') this.completedAt})
      : _goals = goals;
  factory _OnboardingData.fromJson(Map<String, dynamic> json) =>
      _$OnboardingDataFromJson(json);

  @override
  final String? niche;
  final List<String> _goals;
  @override
  @JsonKey()
  List<String> get goals {
    if (_goals is EqualUnmodifiableListView) return _goals;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_goals);
  }

  @override
  final String? language;
  @override
  final String? selectedTier;
  @override
  @JsonKey(name: 'completed_at')
  final DateTime? completedAt;

  /// Create a copy of OnboardingData
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$OnboardingDataCopyWith<_OnboardingData> get copyWith =>
      __$OnboardingDataCopyWithImpl<_OnboardingData>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$OnboardingDataToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _OnboardingData &&
            (identical(other.niche, niche) || other.niche == niche) &&
            const DeepCollectionEquality().equals(other._goals, _goals) &&
            (identical(other.language, language) ||
                other.language == language) &&
            (identical(other.selectedTier, selectedTier) ||
                other.selectedTier == selectedTier) &&
            (identical(other.completedAt, completedAt) ||
                other.completedAt == completedAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      niche,
      const DeepCollectionEquality().hash(_goals),
      language,
      selectedTier,
      completedAt);

  @override
  String toString() {
    return 'OnboardingData(niche: $niche, goals: $goals, language: $language, selectedTier: $selectedTier, completedAt: $completedAt)';
  }
}

/// @nodoc
abstract mixin class _$OnboardingDataCopyWith<$Res>
    implements $OnboardingDataCopyWith<$Res> {
  factory _$OnboardingDataCopyWith(
          _OnboardingData value, $Res Function(_OnboardingData) _then) =
      __$OnboardingDataCopyWithImpl;
  @override
  @useResult
  $Res call(
      {String? niche,
      List<String> goals,
      String? language,
      String? selectedTier,
      @JsonKey(name: 'completed_at') DateTime? completedAt});
}

/// @nodoc
class __$OnboardingDataCopyWithImpl<$Res>
    implements _$OnboardingDataCopyWith<$Res> {
  __$OnboardingDataCopyWithImpl(this._self, this._then);

  final _OnboardingData _self;
  final $Res Function(_OnboardingData) _then;

  /// Create a copy of OnboardingData
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? niche = freezed,
    Object? goals = null,
    Object? language = freezed,
    Object? selectedTier = freezed,
    Object? completedAt = freezed,
  }) {
    return _then(_OnboardingData(
      niche: freezed == niche
          ? _self.niche
          : niche // ignore: cast_nullable_to_non_nullable
              as String?,
      goals: null == goals
          ? _self._goals
          : goals // ignore: cast_nullable_to_non_nullable
              as List<String>,
      language: freezed == language
          ? _self.language
          : language // ignore: cast_nullable_to_non_nullable
              as String?,
      selectedTier: freezed == selectedTier
          ? _self.selectedTier
          : selectedTier // ignore: cast_nullable_to_non_nullable
              as String?,
      completedAt: freezed == completedAt
          ? _self.completedAt
          : completedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ));
  }
}

// dart format on
