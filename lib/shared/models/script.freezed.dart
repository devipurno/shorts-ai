// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'script.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$Script {
  String get id;
  @JsonKey(name: 'project_id')
  String get projectId;
  String get content;
  @JsonKey(name: 'hook_options')
  List<HookOption> get hookOptions;
  @JsonKey(name: 'selected_hook_id')
  String? get selectedHookId;
  String get language;
  @JsonKey(name: 'duration_estimate')
  int get durationEstimate;
  @JsonKey(name: 'ai_model_used')
  String get aiModelUsed;
  @JsonKey(name: 'generated_at')
  DateTime get generatedAt;

  /// Create a copy of Script
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $ScriptCopyWith<Script> get copyWith =>
      _$ScriptCopyWithImpl<Script>(this as Script, _$identity);

  /// Serializes this Script to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is Script &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.projectId, projectId) ||
                other.projectId == projectId) &&
            (identical(other.content, content) || other.content == content) &&
            const DeepCollectionEquality()
                .equals(other.hookOptions, hookOptions) &&
            (identical(other.selectedHookId, selectedHookId) ||
                other.selectedHookId == selectedHookId) &&
            (identical(other.language, language) ||
                other.language == language) &&
            (identical(other.durationEstimate, durationEstimate) ||
                other.durationEstimate == durationEstimate) &&
            (identical(other.aiModelUsed, aiModelUsed) ||
                other.aiModelUsed == aiModelUsed) &&
            (identical(other.generatedAt, generatedAt) ||
                other.generatedAt == generatedAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      projectId,
      content,
      const DeepCollectionEquality().hash(hookOptions),
      selectedHookId,
      language,
      durationEstimate,
      aiModelUsed,
      generatedAt);

  @override
  String toString() {
    return 'Script(id: $id, projectId: $projectId, content: $content, hookOptions: $hookOptions, selectedHookId: $selectedHookId, language: $language, durationEstimate: $durationEstimate, aiModelUsed: $aiModelUsed, generatedAt: $generatedAt)';
  }
}

/// @nodoc
abstract mixin class $ScriptCopyWith<$Res> {
  factory $ScriptCopyWith(Script value, $Res Function(Script) _then) =
      _$ScriptCopyWithImpl;
  @useResult
  $Res call(
      {String id,
      @JsonKey(name: 'project_id') String projectId,
      String content,
      @JsonKey(name: 'hook_options') List<HookOption> hookOptions,
      @JsonKey(name: 'selected_hook_id') String? selectedHookId,
      String language,
      @JsonKey(name: 'duration_estimate') int durationEstimate,
      @JsonKey(name: 'ai_model_used') String aiModelUsed,
      @JsonKey(name: 'generated_at') DateTime generatedAt});
}

/// @nodoc
class _$ScriptCopyWithImpl<$Res> implements $ScriptCopyWith<$Res> {
  _$ScriptCopyWithImpl(this._self, this._then);

  final Script _self;
  final $Res Function(Script) _then;

  /// Create a copy of Script
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? projectId = null,
    Object? content = null,
    Object? hookOptions = null,
    Object? selectedHookId = freezed,
    Object? language = null,
    Object? durationEstimate = null,
    Object? aiModelUsed = null,
    Object? generatedAt = null,
  }) {
    return _then(_self.copyWith(
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      projectId: null == projectId
          ? _self.projectId
          : projectId // ignore: cast_nullable_to_non_nullable
              as String,
      content: null == content
          ? _self.content
          : content // ignore: cast_nullable_to_non_nullable
              as String,
      hookOptions: null == hookOptions
          ? _self.hookOptions
          : hookOptions // ignore: cast_nullable_to_non_nullable
              as List<HookOption>,
      selectedHookId: freezed == selectedHookId
          ? _self.selectedHookId
          : selectedHookId // ignore: cast_nullable_to_non_nullable
              as String?,
      language: null == language
          ? _self.language
          : language // ignore: cast_nullable_to_non_nullable
              as String,
      durationEstimate: null == durationEstimate
          ? _self.durationEstimate
          : durationEstimate // ignore: cast_nullable_to_non_nullable
              as int,
      aiModelUsed: null == aiModelUsed
          ? _self.aiModelUsed
          : aiModelUsed // ignore: cast_nullable_to_non_nullable
              as String,
      generatedAt: null == generatedAt
          ? _self.generatedAt
          : generatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ));
  }
}

