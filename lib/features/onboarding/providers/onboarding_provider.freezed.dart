// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'onboarding_provider.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$OnboardingState {
  int get currentStep;
  String? get niche;
  List<String> get goals;
  String? get language;
  String? get selectedTier;
  bool get isCompleting;

  /// Create a copy of OnboardingState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $OnboardingStateCopyWith<OnboardingState> get copyWith =>
      _$OnboardingStateCopyWithImpl<OnboardingState>(
          this as OnboardingState, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is OnboardingState &&
            (identical(other.currentStep, currentStep) ||
                other.currentStep == currentStep) &&
            (identical(other.niche, niche) || other.niche == niche) &&
            const DeepCollectionEquality().equals(other.goals, goals) &&
            (identical(other.language, language) ||
                other.language == language) &&
            (identical(other.selectedTier, selectedTier) ||
                other.selectedTier == selectedTier) &&
            (identical(other.isCompleting, isCompleting) ||
                other.isCompleting == isCompleting));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      currentStep,
      niche,
      const DeepCollectionEquality().hash(goals),
      language,
      selectedTier,
      isCompleting);

  @override
  String toString() {
    return 'OnboardingState(currentStep: $currentStep, niche: $niche, goals: $goals, language: $language, selectedTier: $selectedTier, isCompleting: $isCompleting)';
  }
}

/// @nodoc
abstract mixin class $OnboardingStateCopyWith<$Res> {
  factory $OnboardingStateCopyWith(
          OnboardingState value, $Res Function(OnboardingState) _then) =
      _$OnboardingStateCopyWithImpl;
  @useResult
  $Res call(
      {int currentStep,
      String? niche,
      List<String> goals,
      String? language,
      String? selectedTier,
      bool isCompleting});
}

/// @nodoc
class _$OnboardingStateCopyWithImpl<$Res>
    implements $OnboardingStateCopyWith<$Res> {
  _$OnboardingStateCopyWithImpl(this._self, this._then);

  final OnboardingState _self;
  final $Res Function(OnboardingState) _then;

  /// Create a copy of OnboardingState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? currentStep = null,
    Object? niche = freezed,
    Object? goals = null,
    Object? language = freezed,
    Object? selectedTier = freezed,
    Object? isCompleting = null,
  }) {
    return _then(_self.copyWith(
      currentStep: null == currentStep
          ? _self.currentStep
          : currentStep // ignore: cast_nullable_to_non_nullable
              as int,
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
      isCompleting: null == isCompleting
          ? _self.isCompleting
          : isCompleting // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// Adds pattern-matching-related methods to [OnboardingState].
extension OnboardingStatePatterns on OnboardingState {
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
    TResult Function(_OnboardingState value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _OnboardingState() when $default != null:
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
    TResult Function(_OnboardingState value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _OnboardingState():
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
    TResult? Function(_OnboardingState value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _OnboardingState() when $default != null:
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
    TResult Function(int currentStep, String? niche, List<String> goals,
            String? language, String? selectedTier, bool isCompleting)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _OnboardingState() when $default != null:
        return $default(_that.currentStep, _that.niche, _that.goals,
            _that.language, _that.selectedTier, _that.isCompleting);
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
    TResult Function(int currentStep, String? niche, List<String> goals,
            String? language, String? selectedTier, bool isCompleting)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _OnboardingState():
        return $default(_that.currentStep, _that.niche, _that.goals,
            _that.language, _that.selectedTier, _that.isCompleting);
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
    TResult? Function(int currentStep, String? niche, List<String> goals,
            String? language, String? selectedTier, bool isCompleting)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _OnboardingState() when $default != null:
        return $default(_that.currentStep, _that.niche, _that.goals,
            _that.language, _that.selectedTier, _that.isCompleting);
      case _:
        return null;
    }
  }
}

/// @nodoc

class _OnboardingState implements OnboardingState {
  const _OnboardingState(
      {this.currentStep = 0,
      this.niche,
      final List<String> goals = const <String>[],
      this.language,
      this.selectedTier,
      this.isCompleting = false})
      : _goals = goals;

  @override
  @JsonKey()
  final int currentStep;
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
  @JsonKey()
  final bool isCompleting;

  /// Create a copy of OnboardingState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$OnboardingStateCopyWith<_OnboardingState> get copyWith =>
      __$OnboardingStateCopyWithImpl<_OnboardingState>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _OnboardingState &&
            (identical(other.currentStep, currentStep) ||
                other.currentStep == currentStep) &&
            (identical(other.niche, niche) || other.niche == niche) &&
            const DeepCollectionEquality().equals(other._goals, _goals) &&
            (identical(other.language, language) ||
                other.language == language) &&
            (identical(other.selectedTier, selectedTier) ||
                other.selectedTier == selectedTier) &&
            (identical(other.isCompleting, isCompleting) ||
                other.isCompleting == isCompleting));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      currentStep,
      niche,
      const DeepCollectionEquality().hash(_goals),
      language,
      selectedTier,
      isCompleting);

  @override
  String toString() {
    return 'OnboardingState(currentStep: $currentStep, niche: $niche, goals: $goals, language: $language, selectedTier: $selectedTier, isCompleting: $isCompleting)';
  }
}

/// @nodoc
abstract mixin class _$OnboardingStateCopyWith<$Res>
    implements $OnboardingStateCopyWith<$Res> {
  factory _$OnboardingStateCopyWith(
          _OnboardingState value, $Res Function(_OnboardingState) _then) =
      __$OnboardingStateCopyWithImpl;
  @override
  @useResult
  $Res call(
      {int currentStep,
      String? niche,
      List<String> goals,
      String? language,
      String? selectedTier,
      bool isCompleting});
}

/// @nodoc
class __$OnboardingStateCopyWithImpl<$Res>
    implements _$OnboardingStateCopyWith<$Res> {
  __$OnboardingStateCopyWithImpl(this._self, this._then);

  final _OnboardingState _self;
  final $Res Function(_OnboardingState) _then;

  /// Create a copy of OnboardingState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? currentStep = null,
    Object? niche = freezed,
    Object? goals = null,
    Object? language = freezed,
    Object? selectedTier = freezed,
    Object? isCompleting = null,
  }) {
    return _then(_OnboardingState(
      currentStep: null == currentStep
          ? _self.currentStep
          : currentStep // ignore: cast_nullable_to_non_nullable
              as int,
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
      isCompleting: null == isCompleting
          ? _self.isCompleting
          : isCompleting // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

// dart format on
