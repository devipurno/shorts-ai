// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'hook_provider.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$HookGeneratorState {
  String get topic;
  List<HookStyle> get styles;
  String get niche;
  HookLanguage get language;
  String get customStylePrompt;
  bool get isGenerating;
  List<HookOption> get results;
  List<HookOption> get favoriteHooks;
  int get generationsToday;
  DateTime? get generationDay;
  String? get copiedHookId;
  String? get usedHookId;
  String? get errorMessage;
  bool get upgradePromptVisible;

  /// Create a copy of HookGeneratorState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $HookGeneratorStateCopyWith<HookGeneratorState> get copyWith =>
      _$HookGeneratorStateCopyWithImpl<HookGeneratorState>(
          this as HookGeneratorState, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is HookGeneratorState &&
            (identical(other.topic, topic) || other.topic == topic) &&
            const DeepCollectionEquality().equals(other.styles, styles) &&
            (identical(other.niche, niche) || other.niche == niche) &&
            (identical(other.language, language) ||
                other.language == language) &&
            (identical(other.customStylePrompt, customStylePrompt) ||
                other.customStylePrompt == customStylePrompt) &&
            (identical(other.isGenerating, isGenerating) ||
                other.isGenerating == isGenerating) &&
            const DeepCollectionEquality().equals(other.results, results) &&
            const DeepCollectionEquality()
                .equals(other.favoriteHooks, favoriteHooks) &&
            (identical(other.generationsToday, generationsToday) ||
                other.generationsToday == generationsToday) &&
            (identical(other.generationDay, generationDay) ||
                other.generationDay == generationDay) &&
            (identical(other.copiedHookId, copiedHookId) ||
                other.copiedHookId == copiedHookId) &&
            (identical(other.usedHookId, usedHookId) ||
                other.usedHookId == usedHookId) &&
            (identical(other.errorMessage, errorMessage) ||
                other.errorMessage == errorMessage) &&
            (identical(other.upgradePromptVisible, upgradePromptVisible) ||
                other.upgradePromptVisible == upgradePromptVisible));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      topic,
      const DeepCollectionEquality().hash(styles),
      niche,
      language,
      customStylePrompt,
      isGenerating,
      const DeepCollectionEquality().hash(results),
      const DeepCollectionEquality().hash(favoriteHooks),
      generationsToday,
      generationDay,
      copiedHookId,
      usedHookId,
      errorMessage,
      upgradePromptVisible);

  @override
  String toString() {
    return 'HookGeneratorState(topic: $topic, styles: $styles, niche: $niche, language: $language, customStylePrompt: $customStylePrompt, isGenerating: $isGenerating, results: $results, favoriteHooks: $favoriteHooks, generationsToday: $generationsToday, generationDay: $generationDay, copiedHookId: $copiedHookId, usedHookId: $usedHookId, errorMessage: $errorMessage, upgradePromptVisible: $upgradePromptVisible)';
  }
}

/// @nodoc
abstract mixin class $HookGeneratorStateCopyWith<$Res> {
  factory $HookGeneratorStateCopyWith(
          HookGeneratorState value, $Res Function(HookGeneratorState) _then) =
      _$HookGeneratorStateCopyWithImpl;
  @useResult
  $Res call(
      {String topic,
      List<HookStyle> styles,
      String niche,
      HookLanguage language,
      String customStylePrompt,
      bool isGenerating,
      List<HookOption> results,
      List<HookOption> favoriteHooks,
      int generationsToday,
      DateTime? generationDay,
      String? copiedHookId,
      String? usedHookId,
      String? errorMessage,
      bool upgradePromptVisible});
}