/// Adds pattern-matching-related methods to [Script].
extension ScriptPatterns on Script {
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
    TResult Function(_Script value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _Script() when $default != null:
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
    TResult Function(_Script value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _Script():
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
    TResult? Function(_Script value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _Script() when $default != null:
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
            @JsonKey(name: 'project_id') String projectId,
            String content,
            @JsonKey(name: 'hook_options') List<HookOption> hookOptions,
            @JsonKey(name: 'selected_hook_id') String? selectedHookId,
            String language,
            @JsonKey(name: 'duration_estimate') int durationEstimate,
            @JsonKey(name: 'ai_model_used') String aiModelUsed,
            @JsonKey(name: 'generated_at') DateTime generatedAt)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _Script() when $default != null:
        return $default(
            _that.id,
            _that.projectId,
            _that.content,
            _that.hookOptions,
            _that.selectedHookId,
            _that.language,
            _that.durationEstimate,
            _that.aiModelUsed,
            _that.generatedAt);
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
            @JsonKey(name: 'project_id') String projectId,
            String content,
            @JsonKey(name: 'hook_options') List<HookOption> hookOptions,
            @JsonKey(name: 'selected_hook_id') String? selectedHookId,
            String language,
            @JsonKey(name: 'duration_estimate') int durationEstimate,
            @JsonKey(name: 'ai_model_used') String aiModelUsed,
            @JsonKey(name: 'generated_at') DateTime generatedAt)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _Script():
        return $default(
            _that.id,
            _that.projectId,
            _that.content,
            _that.hookOptions,
            _that.selectedHookId,
            _that.language,
            _that.durationEstimate,
            _that.aiModelUsed,
            _that.generatedAt);
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
            @JsonKey(name: 'project_id') String projectId,
            String content,
            @JsonKey(name: 'hook_options') List<HookOption> hookOptions,
            @JsonKey(name: 'selected_hook_id') String? selectedHookId,
            String language,
            @JsonKey(name: 'duration_estimate') int durationEstimate,
            @JsonKey(name: 'ai_model_used') String aiModelUsed,
            @JsonKey(name: 'generated_at') DateTime generatedAt)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _Script() when $default != null:
        return $default(
            _that.id,
            _that.projectId,
            _that.content,
            _that.hookOptions,
            _that.selectedHookId,
            _that.language,
            _that.durationEstimate,
            _that.aiModelUsed,
            _that.generatedAt);
      case _:
        return null;
    }
  }
}

/// @nodoc

@JsonSerializable(explicitToJson: true)
class _Script implements Script {
  const _Script(
      {required this.id,
      @JsonKey(name: 'project_id') required this.projectId,
      this.content = '',
      @JsonKey(name: 'hook_options')
      final List<HookOption> hookOptions = const <HookOption>[],
      @JsonKey(name: 'selected_hook_id') this.selectedHookId,
      this.language = 'id',
      @JsonKey(name: 'duration_estimate') this.durationEstimate = 0,
      @JsonKey(name: 'ai_model_used') this.aiModelUsed = '',
      @JsonKey(name: 'generated_at') required this.generatedAt})
      : _hookOptions = hookOptions;
  factory _Script.fromJson(Map<String, dynamic> json) => _$ScriptFromJson(json);

  @override
  final String id;
  @override
  @JsonKey(name: 'project_id')
  final String projectId;
  @override
  @JsonKey()
  final String content;
  final List<HookOption> _hookOptions;
  @override
  @JsonKey(name: 'hook_options')
  List<HookOption> get hookOptions {
    if (_hookOptions is EqualUnmodifiableListView) return _hookOptions;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_hookOptions);
  }

  @override
  @JsonKey(name: 'selected_hook_id')
  final String? selectedHookId;
  @override
  @JsonKey()
  final String language;
  @override
  @JsonKey(name: 'duration_estimate')
  final int durationEstimate;
  @override
  @JsonKey(name: 'ai_model_used')
  final String aiModelUsed;
  @override
  @JsonKey(name: 'generated_at')
  final DateTime generatedAt;

  /// Create a copy of Script
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$ScriptCopyWith<_Script> get copyWith =>
      __$ScriptCopyWithImpl<_Script>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$ScriptToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _Script &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.projectId, projectId) ||
                other.projectId == projectId) &&
            (identical(other.content, content) || other.content == content) &&
            const DeepCollectionEquality()
                .equals(other._hookOptions, _hookOptions) &&
            (identical(other.selectedHookId, selectedHookId) ||
                other.selectedHookId == selectedHookId) &&
            (identical(other.language, language) ||
                other.language == language) &&
            (identical(other.durationEstimate, durationEstimate) ||
                other.durationEstimate == durationEstimate) &&
            (identical(other.aiModelUsed, aiModelUsed) ||
                other.aiModelUsed == aiModelUsed) &&
            (identical(other.generatedAt, generatedAt) ||
                other.generatedAt == generatedAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      projectId,
      content,
      const DeepCollectionEquality().hash(_hookOptions),
      selectedHookId,
      language,
      durationEstimate,
      aiModelUsed,
      generatedAt);

  @override
  String toString() {
    return 'Script(id: $id, projectId: $projectId, content: $content, hookOptions: $hookOptions, selectedHookId: $selectedHookId, language: $language, durationEstimate: $durationEstimate, aiModelUsed: $aiModelUsed, generatedAt: $generatedAt)';
  }
}

/// @nodoc
abstract mixin class _$ScriptCopyWith<$Res> implements $ScriptCopyWith<$Res> {
  factory _$ScriptCopyWith(_Script value, $Res Function(_Script) _then) =
      __$ScriptCopyWithImpl;
  @override
  @useResult
  $Res call(
      {String id,
      @JsonKey(name: 'project_id') String projectId,
      String content,
      @JsonKey(name: 'hook_options') List<HookOption> hookOptions,
      @JsonKey(name: 'selected_hook_id') String? selectedHookId,
      String language,
      @JsonKey(name: 'duration_estimate') int durationEstimate,
      @JsonKey(name: 'ai_model_used') String aiModelUsed,
      @JsonKey(name: 'generated_at') DateTime generatedAt});
}

/// @nodoc
class __$ScriptCopyWithImpl<$Res> implements _$ScriptCopyWith<$Res> {
  __$ScriptCopyWithImpl(this._self, this._then);

  final _Script _self;
  final $Res Function(_Script) _then;

  /// Create a copy of Script
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? id = null,
    Object? projectId = null,
    Object? content = null,
    Object? hookOptions = null,
    Object? selectedHookId = freezed,
    Object? language = null,
    Object? durationEstimate = null,
    Object? aiModelUsed = null,
    Object? generatedAt = null,
  }) {
    return _then(_Script(
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      projectId: null == projectId
          ? _self.projectId
          : projectId // ignore: cast_nullable_to_non_nullable
              as String,
      content: null == content
          ? _self.content
          : content // ignore: cast_nullable_to_non_nullable
              as String,
      hookOptions: null == hookOptions
          ? _self._hookOptions
          : hookOptions // ignore: cast_nullable_to_non_nullable
              as List<HookOption>,
      selectedHookId: freezed == selectedHookId
          ? _self.selectedHookId
          : selectedHookId // ignore: cast_nullable_to_non_nullable
              as String?,
      language: null == language
          ? _self.language
          : language // ignore: cast_nullable_to_non_nullable
              as String,
      durationEstimate: null == durationEstimate
          ? _self.durationEstimate
          : durationEstimate // ignore: cast_nullable_to_non_nullable
              as int,
      aiModelUsed: null == aiModelUsed
          ? _self.aiModelUsed
          : aiModelUsed // ignore: cast_nullable_to_non_nullable
              as String,
      generatedAt: null == generatedAt
          ? _self.generatedAt
          : generatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ));
  }
}

/// @nodoc
mixin _$HookOption {
  String get id;
  String get text;
  HookStyle get style;
  double get score;

  /// Create a copy of HookOption
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $HookOptionCopyWith<HookOption> get copyWith =>
      _$HookOptionCopyWithImpl<HookOption>(this as HookOption, _$identity);

  /// Serializes this HookOption to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is HookOption &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.text, text) || other.text == text) &&
            (identical(other.style, style) || other.style == style) &&
            (identical(other.score, score) || other.score == score));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, text, style, score);

  @override
  String toString() {
    return 'HookOption(id: $id, text: $text, style: $style, score: $score)';
  }
}