/// @nodoc
class _$HookGeneratorStateCopyWithImpl<$Res>
    implements $HookGeneratorStateCopyWith<$Res> {
  _$HookGeneratorStateCopyWithImpl(this._self, this._then);

  final HookGeneratorState _self;
  final $Res Function(HookGeneratorState) _then;

  /// Create a copy of HookGeneratorState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? topic = null,
    Object? styles = null,
    Object? niche = null,
    Object? language = null,
    Object? customStylePrompt = null,
    Object? isGenerating = null,
    Object? results = null,
    Object? favoriteHooks = null,
    Object? generationsToday = null,
    Object? generationDay = freezed,
    Object? copiedHookId = freezed,
    Object? usedHookId = freezed,
    Object? errorMessage = freezed,
    Object? upgradePromptVisible = null,
  }) {
    return _then(_self.copyWith(
      topic: null == topic
          ? _self.topic
          : topic // ignore: cast_nullable_to_non_nullable
              as String,
      styles: null == styles
          ? _self.styles
          : styles // ignore: cast_nullable_to_non_nullable
              as List<HookStyle>,
      niche: null == niche
          ? _self.niche
          : niche // ignore: cast_nullable_to_non_nullable
              as String,
      language: null == language
          ? _self.language
          : language // ignore: cast_nullable_to_non_nullable
              as HookLanguage,
      customStylePrompt: null == customStylePrompt
          ? _self.customStylePrompt
          : customStylePrompt // ignore: cast_nullable_to_non_nullable
              as String,
      isGenerating: null == isGenerating
          ? _self.isGenerating
          : isGenerating // ignore: cast_nullable_to_non_nullable
              as bool,
      results: null == results
          ? _self.results
          : results // ignore: cast_nullable_to_non_nullable
              as List<HookOption>,
      favoriteHooks: null == favoriteHooks
          ? _self.favoriteHooks
          : favoriteHooks // ignore: cast_nullable_to_non_nullable
              as List<HookOption>,
      generationsToday: null == generationsToday
          ? _self.generationsToday
          : generationsToday // ignore: cast_nullable_to_non_nullable
              as int,
      generationDay: freezed == generationDay
          ? _self.generationDay
          : generationDay // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      copiedHookId: freezed == copiedHookId
          ? _self.copiedHookId
          : copiedHookId // ignore: cast_nullable_to_non_nullable
              as String?,
      usedHookId: freezed == usedHookId
          ? _self.usedHookId
          : usedHookId // ignore: cast_nullable_to_non_nullable
              as String?,
      errorMessage: freezed == errorMessage
          ? _self.errorMessage
          : errorMessage // ignore: cast_nullable_to_non_nullable
              as String?,
      upgradePromptVisible: null == upgradePromptVisible
          ? _self.upgradePromptVisible
          : upgradePromptVisible // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// Adds pattern-matching-related methods to [HookGeneratorState].
extension HookGeneratorStatePatterns on HookGeneratorState {
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
    TResult Function(_HookGeneratorState value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _HookGeneratorState() when $default != null:
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
    TResult Function(_HookGeneratorState value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _HookGeneratorState():
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
    TResult? Function(_HookGeneratorState value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _HookGeneratorState() when $default != null:
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
            String topic,
            List<HookStyle> styles,
            String niche,
            HookLanguage language,
            String customStylePrompt,
            bool isGenerating,
            List<HookOption> results,
            List<HookOption> favoriteHooks,
            int generationsToday,
            DateTime? generationDay,
            String? copiedHookId,
            String? usedHookId,
            String? errorMessage,
            bool upgradePromptVisible)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _HookGeneratorState() when $default != null:
        return $default(
            _that.topic,
            _that.styles,
            _that.niche,
            _that.language,
            _that.customStylePrompt,
            _that.isGenerating,
            _that.results,
            _that.favoriteHooks,
            _that.generationsToday,
            _that.generationDay,
            _that.copiedHookId,
            _that.usedHookId,
            _that.errorMessage,
            _that.upgradePromptVisible);
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
            String topic,
            List<HookStyle> styles,
            String niche,
            HookLanguage language,
            String customStylePrompt,
            bool isGenerating,
            List<HookOption> results,
            List<HookOption> favoriteHooks,
            int generationsToday,
            DateTime? generationDay,
            String? copiedHookId,
            String? usedHookId,
            String? errorMessage,
            bool upgradePromptVisible)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _HookGeneratorState():
        return $default(
            _that.topic,
            _that.styles,
            _that.niche,
            _that.language,
            _that.customStylePrompt,
            _that.isGenerating,
            _that.results,
            _that.favoriteHooks,
            _that.generationsToday,
            _that.generationDay,
            _that.copiedHookId,
            _that.usedHookId,
            _that.errorMessage,
            _that.upgradePromptVisible);
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
            String topic,
            List<HookStyle> styles,
            String niche,
            HookLanguage language,
            String customStylePrompt,
            bool isGenerating,
            List<HookOption> results,
            List<HookOption> favoriteHooks,
            int generationsToday,
            DateTime? generationDay,
            String? copiedHookId,
            String? usedHookId,
            String? errorMessage,
            bool upgradePromptVisible)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _HookGeneratorState() when $default != null:
        return $default(
            _that.topic,
            _that.styles,
            _that.niche,
            _that.language,
            _that.customStylePrompt,
            _that.isGenerating,
            _that.results,
            _that.favoriteHooks,
            _that.generationsToday,
            _that.generationDay,
            _that.copiedHookId,
            _that.usedHookId,
            _that.errorMessage,
            _that.upgradePromptVisible);
      case _:
        return null;
    }
  }
}

/// @nodoc

class _HookGeneratorState implements HookGeneratorState {
  const _HookGeneratorState(
      {this.topic = '',
      final List<HookStyle> styles = const <HookStyle>[],
      this.niche = 'Lifestyle',
      this.language = HookLanguage.id,
      this.customStylePrompt = '',
      this.isGenerating = false,
      final List<HookOption> results = const <HookOption>[],
      final List<HookOption> favoriteHooks = const <HookOption>[],
      this.generationsToday = 0,
      this.generationDay,
      this.copiedHookId,
      this.usedHookId,
      this.errorMessage,
      this.upgradePromptVisible = false})
      : _styles = styles,
        _results = results,
        _favoriteHooks = favoriteHooks;

  @override
  @JsonKey()
  final String topic;
  final List<HookStyle> _styles;
  @override
  @JsonKey()
  List<HookStyle> get styles {
    if (_styles is EqualUnmodifiableListView) return _styles;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_styles);
  }

  @override
  @JsonKey()
  final String niche;
  @override
  @JsonKey()
  final HookLanguage language;
  @override
  @JsonKey()
  final String customStylePrompt;
  @override
  @JsonKey()
  final bool isGenerating;
  final List<HookOption> _results;
  @override
  @JsonKey()
  List<HookOption> get results {
    if (_results is EqualUnmodifiableListView) return _results;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_results);
  }

  final List<HookOption> _favoriteHooks;
  @override
  @JsonKey()
  List<HookOption> get favoriteHooks {
    if (_favoriteHooks is EqualUnmodifiableListView) return _favoriteHooks;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_favoriteHooks);
  }

  @override
  @JsonKey()
  final int generationsToday;
  @override
  final DateTime? generationDay;
  @override
  final String? copiedHookId;
  @override
  final String? usedHookId;
  @override
  final String? errorMessage;
  @override
  @JsonKey()
  final bool upgradePromptVisible;

  /// Create a copy of HookGeneratorState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$HookGeneratorStateCopyWith<_HookGeneratorState> get copyWith =>
      __$HookGeneratorStateCopyWithImpl<_HookGeneratorState>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _HookGeneratorState &&
            (identical(other.topic, topic) || other.topic == topic) &&
            const DeepCollectionEquality().equals(other._styles, _styles) &&
            (identical(other.niche, niche) || other.niche == niche) &&
            (identical(other.language, language) ||
                other.language == language) &&
            (identical(other.customStylePrompt, customStylePrompt) ||
                other.customStylePrompt == customStylePrompt) &&
            (identical(other.isGenerating, isGenerating) ||
                other.isGenerating == isGenerating) &&
            const DeepCollectionEquality().equals(other._results, _results) &&
            const DeepCollectionEquality()
                .equals(other._favoriteHooks, _favoriteHooks) &&
            (identical(other.generationsToday, generationsToday) ||
                other.generationsToday == generationsToday) &&
            (identical(other.generationDay, generationDay) ||
                other.generationDay == generationDay) &&
            (identical(other.copiedHookId, copiedHookId) ||
                other.copiedHookId == copiedHookId) &&
            (identical(other.usedHookId, usedHookId) ||
                other.usedHookId == usedHookId) &&
            (identical(other.errorMessage, errorMessage) ||
                other.errorMessage == errorMessage) &&
            (identical(other.upgradePromptVisible, upgradePromptVisible) ||
                other.upgradePromptVisible == upgradePromptVisible));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      topic,
      const DeepCollectionEquality().hash(_styles),
      niche,
      language,
      customStylePrompt,
      isGenerating,
      const DeepCollectionEquality().hash(_results),
      const DeepCollectionEquality().hash(_favoriteHooks),
      generationsToday,
      generationDay,
      copiedHookId,
      usedHookId,
      errorMessage,
      upgradePromptVisible);

  @override
  String toString() {
    return 'HookGeneratorState(topic: $topic, styles: $styles, niche: $niche, language: $language, customStylePrompt: $customStylePrompt, isGenerating: $isGenerating, results: $results, favoriteHooks: $favoriteHooks, generationsToday: $generationsToday, generationDay: $generationDay, copiedHookId: $copiedHookId, usedHookId: $usedHookId, errorMessage: $errorMessage, upgradePromptVisible: $upgradePromptVisible)';
  }
}