/// @nodoc
abstract mixin class $HookOptionCopyWith<$Res> {
  factory $HookOptionCopyWith(
          HookOption value, $Res Function(HookOption) _then) =
      _$HookOptionCopyWithImpl;
  @useResult
  $Res call({String id, String text, HookStyle style, double score});
}

/// @nodoc
class _$HookOptionCopyWithImpl<$Res> implements $HookOptionCopyWith<$Res> {
  _$HookOptionCopyWithImpl(this._self, this._then);

  final HookOption _self;
  final $Res Function(HookOption) _then;

  /// Create a copy of HookOption
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? text = null,
    Object? style = null,
    Object? score = null,
  }) {
    return _then(_self.copyWith(
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      text: null == text
          ? _self.text
          : text // ignore: cast_nullable_to_non_nullable
              as String,
      style: null == style
          ? _self.style
          : style // ignore: cast_nullable_to_non_nullable
              as HookStyle,
      score: null == score
          ? _self.score
          : score // ignore: cast_nullable_to_non_nullable
              as double,
    ));
  }
}

/// Adds pattern-matching-related methods to [HookOption].
extension HookOptionPatterns on HookOption {
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
    TResult Function(_HookOption value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _HookOption() when $default != null:
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
    TResult Function(_HookOption value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _HookOption():
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
    TResult? Function(_HookOption value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _HookOption() when $default != null:
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
    TResult Function(String id, String text, HookStyle style, double score)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _HookOption() when $default != null:
        return $default(_that.id, _that.text, _that.style, _that.score);
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
    TResult Function(String id, String text, HookStyle style, double score)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _HookOption():
        return $default(_that.id, _that.text, _that.style, _that.score);
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
    TResult? Function(String id, String text, HookStyle style, double score)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _HookOption() when $default != null:
        return $default(_that.id, _that.text, _that.style, _that.score);
      case _:
        return null;
    }
  }
}

/// @nodoc

@JsonSerializable(explicitToJson: true)
class _HookOption implements HookOption {
  const _HookOption(
      {required this.id,
      this.text = '',
      this.style = HookStyle.statement,
      this.score = 0});
  factory _HookOption.fromJson(Map<String, dynamic> json) =>
      _$HookOptionFromJson(json);

  @override
  final String id;
  @override
  @JsonKey()
  final String text;
  @override
  @JsonKey()
  final HookStyle style;
  @override
  @JsonKey()
  final double score;

  /// Create a copy of HookOption
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$HookOptionCopyWith<_HookOption> get copyWith =>
      __$HookOptionCopyWithImpl<_HookOption>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$HookOptionToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _HookOption &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.text, text) || other.text == text) &&
            (identical(other.style, style) || other.style == style) &&
            (identical(other.score, score) || other.score == score));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, text, style, score);

  @override
  String toString() {
    return 'HookOption(id: $id, text: $text, style: $style, score: $score)';
  }
}

/// @nodoc
abstract mixin class _$HookOptionCopyWith<$Res>
    implements $HookOptionCopyWith<$Res> {
  factory _$HookOptionCopyWith(
          _HookOption value, $Res Function(_HookOption) _then) =
      __$HookOptionCopyWithImpl;
  @override
  @useResult
  $Res call({String id, String text, HookStyle style, double score});
}

/// @nodoc
class __$HookOptionCopyWithImpl<$Res> implements _$HookOptionCopyWith<$Res> {
  __$HookOptionCopyWithImpl(this._self, this._then);

  final _HookOption _self;
  final $Res Function(_HookOption) _then;

  /// Create a copy of HookOption
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? id = null,
    Object? text = null,
    Object? style = null,
    Object? score = null,
  }) {
    return _then(_HookOption(
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      text: null == text
          ? _self.text
          : text // ignore: cast_nullable_to_non_nullable
              as String,
      style: null == style
          ? _self.style
          : style // ignore: cast_nullable_to_non_nullable
              as HookStyle,
      score: null == score
          ? _self.score
          : score // ignore: cast_nullable_to_non_nullable
              as double,
    ));
  }
}

// dart format on