/// @nodoc
abstract mixin class _$HookGeneratorStateCopyWith<$Res>
    implements $HookGeneratorStateCopyWith<$Res> {
  factory _$HookGeneratorStateCopyWith(
          _HookGeneratorState value, $Res Function(_HookGeneratorState) _then) =
      __$HookGeneratorStateCopyWithImpl;
  @override
  @useResult
  $Res call(
      {String topic,
      List<HookStyle> styles,
      String niche,
      HookLanguage language,
      String customStylePrompt,
      bool isGenerating,
      List<HookOption> results,
      List<HookOption> favoriteHooks,
      int generationsToday,
      DateTime? generationDay,
      String? copiedHookId,
      String? usedHookId,
      String? errorMessage,
      bool upgradePromptVisible});
}

/// @nodoc
class __$HookGeneratorStateCopyWithImpl<$Res>
    implements _$HookGeneratorStateCopyWith<$Res> {
  __$HookGeneratorStateCopyWithImpl(this._self, this._then);

  final _HookGeneratorState _self;
  final $Res Function(_HookGeneratorState) _then;

  /// Create a copy of HookGeneratorState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? topic = null,
    Object? styles = null,
    Object? niche = null,
    Object? language = null,
    Object? customStylePrompt = null,
    Object? isGenerating = null,
    Object? results = null,
    Object? favoriteHooks = null,
    Object? generationsToday = null,
    Object? generationDay = freezed,
    Object? copiedHookId = freezed,
    Object? usedHookId = freezed,
    Object? errorMessage = freezed,
    Object? upgradePromptVisible = null,
  }) {
    return _then(_HookGeneratorState(
      topic: null == topic
          ? _self.topic
          : topic // ignore: cast_nullable_to_non_nullable
              as String,
      styles: null == styles
          ? _self._styles
          : styles // ignore: cast_nullable_to_non_nullable
              as List<HookStyle>,
      niche: null == niche
          ? _self.niche
          : niche // ignore: cast_nullable_to_non_nullable
              as String,
      language: null == language
          ? _self.language
          : language // ignore: cast_nullable_to_non_nullable
              as HookLanguage,
      customStylePrompt: null == customStylePrompt
          ? _self.customStylePrompt
          : customStylePrompt // ignore: cast_nullable_to_non_nullable
              as String,
      isGenerating: null == isGenerating
          ? _self.isGenerating
          : isGenerating // ignore: cast_nullable_to_non_nullable
              as bool,
      results: null == results
          ? _self._results
          : results // ignore: cast_nullable_to_non_nullable
              as List<HookOption>,
      favoriteHooks: null == favoriteHooks
          ? _self._favoriteHooks
          : favoriteHooks // ignore: cast_nullable_to_non_nullable
              as List<HookOption>,
      generationsToday: null == generationsToday
          ? _self.generationsToday
          : generationsToday // ignore: cast_nullable_to_non_nullable
              as int,
      generationDay: freezed == generationDay
          ? _self.generationDay
          : generationDay // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      copiedHookId: freezed == copiedHookId
          ? _self.copiedHookId
          : copiedHookId // ignore: cast_nullable_to_non_nullable
              as String?,
      usedHookId: freezed == usedHookId
          ? _self.usedHookId
          : usedHookId // ignore: cast_nullable_to_non_nullable
              as String?,
      errorMessage: freezed == errorMessage
          ? _self.errorMessage
          : errorMessage // ignore: cast_nullable_to_non_nullable
              as String?,
      upgradePromptVisible: null == upgradePromptVisible
          ? _self.upgradePromptVisible
          : upgradePromptVisible // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

// dart format on
