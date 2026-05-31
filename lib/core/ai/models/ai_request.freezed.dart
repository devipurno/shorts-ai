// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'ai_request.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$LLMRequest {
  String get prompt;
  String? get systemPrompt;
  double get temperature;
  int get maxTokens;
  Map<String, Object?> get metadata;

  /// Create a copy of LLMRequest
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $LLMRequestCopyWith<LLMRequest> get copyWith =>
      _$LLMRequestCopyWithImpl<LLMRequest>(this as LLMRequest, _$identity);

  /// Serializes this LLMRequest to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is LLMRequest &&
            (identical(other.prompt, prompt) || other.prompt == prompt) &&
            (identical(other.systemPrompt, systemPrompt) ||
                other.systemPrompt == systemPrompt) &&
            (identical(other.temperature, temperature) ||
                other.temperature == temperature) &&
            (identical(other.maxTokens, maxTokens) ||
                other.maxTokens == maxTokens) &&
            const DeepCollectionEquality().equals(other.metadata, metadata));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, prompt, systemPrompt,
      temperature, maxTokens, const DeepCollectionEquality().hash(metadata));

  @override
  String toString() {
    return 'LLMRequest(prompt: $prompt, systemPrompt: $systemPrompt, temperature: $temperature, maxTokens: $maxTokens, metadata: $metadata)';
  }
}

/// @nodoc
abstract mixin class $LLMRequestCopyWith<$Res> {
  factory $LLMRequestCopyWith(
          LLMRequest value, $Res Function(LLMRequest) _then) =
      _$LLMRequestCopyWithImpl;
  @useResult
  $Res call(
      {String prompt,
      String? systemPrompt,
      double temperature,
      int maxTokens,
      Map<String, Object?> metadata});
}

/// @nodoc
class _$LLMRequestCopyWithImpl<$Res> implements $LLMRequestCopyWith<$Res> {
  _$LLMRequestCopyWithImpl(this._self, this._then);

  final LLMRequest _self;
  final $Res Function(LLMRequest) _then;

  /// Create a copy of LLMRequest
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? prompt = null,
    Object? systemPrompt = freezed,
    Object? temperature = null,
    Object? maxTokens = null,
    Object? metadata = null,
  }) {
    return _then(_self.copyWith(
      prompt: null == prompt
          ? _self.prompt
          : prompt // ignore: cast_nullable_to_non_nullable
              as String,
      systemPrompt: freezed == systemPrompt
          ? _self.systemPrompt
          : systemPrompt // ignore: cast_nullable_to_non_nullable
              as String?,
      temperature: null == temperature
          ? _self.temperature
          : temperature // ignore: cast_nullable_to_non_nullable
              as double,
      maxTokens: null == maxTokens
          ? _self.maxTokens
          : maxTokens // ignore: cast_nullable_to_non_nullable
              as int,
      metadata: null == metadata
          ? _self.metadata
          : metadata // ignore: cast_nullable_to_non_nullable
              as Map<String, Object?>,
    ));
  }
}

/// Adds pattern-matching-related methods to [LLMRequest].
extension LLMRequestPatterns on LLMRequest {
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
    TResult Function(_LLMRequest value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _LLMRequest() when $default != null:
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
    TResult Function(_LLMRequest value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _LLMRequest():
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
    TResult? Function(_LLMRequest value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _LLMRequest() when $default != null:
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
    TResult Function(String prompt, String? systemPrompt, double temperature,
            int maxTokens, Map<String, Object?> metadata)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _LLMRequest() when $default != null:
        return $default(_that.prompt, _that.systemPrompt, _that.temperature,
            _that.maxTokens, _that.metadata);
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
    TResult Function(String prompt, String? systemPrompt, double temperature,
            int maxTokens, Map<String, Object?> metadata)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _LLMRequest():
        return $default(_that.prompt, _that.systemPrompt, _that.temperature,
            _that.maxTokens, _that.metadata);
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
    TResult? Function(String prompt, String? systemPrompt, double temperature,
            int maxTokens, Map<String, Object?> metadata)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _LLMRequest() when $default != null:
        return $default(_that.prompt, _that.systemPrompt, _that.temperature,
            _that.maxTokens, _that.metadata);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _LLMRequest implements LLMRequest {
  const _LLMRequest(
      {required this.prompt,
      this.systemPrompt,
      this.temperature = 0.7,
      this.maxTokens = 1024,
      final Map<String, Object?> metadata = const <String, Object?>{}})
      : _metadata = metadata;
  factory _LLMRequest.fromJson(Map<String, dynamic> json) =>
      _$LLMRequestFromJson(json);

  @override
  final String prompt;
  @override
  final String? systemPrompt;
  @override
  @JsonKey()
  final double temperature;
  @override
  @JsonKey()
  final int maxTokens;
  final Map<String, Object?> _metadata;
  @override
  @JsonKey()
  Map<String, Object?> get metadata {
    if (_metadata is EqualUnmodifiableMapView) return _metadata;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_metadata);
  }

  /// Create a copy of LLMRequest
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$LLMRequestCopyWith<_LLMRequest> get copyWith =>
      __$LLMRequestCopyWithImpl<_LLMRequest>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$LLMRequestToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _LLMRequest &&
            (identical(other.prompt, prompt) || other.prompt == prompt) &&
            (identical(other.systemPrompt, systemPrompt) ||
                other.systemPrompt == systemPrompt) &&
            (identical(other.temperature, temperature) ||
                other.temperature == temperature) &&
            (identical(other.maxTokens, maxTokens) ||
                other.maxTokens == maxTokens) &&
            const DeepCollectionEquality().equals(other._metadata, _metadata));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, prompt, systemPrompt,
      temperature, maxTokens, const DeepCollectionEquality().hash(_metadata));

  @override
  String toString() {
    return 'LLMRequest(prompt: $prompt, systemPrompt: $systemPrompt, temperature: $temperature, maxTokens: $maxTokens, metadata: $metadata)';
  }
}

/// @nodoc
abstract mixin class _$LLMRequestCopyWith<$Res>
    implements $LLMRequestCopyWith<$Res> {
  factory _$LLMRequestCopyWith(
          _LLMRequest value, $Res Function(_LLMRequest) _then) =
      __$LLMRequestCopyWithImpl;
  @override
  @useResult
  $Res call(
      {String prompt,
      String? systemPrompt,
      double temperature,
      int maxTokens,
      Map<String, Object?> metadata});
}

/// @nodoc
class __$LLMRequestCopyWithImpl<$Res> implements _$LLMRequestCopyWith<$Res> {
  __$LLMRequestCopyWithImpl(this._self, this._then);

  final _LLMRequest _self;
  final $Res Function(_LLMRequest) _then;

  /// Create a copy of LLMRequest
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? prompt = null,
    Object? systemPrompt = freezed,
    Object? temperature = null,
    Object? maxTokens = null,
    Object? metadata = null,
  }) {
    return _then(_LLMRequest(
      prompt: null == prompt
          ? _self.prompt
          : prompt // ignore: cast_nullable_to_non_nullable
              as String,
      systemPrompt: freezed == systemPrompt
          ? _self.systemPrompt
          : systemPrompt // ignore: cast_nullable_to_non_nullable
              as String?,
      temperature: null == temperature
          ? _self.temperature
          : temperature // ignore: cast_nullable_to_non_nullable
              as double,
      maxTokens: null == maxTokens
          ? _self.maxTokens
          : maxTokens // ignore: cast_nullable_to_non_nullable
              as int,
      metadata: null == metadata
          ? _self._metadata
          : metadata // ignore: cast_nullable_to_non_nullable
              as Map<String, Object?>,
    ));
  }
}

/// @nodoc
mixin _$STTRequest {
  String get filePath;
  String get language;
  String get model;

  /// Create a copy of STTRequest
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $STTRequestCopyWith<STTRequest> get copyWith =>
      _$STTRequestCopyWithImpl<STTRequest>(this as STTRequest, _$identity);

  /// Serializes this STTRequest to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is STTRequest &&
            (identical(other.filePath, filePath) ||
                other.filePath == filePath) &&
            (identical(other.language, language) ||
                other.language == language) &&
            (identical(other.model, model) || other.model == model));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, filePath, language, model);

  @override
  String toString() {
    return 'STTRequest(filePath: $filePath, language: $language, model: $model)';
  }
}

/// @nodoc
abstract mixin class $STTRequestCopyWith<$Res> {
  factory $STTRequestCopyWith(
          STTRequest value, $Res Function(STTRequest) _then) =
      _$STTRequestCopyWithImpl;
  @useResult
  $Res call({String filePath, String language, String model});
}

/// @nodoc
class _$STTRequestCopyWithImpl<$Res> implements $STTRequestCopyWith<$Res> {
  _$STTRequestCopyWithImpl(this._self, this._then);

  final STTRequest _self;
  final $Res Function(STTRequest) _then;

  /// Create a copy of STTRequest
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? filePath = null,
    Object? language = null,
    Object? model = null,
  }) {
    return _then(_self.copyWith(
      filePath: null == filePath
          ? _self.filePath
          : filePath // ignore: cast_nullable_to_non_nullable
              as String,
      language: null == language
          ? _self.language
          : language // ignore: cast_nullable_to_non_nullable
              as String,
      model: null == model
          ? _self.model
          : model // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// Adds pattern-matching-related methods to [STTRequest].
extension STTRequestPatterns on STTRequest {
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
    TResult Function(_STTRequest value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _STTRequest() when $default != null:
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
    TResult Function(_STTRequest value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _STTRequest():
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
    TResult? Function(_STTRequest value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _STTRequest() when $default != null:
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
    TResult Function(String filePath, String language, String model)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _STTRequest() when $default != null:
        return $default(_that.filePath, _that.language, _that.model);
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
    TResult Function(String filePath, String language, String model) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _STTRequest():
        return $default(_that.filePath, _that.language, _that.model);
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
    TResult? Function(String filePath, String language, String model)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _STTRequest() when $default != null:
        return $default(_that.filePath, _that.language, _that.model);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _STTRequest implements STTRequest {
  const _STTRequest(
      {required this.filePath,
      this.language = 'id',
      this.model = 'whisper-large-v3'});
  factory _STTRequest.fromJson(Map<String, dynamic> json) =>
      _$STTRequestFromJson(json);

  @override
  final String filePath;
  @override
  @JsonKey()
  final String language;
  @override
  @JsonKey()
  final String model;

  /// Create a copy of STTRequest
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$STTRequestCopyWith<_STTRequest> get copyWith =>
      __$STTRequestCopyWithImpl<_STTRequest>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$STTRequestToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _STTRequest &&
            (identical(other.filePath, filePath) ||
                other.filePath == filePath) &&
            (identical(other.language, language) ||
                other.language == language) &&
            (identical(other.model, model) || other.model == model));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, filePath, language, model);

  @override
  String toString() {
    return 'STTRequest(filePath: $filePath, language: $language, model: $model)';
  }
}

/// @nodoc
abstract mixin class _$STTRequestCopyWith<$Res>
    implements $STTRequestCopyWith<$Res> {
  factory _$STTRequestCopyWith(
          _STTRequest value, $Res Function(_STTRequest) _then) =
      __$STTRequestCopyWithImpl;
  @override
  @useResult
  $Res call({String filePath, String language, String model});
}

/// @nodoc
class __$STTRequestCopyWithImpl<$Res> implements _$STTRequestCopyWith<$Res> {
  __$STTRequestCopyWithImpl(this._self, this._then);

  final _STTRequest _self;
  final $Res Function(_STTRequest) _then;

  /// Create a copy of STTRequest
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? filePath = null,
    Object? language = null,
    Object? model = null,
  }) {
    return _then(_STTRequest(
      filePath: null == filePath
          ? _self.filePath
          : filePath // ignore: cast_nullable_to_non_nullable
              as String,
      language: null == language
          ? _self.language
          : language // ignore: cast_nullable_to_non_nullable
              as String,
      model: null == model
          ? _self.model
          : model // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
mixin _$TTSRequest {
  String get text;
  String get voice;
  String get rate;
  String get pitch;
  String get volume;

  /// Create a copy of TTSRequest
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $TTSRequestCopyWith<TTSRequest> get copyWith =>
      _$TTSRequestCopyWithImpl<TTSRequest>(this as TTSRequest, _$identity);

  /// Serializes this TTSRequest to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is TTSRequest &&
            (identical(other.text, text) || other.text == text) &&
            (identical(other.voice, voice) || other.voice == voice) &&
            (identical(other.rate, rate) || other.rate == rate) &&
            (identical(other.pitch, pitch) || other.pitch == pitch) &&
            (identical(other.volume, volume) || other.volume == volume));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, text, voice, rate, pitch, volume);

  @override
  String toString() {
    return 'TTSRequest(text: $text, voice: $voice, rate: $rate, pitch: $pitch, volume: $volume)';
  }
}

/// @nodoc
abstract mixin class $TTSRequestCopyWith<$Res> {
  factory $TTSRequestCopyWith(
          TTSRequest value, $Res Function(TTSRequest) _then) =
      _$TTSRequestCopyWithImpl;
  @useResult
  $Res call(
      {String text, String voice, String rate, String pitch, String volume});
}

/// @nodoc
class _$TTSRequestCopyWithImpl<$Res> implements $TTSRequestCopyWith<$Res> {
  _$TTSRequestCopyWithImpl(this._self, this._then);

  final TTSRequest _self;
  final $Res Function(TTSRequest) _then;

  /// Create a copy of TTSRequest
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? text = null,
    Object? voice = null,
    Object? rate = null,
    Object? pitch = null,
    Object? volume = null,
  }) {
    return _then(_self.copyWith(
      text: null == text
          ? _self.text
          : text // ignore: cast_nullable_to_non_nullable
              as String,
      voice: null == voice
          ? _self.voice
          : voice // ignore: cast_nullable_to_non_nullable
              as String,
      rate: null == rate
          ? _self.rate
          : rate // ignore: cast_nullable_to_non_nullable
              as String,
      pitch: null == pitch
          ? _self.pitch
          : pitch // ignore: cast_nullable_to_non_nullable
              as String,
      volume: null == volume
          ? _self.volume
          : volume // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// Adds pattern-matching-related methods to [TTSRequest].
extension TTSRequestPatterns on TTSRequest {
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
    TResult Function(_TTSRequest value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _TTSRequest() when $default != null:
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
    TResult Function(_TTSRequest value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _TTSRequest():
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
    TResult? Function(_TTSRequest value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _TTSRequest() when $default != null:
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
    TResult Function(String text, String voice, String rate, String pitch,
            String volume)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _TTSRequest() when $default != null:
        return $default(
            _that.text, _that.voice, _that.rate, _that.pitch, _that.volume);
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
            String text, String voice, String rate, String pitch, String volume)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _TTSRequest():
        return $default(
            _that.text, _that.voice, _that.rate, _that.pitch, _that.volume);
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
    TResult? Function(String text, String voice, String rate, String pitch,
            String volume)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _TTSRequest() when $default != null:
        return $default(
            _that.text, _that.voice, _that.rate, _that.pitch, _that.volume);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _TTSRequest implements TTSRequest {
  const _TTSRequest(
      {required this.text,
      this.voice = 'id-ID-ArdiNeural',
      this.rate = '+0%',
      this.pitch = '+0Hz',
      this.volume = '+0%'});
  factory _TTSRequest.fromJson(Map<String, dynamic> json) =>
      _$TTSRequestFromJson(json);

  @override
  final String text;
  @override
  @JsonKey()
  final String voice;
  @override
  @JsonKey()
  final String rate;
  @override
  @JsonKey()
  final String pitch;
  @override
  @JsonKey()
  final String volume;

  /// Create a copy of TTSRequest
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$TTSRequestCopyWith<_TTSRequest> get copyWith =>
      __$TTSRequestCopyWithImpl<_TTSRequest>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$TTSRequestToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _TTSRequest &&
            (identical(other.text, text) || other.text == text) &&
            (identical(other.voice, voice) || other.voice == voice) &&
            (identical(other.rate, rate) || other.rate == rate) &&
            (identical(other.pitch, pitch) || other.pitch == pitch) &&
            (identical(other.volume, volume) || other.volume == volume));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, text, voice, rate, pitch, volume);

  @override
  String toString() {
    return 'TTSRequest(text: $text, voice: $voice, rate: $rate, pitch: $pitch, volume: $volume)';
  }
}

/// @nodoc
abstract mixin class _$TTSRequestCopyWith<$Res>
    implements $TTSRequestCopyWith<$Res> {
  factory _$TTSRequestCopyWith(
          _TTSRequest value, $Res Function(_TTSRequest) _then) =
      __$TTSRequestCopyWithImpl;
  @override
  @useResult
  $Res call(
      {String text, String voice, String rate, String pitch, String volume});
}

/// @nodoc
class __$TTSRequestCopyWithImpl<$Res> implements _$TTSRequestCopyWith<$Res> {
  __$TTSRequestCopyWithImpl(this._self, this._then);

  final _TTSRequest _self;
  final $Res Function(_TTSRequest) _then;

  /// Create a copy of TTSRequest
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? text = null,
    Object? voice = null,
    Object? rate = null,
    Object? pitch = null,
    Object? volume = null,
  }) {
    return _then(_TTSRequest(
      text: null == text
          ? _self.text
          : text // ignore: cast_nullable_to_non_nullable
              as String,
      voice: null == voice
          ? _self.voice
          : voice // ignore: cast_nullable_to_non_nullable
              as String,
      rate: null == rate
          ? _self.rate
          : rate // ignore: cast_nullable_to_non_nullable
              as String,
      pitch: null == pitch
          ? _self.pitch
          : pitch // ignore: cast_nullable_to_non_nullable
              as String,
      volume: null == volume
          ? _self.volume
          : volume // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
mixin _$ImageRequest {
  String get prompt;
  int get width;
  int get height;
  String get model;
  int? get seed;

  /// Create a copy of ImageRequest
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $ImageRequestCopyWith<ImageRequest> get copyWith =>
      _$ImageRequestCopyWithImpl<ImageRequest>(
          this as ImageRequest, _$identity);

  /// Serializes this ImageRequest to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is ImageRequest &&
            (identical(other.prompt, prompt) || other.prompt == prompt) &&
            (identical(other.width, width) || other.width == width) &&
            (identical(other.height, height) || other.height == height) &&
            (identical(other.model, model) || other.model == model) &&
            (identical(other.seed, seed) || other.seed == seed));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, prompt, width, height, model, seed);

  @override
  String toString() {
    return 'ImageRequest(prompt: $prompt, width: $width, height: $height, model: $model, seed: $seed)';
  }
}

/// @nodoc
abstract mixin class $ImageRequestCopyWith<$Res> {
  factory $ImageRequestCopyWith(
          ImageRequest value, $Res Function(ImageRequest) _then) =
      _$ImageRequestCopyWithImpl;
  @useResult
  $Res call({String prompt, int width, int height, String model, int? seed});
}

/// @nodoc
class _$ImageRequestCopyWithImpl<$Res> implements $ImageRequestCopyWith<$Res> {
  _$ImageRequestCopyWithImpl(this._self, this._then);

  final ImageRequest _self;
  final $Res Function(ImageRequest) _then;

  /// Create a copy of ImageRequest
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? prompt = null,
    Object? width = null,
    Object? height = null,
    Object? model = null,
    Object? seed = freezed,
  }) {
    return _then(_self.copyWith(
      prompt: null == prompt
          ? _self.prompt
          : prompt // ignore: cast_nullable_to_non_nullable
              as String,
      width: null == width
          ? _self.width
          : width // ignore: cast_nullable_to_non_nullable
              as int,
      height: null == height
          ? _self.height
          : height // ignore: cast_nullable_to_non_nullable
              as int,
      model: null == model
          ? _self.model
          : model // ignore: cast_nullable_to_non_nullable
              as String,
      seed: freezed == seed
          ? _self.seed
          : seed // ignore: cast_nullable_to_non_nullable
              as int?,
    ));
  }
}

/// Adds pattern-matching-related methods to [ImageRequest].
extension ImageRequestPatterns on ImageRequest {
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
    TResult Function(_ImageRequest value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _ImageRequest() when $default != null:
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
    TResult Function(_ImageRequest value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _ImageRequest():
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
    TResult? Function(_ImageRequest value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _ImageRequest() when $default != null:
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
            String prompt, int width, int height, String model, int? seed)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _ImageRequest() when $default != null:
        return $default(
            _that.prompt, _that.width, _that.height, _that.model, _that.seed);
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
            String prompt, int width, int height, String model, int? seed)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _ImageRequest():
        return $default(
            _that.prompt, _that.width, _that.height, _that.model, _that.seed);
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
            String prompt, int width, int height, String model, int? seed)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _ImageRequest() when $default != null:
        return $default(
            _that.prompt, _that.width, _that.height, _that.model, _that.seed);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _ImageRequest implements ImageRequest {
  const _ImageRequest(
      {required this.prompt,
      this.width = 1024,
      this.height = 1024,
      this.model = 'flux',
      this.seed});
  factory _ImageRequest.fromJson(Map<String, dynamic> json) =>
      _$ImageRequestFromJson(json);

  @override
  final String prompt;
  @override
  @JsonKey()
  final int width;
  @override
  @JsonKey()
  final int height;
  @override
  @JsonKey()
  final String model;
  @override
  final int? seed;

  /// Create a copy of ImageRequest
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$ImageRequestCopyWith<_ImageRequest> get copyWith =>
      __$ImageRequestCopyWithImpl<_ImageRequest>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$ImageRequestToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _ImageRequest &&
            (identical(other.prompt, prompt) || other.prompt == prompt) &&
            (identical(other.width, width) || other.width == width) &&
            (identical(other.height, height) || other.height == height) &&
            (identical(other.model, model) || other.model == model) &&
            (identical(other.seed, seed) || other.seed == seed));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, prompt, width, height, model, seed);

  @override
  String toString() {
    return 'ImageRequest(prompt: $prompt, width: $width, height: $height, model: $model, seed: $seed)';
  }
}

/// @nodoc
abstract mixin class _$ImageRequestCopyWith<$Res>
    implements $ImageRequestCopyWith<$Res> {
  factory _$ImageRequestCopyWith(
          _ImageRequest value, $Res Function(_ImageRequest) _then) =
      __$ImageRequestCopyWithImpl;
  @override
  @useResult
  $Res call({String prompt, int width, int height, String model, int? seed});
}

/// @nodoc
class __$ImageRequestCopyWithImpl<$Res>
    implements _$ImageRequestCopyWith<$Res> {
  __$ImageRequestCopyWithImpl(this._self, this._then);

  final _ImageRequest _self;
  final $Res Function(_ImageRequest) _then;

  /// Create a copy of ImageRequest
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? prompt = null,
    Object? width = null,
    Object? height = null,
    Object? model = null,
    Object? seed = freezed,
  }) {
    return _then(_ImageRequest(
      prompt: null == prompt
          ? _self.prompt
          : prompt // ignore: cast_nullable_to_non_nullable
              as String,
      width: null == width
          ? _self.width
          : width // ignore: cast_nullable_to_non_nullable
              as int,
      height: null == height
          ? _self.height
          : height // ignore: cast_nullable_to_non_nullable
              as int,
      model: null == model
          ? _self.model
          : model // ignore: cast_nullable_to_non_nullable
              as String,
      seed: freezed == seed
          ? _self.seed
          : seed // ignore: cast_nullable_to_non_nullable
              as int?,
    ));
  }
}

/// @nodoc
mixin _$LLMResponse {
  String get text;
  String get provider;
  int get inputTokens;
  int get outputTokens;
  double get estimatedCostUsd;
  Map<String, Object?> get raw;

  /// Create a copy of LLMResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $LLMResponseCopyWith<LLMResponse> get copyWith =>
      _$LLMResponseCopyWithImpl<LLMResponse>(this as LLMResponse, _$identity);

  /// Serializes this LLMResponse to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is LLMResponse &&
            (identical(other.text, text) || other.text == text) &&
            (identical(other.provider, provider) ||
                other.provider == provider) &&
            (identical(other.inputTokens, inputTokens) ||
                other.inputTokens == inputTokens) &&
            (identical(other.outputTokens, outputTokens) ||
                other.outputTokens == outputTokens) &&
            (identical(other.estimatedCostUsd, estimatedCostUsd) ||
                other.estimatedCostUsd == estimatedCostUsd) &&
            const DeepCollectionEquality().equals(other.raw, raw));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, text, provider, inputTokens,
      outputTokens, estimatedCostUsd, const DeepCollectionEquality().hash(raw));

  @override
  String toString() {
    return 'LLMResponse(text: $text, provider: $provider, inputTokens: $inputTokens, outputTokens: $outputTokens, estimatedCostUsd: $estimatedCostUsd, raw: $raw)';
  }
}

/// @nodoc
abstract mixin class $LLMResponseCopyWith<$Res> {
  factory $LLMResponseCopyWith(
          LLMResponse value, $Res Function(LLMResponse) _then) =
      _$LLMResponseCopyWithImpl;
  @useResult
  $Res call(
      {String text,
      String provider,
      int inputTokens,
      int outputTokens,
      double estimatedCostUsd,
      Map<String, Object?> raw});
}

/// @nodoc
class _$LLMResponseCopyWithImpl<$Res> implements $LLMResponseCopyWith<$Res> {
  _$LLMResponseCopyWithImpl(this._self, this._then);

  final LLMResponse _self;
  final $Res Function(LLMResponse) _then;

  /// Create a copy of LLMResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? text = null,
    Object? provider = null,
    Object? inputTokens = null,
    Object? outputTokens = null,
    Object? estimatedCostUsd = null,
    Object? raw = null,
  }) {
    return _then(_self.copyWith(
      text: null == text
          ? _self.text
          : text // ignore: cast_nullable_to_non_nullable
              as String,
      provider: null == provider
          ? _self.provider
          : provider // ignore: cast_nullable_to_non_nullable
              as String,
      inputTokens: null == inputTokens
          ? _self.inputTokens
          : inputTokens // ignore: cast_nullable_to_non_nullable
              as int,
      outputTokens: null == outputTokens
          ? _self.outputTokens
          : outputTokens // ignore: cast_nullable_to_non_nullable
              as int,
      estimatedCostUsd: null == estimatedCostUsd
          ? _self.estimatedCostUsd
          : estimatedCostUsd // ignore: cast_nullable_to_non_nullable
              as double,
      raw: null == raw
          ? _self.raw
          : raw // ignore: cast_nullable_to_non_nullable
              as Map<String, Object?>,
    ));
  }
}

/// Adds pattern-matching-related methods to [LLMResponse].
extension LLMResponsePatterns on LLMResponse {
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
    TResult Function(_LLMResponse value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _LLMResponse() when $default != null:
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
    TResult Function(_LLMResponse value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _LLMResponse():
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
    TResult? Function(_LLMResponse value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _LLMResponse() when $default != null:
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
            String text,
            String provider,
            int inputTokens,
            int outputTokens,
            double estimatedCostUsd,
            Map<String, Object?> raw)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _LLMResponse() when $default != null:
        return $default(_that.text, _that.provider, _that.inputTokens,
            _that.outputTokens, _that.estimatedCostUsd, _that.raw);
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
    TResult Function(String text, String provider, int inputTokens,
            int outputTokens, double estimatedCostUsd, Map<String, Object?> raw)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _LLMResponse():
        return $default(_that.text, _that.provider, _that.inputTokens,
            _that.outputTokens, _that.estimatedCostUsd, _that.raw);
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
            String text,
            String provider,
            int inputTokens,
            int outputTokens,
            double estimatedCostUsd,
            Map<String, Object?> raw)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _LLMResponse() when $default != null:
        return $default(_that.text, _that.provider, _that.inputTokens,
            _that.outputTokens, _that.estimatedCostUsd, _that.raw);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _LLMResponse implements LLMResponse {
  const _LLMResponse(
      {required this.text,
      required this.provider,
      this.inputTokens = 0,
      this.outputTokens = 0,
      this.estimatedCostUsd = 0,
      final Map<String, Object?> raw = const <String, Object?>{}})
      : _raw = raw;
  factory _LLMResponse.fromJson(Map<String, dynamic> json) =>
      _$LLMResponseFromJson(json);

  @override
  final String text;
  @override
  final String provider;
  @override
  @JsonKey()
  final int inputTokens;
  @override
  @JsonKey()
  final int outputTokens;
  @override
  @JsonKey()
  final double estimatedCostUsd;
  final Map<String, Object?> _raw;
  @override
  @JsonKey()
  Map<String, Object?> get raw {
    if (_raw is EqualUnmodifiableMapView) return _raw;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_raw);
  }

  /// Create a copy of LLMResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$LLMResponseCopyWith<_LLMResponse> get copyWith =>
      __$LLMResponseCopyWithImpl<_LLMResponse>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$LLMResponseToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _LLMResponse &&
            (identical(other.text, text) || other.text == text) &&
            (identical(other.provider, provider) ||
                other.provider == provider) &&
            (identical(other.inputTokens, inputTokens) ||
                other.inputTokens == inputTokens) &&
            (identical(other.outputTokens, outputTokens) ||
                other.outputTokens == outputTokens) &&
            (identical(other.estimatedCostUsd, estimatedCostUsd) ||
                other.estimatedCostUsd == estimatedCostUsd) &&
            const DeepCollectionEquality().equals(other._raw, _raw));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      text,
      provider,
      inputTokens,
      outputTokens,
      estimatedCostUsd,
      const DeepCollectionEquality().hash(_raw));

  @override
  String toString() {
    return 'LLMResponse(text: $text, provider: $provider, inputTokens: $inputTokens, outputTokens: $outputTokens, estimatedCostUsd: $estimatedCostUsd, raw: $raw)';
  }
}

/// @nodoc
abstract mixin class _$LLMResponseCopyWith<$Res>
    implements $LLMResponseCopyWith<$Res> {
  factory _$LLMResponseCopyWith(
          _LLMResponse value, $Res Function(_LLMResponse) _then) =
      __$LLMResponseCopyWithImpl;
  @override
  @useResult
  $Res call(
      {String text,
      String provider,
      int inputTokens,
      int outputTokens,
      double estimatedCostUsd,
      Map<String, Object?> raw});
}

/// @nodoc
class __$LLMResponseCopyWithImpl<$Res> implements _$LLMResponseCopyWith<$Res> {
  __$LLMResponseCopyWithImpl(this._self, this._then);

  final _LLMResponse _self;
  final $Res Function(_LLMResponse) _then;

  /// Create a copy of LLMResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? text = null,
    Object? provider = null,
    Object? inputTokens = null,
    Object? outputTokens = null,
    Object? estimatedCostUsd = null,
    Object? raw = null,
  }) {
    return _then(_LLMResponse(
      text: null == text
          ? _self.text
          : text // ignore: cast_nullable_to_non_nullable
              as String,
      provider: null == provider
          ? _self.provider
          : provider // ignore: cast_nullable_to_non_nullable
              as String,
      inputTokens: null == inputTokens
          ? _self.inputTokens
          : inputTokens // ignore: cast_nullable_to_non_nullable
              as int,
      outputTokens: null == outputTokens
          ? _self.outputTokens
          : outputTokens // ignore: cast_nullable_to_non_nullable
              as int,
      estimatedCostUsd: null == estimatedCostUsd
          ? _self.estimatedCostUsd
          : estimatedCostUsd // ignore: cast_nullable_to_non_nullable
              as double,
      raw: null == raw
          ? _self._raw
          : raw // ignore: cast_nullable_to_non_nullable
              as Map<String, Object?>,
    ));
  }
}

/// @nodoc
mixin _$STTResponse {
  String get text;
  String get provider;
  String get language;
  Map<String, Object?> get raw;

  /// Create a copy of STTResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $STTResponseCopyWith<STTResponse> get copyWith =>
      _$STTResponseCopyWithImpl<STTResponse>(this as STTResponse, _$identity);

  /// Serializes this STTResponse to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is STTResponse &&
            (identical(other.text, text) || other.text == text) &&
            (identical(other.provider, provider) ||
                other.provider == provider) &&
            (identical(other.language, language) ||
                other.language == language) &&
            const DeepCollectionEquality().equals(other.raw, raw));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, text, provider, language,
      const DeepCollectionEquality().hash(raw));

  @override
  String toString() {
    return 'STTResponse(text: $text, provider: $provider, language: $language, raw: $raw)';
  }
}

/// @nodoc
abstract mixin class $STTResponseCopyWith<$Res> {
  factory $STTResponseCopyWith(
          STTResponse value, $Res Function(STTResponse) _then) =
      _$STTResponseCopyWithImpl;
  @useResult
  $Res call(
      {String text,
      String provider,
      String language,
      Map<String, Object?> raw});
}

/// @nodoc
class _$STTResponseCopyWithImpl<$Res> implements $STTResponseCopyWith<$Res> {
  _$STTResponseCopyWithImpl(this._self, this._then);

  final STTResponse _self;
  final $Res Function(STTResponse) _then;

  /// Create a copy of STTResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? text = null,
    Object? provider = null,
    Object? language = null,
    Object? raw = null,
  }) {
    return _then(_self.copyWith(
      text: null == text
          ? _self.text
          : text // ignore: cast_nullable_to_non_nullable
              as String,
      provider: null == provider
          ? _self.provider
          : provider // ignore: cast_nullable_to_non_nullable
              as String,
      language: null == language
          ? _self.language
          : language // ignore: cast_nullable_to_non_nullable
              as String,
      raw: null == raw
          ? _self.raw
          : raw // ignore: cast_nullable_to_non_nullable
              as Map<String, Object?>,
    ));
  }
}

/// Adds pattern-matching-related methods to [STTResponse].
extension STTResponsePatterns on STTResponse {
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
    TResult Function(_STTResponse value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _STTResponse() when $default != null:
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
    TResult Function(_STTResponse value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _STTResponse():
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
    TResult? Function(_STTResponse value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _STTResponse() when $default != null:
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
    TResult Function(String text, String provider, String language,
            Map<String, Object?> raw)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _STTResponse() when $default != null:
        return $default(_that.text, _that.provider, _that.language, _that.raw);
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
    TResult Function(String text, String provider, String language,
            Map<String, Object?> raw)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _STTResponse():
        return $default(_that.text, _that.provider, _that.language, _that.raw);
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
    TResult? Function(String text, String provider, String language,
            Map<String, Object?> raw)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _STTResponse() when $default != null:
        return $default(_that.text, _that.provider, _that.language, _that.raw);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _STTResponse implements STTResponse {
  const _STTResponse(
      {required this.text,
      required this.provider,
      this.language = 'id',
      final Map<String, Object?> raw = const <String, Object?>{}})
      : _raw = raw;
  factory _STTResponse.fromJson(Map<String, dynamic> json) =>
      _$STTResponseFromJson(json);

  @override
  final String text;
  @override
  final String provider;
  @override
  @JsonKey()
  final String language;
  final Map<String, Object?> _raw;
  @override
  @JsonKey()
  Map<String, Object?> get raw {
    if (_raw is EqualUnmodifiableMapView) return _raw;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_raw);
  }

  /// Create a copy of STTResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$STTResponseCopyWith<_STTResponse> get copyWith =>
      __$STTResponseCopyWithImpl<_STTResponse>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$STTResponseToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _STTResponse &&
            (identical(other.text, text) || other.text == text) &&
            (identical(other.provider, provider) ||
                other.provider == provider) &&
            (identical(other.language, language) ||
                other.language == language) &&
            const DeepCollectionEquality().equals(other._raw, _raw));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, text, provider, language,
      const DeepCollectionEquality().hash(_raw));

  @override
  String toString() {
    return 'STTResponse(text: $text, provider: $provider, language: $language, raw: $raw)';
  }
}

/// @nodoc
abstract mixin class _$STTResponseCopyWith<$Res>
    implements $STTResponseCopyWith<$Res> {
  factory _$STTResponseCopyWith(
          _STTResponse value, $Res Function(_STTResponse) _then) =
      __$STTResponseCopyWithImpl;
  @override
  @useResult
  $Res call(
      {String text,
      String provider,
      String language,
      Map<String, Object?> raw});
}

/// @nodoc
class __$STTResponseCopyWithImpl<$Res> implements _$STTResponseCopyWith<$Res> {
  __$STTResponseCopyWithImpl(this._self, this._then);

  final _STTResponse _self;
  final $Res Function(_STTResponse) _then;

  /// Create a copy of STTResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? text = null,
    Object? provider = null,
    Object? language = null,
    Object? raw = null,
  }) {
    return _then(_STTResponse(
      text: null == text
          ? _self.text
          : text // ignore: cast_nullable_to_non_nullable
              as String,
      provider: null == provider
          ? _self.provider
          : provider // ignore: cast_nullable_to_non_nullable
              as String,
      language: null == language
          ? _self.language
          : language // ignore: cast_nullable_to_non_nullable
              as String,
      raw: null == raw
          ? _self._raw
          : raw // ignore: cast_nullable_to_non_nullable
              as Map<String, Object?>,
    ));
  }
}

/// @nodoc
mixin _$TTSResponse {
  String get audioPath;
  String get provider;
  String get voice;
  String get mimeType;

  /// Create a copy of TTSResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $TTSResponseCopyWith<TTSResponse> get copyWith =>
      _$TTSResponseCopyWithImpl<TTSResponse>(this as TTSResponse, _$identity);

  /// Serializes this TTSResponse to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is TTSResponse &&
            (identical(other.audioPath, audioPath) ||
                other.audioPath == audioPath) &&
            (identical(other.provider, provider) ||
                other.provider == provider) &&
            (identical(other.voice, voice) || other.voice == voice) &&
            (identical(other.mimeType, mimeType) ||
                other.mimeType == mimeType));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, audioPath, provider, voice, mimeType);

  @override
  String toString() {
    return 'TTSResponse(audioPath: $audioPath, provider: $provider, voice: $voice, mimeType: $mimeType)';
  }
}

/// @nodoc
abstract mixin class $TTSResponseCopyWith<$Res> {
  factory $TTSResponseCopyWith(
          TTSResponse value, $Res Function(TTSResponse) _then) =
      _$TTSResponseCopyWithImpl;
  @useResult
  $Res call({String audioPath, String provider, String voice, String mimeType});
}

/// @nodoc
class _$TTSResponseCopyWithImpl<$Res> implements $TTSResponseCopyWith<$Res> {
  _$TTSResponseCopyWithImpl(this._self, this._then);

  final TTSResponse _self;
  final $Res Function(TTSResponse) _then;

  /// Create a copy of TTSResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? audioPath = null,
    Object? provider = null,
    Object? voice = null,
    Object? mimeType = null,
  }) {
    return _then(_self.copyWith(
      audioPath: null == audioPath
          ? _self.audioPath
          : audioPath // ignore: cast_nullable_to_non_nullable
              as String,
      provider: null == provider
          ? _self.provider
          : provider // ignore: cast_nullable_to_non_nullable
              as String,
      voice: null == voice
          ? _self.voice
          : voice // ignore: cast_nullable_to_non_nullable
              as String,
      mimeType: null == mimeType
          ? _self.mimeType
          : mimeType // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// Adds pattern-matching-related methods to [TTSResponse].
extension TTSResponsePatterns on TTSResponse {
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
    TResult Function(_TTSResponse value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _TTSResponse() when $default != null:
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
    TResult Function(_TTSResponse value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _TTSResponse():
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
    TResult? Function(_TTSResponse value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _TTSResponse() when $default != null:
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
            String audioPath, String provider, String voice, String mimeType)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _TTSResponse() when $default != null:
        return $default(
            _that.audioPath, _that.provider, _that.voice, _that.mimeType);
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
            String audioPath, String provider, String voice, String mimeType)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _TTSResponse():
        return $default(
            _that.audioPath, _that.provider, _that.voice, _that.mimeType);
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
            String audioPath, String provider, String voice, String mimeType)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _TTSResponse() when $default != null:
        return $default(
            _that.audioPath, _that.provider, _that.voice, _that.mimeType);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _TTSResponse implements TTSResponse {
  const _TTSResponse(
      {required this.audioPath,
      required this.provider,
      required this.voice,
      this.mimeType = 'audio/mpeg'});
  factory _TTSResponse.fromJson(Map<String, dynamic> json) =>
      _$TTSResponseFromJson(json);

  @override
  final String audioPath;
  @override
  final String provider;
  @override
  final String voice;
  @override
  @JsonKey()
  final String mimeType;

  /// Create a copy of TTSResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$TTSResponseCopyWith<_TTSResponse> get copyWith =>
      __$TTSResponseCopyWithImpl<_TTSResponse>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$TTSResponseToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _TTSResponse &&
            (identical(other.audioPath, audioPath) ||
                other.audioPath == audioPath) &&
            (identical(other.provider, provider) ||
                other.provider == provider) &&
            (identical(other.voice, voice) || other.voice == voice) &&
            (identical(other.mimeType, mimeType) ||
                other.mimeType == mimeType));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, audioPath, provider, voice, mimeType);

  @override
  String toString() {
    return 'TTSResponse(audioPath: $audioPath, provider: $provider, voice: $voice, mimeType: $mimeType)';
  }
}

/// @nodoc
abstract mixin class _$TTSResponseCopyWith<$Res>
    implements $TTSResponseCopyWith<$Res> {
  factory _$TTSResponseCopyWith(
          _TTSResponse value, $Res Function(_TTSResponse) _then) =
      __$TTSResponseCopyWithImpl;
  @override
  @useResult
  $Res call({String audioPath, String provider, String voice, String mimeType});
}

/// @nodoc
class __$TTSResponseCopyWithImpl<$Res> implements _$TTSResponseCopyWith<$Res> {
  __$TTSResponseCopyWithImpl(this._self, this._then);

  final _TTSResponse _self;
  final $Res Function(_TTSResponse) _then;

  /// Create a copy of TTSResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? audioPath = null,
    Object? provider = null,
    Object? voice = null,
    Object? mimeType = null,
  }) {
    return _then(_TTSResponse(
      audioPath: null == audioPath
          ? _self.audioPath
          : audioPath // ignore: cast_nullable_to_non_nullable
              as String,
      provider: null == provider
          ? _self.provider
          : provider // ignore: cast_nullable_to_non_nullable
              as String,
      voice: null == voice
          ? _self.voice
          : voice // ignore: cast_nullable_to_non_nullable
              as String,
      mimeType: null == mimeType
          ? _self.mimeType
          : mimeType // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
mixin _$ImageResponse {
  String get imagePath;
  String get provider;
  String get model;
  String get mimeType;

  /// Create a copy of ImageResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $ImageResponseCopyWith<ImageResponse> get copyWith =>
      _$ImageResponseCopyWithImpl<ImageResponse>(
          this as ImageResponse, _$identity);

  /// Serializes this ImageResponse to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is ImageResponse &&
            (identical(other.imagePath, imagePath) ||
                other.imagePath == imagePath) &&
            (identical(other.provider, provider) ||
                other.provider == provider) &&
            (identical(other.model, model) || other.model == model) &&
            (identical(other.mimeType, mimeType) ||
                other.mimeType == mimeType));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, imagePath, provider, model, mimeType);

  @override
  String toString() {
    return 'ImageResponse(imagePath: $imagePath, provider: $provider, model: $model, mimeType: $mimeType)';
  }
}

/// @nodoc
abstract mixin class $ImageResponseCopyWith<$Res> {
  factory $ImageResponseCopyWith(
          ImageResponse value, $Res Function(ImageResponse) _then) =
      _$ImageResponseCopyWithImpl;
  @useResult
  $Res call({String imagePath, String provider, String model, String mimeType});
}

/// @nodoc
class _$ImageResponseCopyWithImpl<$Res>
    implements $ImageResponseCopyWith<$Res> {
  _$ImageResponseCopyWithImpl(this._self, this._then);

  final ImageResponse _self;
  final $Res Function(ImageResponse) _then;

  /// Create a copy of ImageResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? imagePath = null,
    Object? provider = null,
    Object? model = null,
    Object? mimeType = null,
  }) {
    return _then(_self.copyWith(
      imagePath: null == imagePath
          ? _self.imagePath
          : imagePath // ignore: cast_nullable_to_non_nullable
              as String,
      provider: null == provider
          ? _self.provider
          : provider // ignore: cast_nullable_to_non_nullable
              as String,
      model: null == model
          ? _self.model
          : model // ignore: cast_nullable_to_non_nullable
              as String,
      mimeType: null == mimeType
          ? _self.mimeType
          : mimeType // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// Adds pattern-matching-related methods to [ImageResponse].
extension ImageResponsePatterns on ImageResponse {
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
    TResult Function(_ImageResponse value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _ImageResponse() when $default != null:
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
    TResult Function(_ImageResponse value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _ImageResponse():
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
    TResult? Function(_ImageResponse value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _ImageResponse() when $default != null:
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
            String imagePath, String provider, String model, String mimeType)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _ImageResponse() when $default != null:
        return $default(
            _that.imagePath, _that.provider, _that.model, _that.mimeType);
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
            String imagePath, String provider, String model, String mimeType)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _ImageResponse():
        return $default(
            _that.imagePath, _that.provider, _that.model, _that.mimeType);
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
            String imagePath, String provider, String model, String mimeType)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _ImageResponse() when $default != null:
        return $default(
            _that.imagePath, _that.provider, _that.model, _that.mimeType);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _ImageResponse implements ImageResponse {
  const _ImageResponse(
      {required this.imagePath,
      required this.provider,
      required this.model,
      this.mimeType = 'image/png'});
  factory _ImageResponse.fromJson(Map<String, dynamic> json) =>
      _$ImageResponseFromJson(json);

  @override
  final String imagePath;
  @override
  final String provider;
  @override
  final String model;
  @override
  @JsonKey()
  final String mimeType;

  /// Create a copy of ImageResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$ImageResponseCopyWith<_ImageResponse> get copyWith =>
      __$ImageResponseCopyWithImpl<_ImageResponse>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$ImageResponseToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _ImageResponse &&
            (identical(other.imagePath, imagePath) ||
                other.imagePath == imagePath) &&
            (identical(other.provider, provider) ||
                other.provider == provider) &&
            (identical(other.model, model) || other.model == model) &&
            (identical(other.mimeType, mimeType) ||
                other.mimeType == mimeType));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, imagePath, provider, model, mimeType);

  @override
  String toString() {
    return 'ImageResponse(imagePath: $imagePath, provider: $provider, model: $model, mimeType: $mimeType)';
  }
}

/// @nodoc
abstract mixin class _$ImageResponseCopyWith<$Res>
    implements $ImageResponseCopyWith<$Res> {
  factory _$ImageResponseCopyWith(
          _ImageResponse value, $Res Function(_ImageResponse) _then) =
      __$ImageResponseCopyWithImpl;
  @override
  @useResult
  $Res call({String imagePath, String provider, String model, String mimeType});
}

/// @nodoc
class __$ImageResponseCopyWithImpl<$Res>
    implements _$ImageResponseCopyWith<$Res> {
  __$ImageResponseCopyWithImpl(this._self, this._then);

  final _ImageResponse _self;
  final $Res Function(_ImageResponse) _then;

  /// Create a copy of ImageResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? imagePath = null,
    Object? provider = null,
    Object? model = null,
    Object? mimeType = null,
  }) {
    return _then(_ImageResponse(
      imagePath: null == imagePath
          ? _self.imagePath
          : imagePath // ignore: cast_nullable_to_non_nullable
              as String,
      provider: null == provider
          ? _self.provider
          : provider // ignore: cast_nullable_to_non_nullable
              as String,
      model: null == model
          ? _self.model
          : model // ignore: cast_nullable_to_non_nullable
              as String,
      mimeType: null == mimeType
          ? _self.mimeType
          : mimeType // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
mixin _$AIProviderError {
  String? get message;

  /// Create a copy of AIProviderError
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $AIProviderErrorCopyWith<AIProviderError> get copyWith =>
      _$AIProviderErrorCopyWithImpl<AIProviderError>(
          this as AIProviderError, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is AIProviderError &&
            (identical(other.message, message) || other.message == message));
  }

  @override
  int get hashCode => Object.hash(runtimeType, message);

  @override
  String toString() {
    return 'AIProviderError(message: $message)';
  }
}

/// @nodoc
abstract mixin class $AIProviderErrorCopyWith<$Res> {
  factory $AIProviderErrorCopyWith(
          AIProviderError value, $Res Function(AIProviderError) _then) =
      _$AIProviderErrorCopyWithImpl;
  @useResult
  $Res call({String message});
}

/// @nodoc
class _$AIProviderErrorCopyWithImpl<$Res>
    implements $AIProviderErrorCopyWith<$Res> {
  _$AIProviderErrorCopyWithImpl(this._self, this._then);

  final AIProviderError _self;
  final $Res Function(AIProviderError) _then;

  /// Create a copy of AIProviderError
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? message = null,
  }) {
    return _then(_self.copyWith(
      message: null == message
          ? _self.message!
          : message // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// Adds pattern-matching-related methods to [AIProviderError].
extension AIProviderErrorPatterns on AIProviderError {
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
  TResult maybeMap<TResult extends Object?>({
    TResult Function(QuotaExceeded value)? quotaExceeded,
    TResult Function(NetworkAIError value)? networkError,
    TResult Function(InvalidAIResponse value)? invalidResponse,
    TResult Function(TimeoutAIError value)? timeout,
    TResult Function(InvalidAIRequest value)? invalidRequest,
    TResult Function(AllProvidersExhausted value)? allProvidersExhausted,
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case QuotaExceeded() when quotaExceeded != null:
        return quotaExceeded(_that);
      case NetworkAIError() when networkError != null:
        return networkError(_that);
      case InvalidAIResponse() when invalidResponse != null:
        return invalidResponse(_that);
      case TimeoutAIError() when timeout != null:
        return timeout(_that);
      case InvalidAIRequest() when invalidRequest != null:
        return invalidRequest(_that);
      case AllProvidersExhausted() when allProvidersExhausted != null:
        return allProvidersExhausted(_that);
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
  TResult map<TResult extends Object?>({
    required TResult Function(QuotaExceeded value) quotaExceeded,
    required TResult Function(NetworkAIError value) networkError,
    required TResult Function(InvalidAIResponse value) invalidResponse,
    required TResult Function(TimeoutAIError value) timeout,
    required TResult Function(InvalidAIRequest value) invalidRequest,
    required TResult Function(AllProvidersExhausted value)
        allProvidersExhausted,
  }) {
    final _that = this;
    switch (_that) {
      case QuotaExceeded():
        return quotaExceeded(_that);
      case NetworkAIError():
        return networkError(_that);
      case InvalidAIResponse():
        return invalidResponse(_that);
      case TimeoutAIError():
        return timeout(_that);
      case InvalidAIRequest():
        return invalidRequest(_that);
      case AllProvidersExhausted():
        return allProvidersExhausted(_that);
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
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(QuotaExceeded value)? quotaExceeded,
    TResult? Function(NetworkAIError value)? networkError,
    TResult? Function(InvalidAIResponse value)? invalidResponse,
    TResult? Function(TimeoutAIError value)? timeout,
    TResult? Function(InvalidAIRequest value)? invalidRequest,
    TResult? Function(AllProvidersExhausted value)? allProvidersExhausted,
  }) {
    final _that = this;
    switch (_that) {
      case QuotaExceeded() when quotaExceeded != null:
        return quotaExceeded(_that);
      case NetworkAIError() when networkError != null:
        return networkError(_that);
      case InvalidAIResponse() when invalidResponse != null:
        return invalidResponse(_that);
      case TimeoutAIError() when timeout != null:
        return timeout(_that);
      case InvalidAIRequest() when invalidRequest != null:
        return invalidRequest(_that);
      case AllProvidersExhausted() when allProvidersExhausted != null:
        return allProvidersExhausted(_that);
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
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String provider, String? message)? quotaExceeded,
    TResult Function(String provider, String message)? networkError,
    TResult Function(String provider, String message)? invalidResponse,
    TResult Function(String provider, String message)? timeout,
    TResult Function(String provider, String message)? invalidRequest,
    TResult Function(String message)? allProvidersExhausted,
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case QuotaExceeded() when quotaExceeded != null:
        return quotaExceeded(_that.provider, _that.message);
      case NetworkAIError() when networkError != null:
        return networkError(_that.provider, _that.message);
      case InvalidAIResponse() when invalidResponse != null:
        return invalidResponse(_that.provider, _that.message);
      case TimeoutAIError() when timeout != null:
        return timeout(_that.provider, _that.message);
      case InvalidAIRequest() when invalidRequest != null:
        return invalidRequest(_that.provider, _that.message);
      case AllProvidersExhausted() when allProvidersExhausted != null:
        return allProvidersExhausted(_that.message);
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
  TResult when<TResult extends Object?>({
    required TResult Function(String provider, String? message) quotaExceeded,
    required TResult Function(String provider, String message) networkError,
    required TResult Function(String provider, String message) invalidResponse,
    required TResult Function(String provider, String message) timeout,
    required TResult Function(String provider, String message) invalidRequest,
    required TResult Function(String message) allProvidersExhausted,
  }) {
    final _that = this;
    switch (_that) {
      case QuotaExceeded():
        return quotaExceeded(_that.provider, _that.message);
      case NetworkAIError():
        return networkError(_that.provider, _that.message);
      case InvalidAIResponse():
        return invalidResponse(_that.provider, _that.message);
      case TimeoutAIError():
        return timeout(_that.provider, _that.message);
      case InvalidAIRequest():
        return invalidRequest(_that.provider, _that.message);
      case AllProvidersExhausted():
        return allProvidersExhausted(_that.message);
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
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String provider, String? message)? quotaExceeded,
    TResult? Function(String provider, String message)? networkError,
    TResult? Function(String provider, String message)? invalidResponse,
    TResult? Function(String provider, String message)? timeout,
    TResult? Function(String provider, String message)? invalidRequest,
    TResult? Function(String message)? allProvidersExhausted,
  }) {
    final _that = this;
    switch (_that) {
      case QuotaExceeded() when quotaExceeded != null:
        return quotaExceeded(_that.provider, _that.message);
      case NetworkAIError() when networkError != null:
        return networkError(_that.provider, _that.message);
      case InvalidAIResponse() when invalidResponse != null:
        return invalidResponse(_that.provider, _that.message);
      case TimeoutAIError() when timeout != null:
        return timeout(_that.provider, _that.message);
      case InvalidAIRequest() when invalidRequest != null:
        return invalidRequest(_that.provider, _that.message);
      case AllProvidersExhausted() when allProvidersExhausted != null:
        return allProvidersExhausted(_that.message);
      case _:
        return null;
    }
  }
}

/// @nodoc

class QuotaExceeded implements AIProviderError {
  const QuotaExceeded({required this.provider, this.message});

  final String provider;
  @override
  final String? message;

  /// Create a copy of AIProviderError
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $QuotaExceededCopyWith<QuotaExceeded> get copyWith =>
      _$QuotaExceededCopyWithImpl<QuotaExceeded>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is QuotaExceeded &&
            (identical(other.provider, provider) ||
                other.provider == provider) &&
            (identical(other.message, message) || other.message == message));
  }

  @override
  int get hashCode => Object.hash(runtimeType, provider, message);

  @override
  String toString() {
    return 'AIProviderError.quotaExceeded(provider: $provider, message: $message)';
  }
}

/// @nodoc
abstract mixin class $QuotaExceededCopyWith<$Res>
    implements $AIProviderErrorCopyWith<$Res> {
  factory $QuotaExceededCopyWith(
          QuotaExceeded value, $Res Function(QuotaExceeded) _then) =
      _$QuotaExceededCopyWithImpl;
  @override
  @useResult
  $Res call({String provider, String? message});
}

/// @nodoc
class _$QuotaExceededCopyWithImpl<$Res>
    implements $QuotaExceededCopyWith<$Res> {
  _$QuotaExceededCopyWithImpl(this._self, this._then);

  final QuotaExceeded _self;
  final $Res Function(QuotaExceeded) _then;

  /// Create a copy of AIProviderError
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? provider = null,
    Object? message = freezed,
  }) {
    return _then(QuotaExceeded(
      provider: null == provider
          ? _self.provider
          : provider // ignore: cast_nullable_to_non_nullable
              as String,
      message: freezed == message
          ? _self.message
          : message // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc

class NetworkAIError implements AIProviderError {
  const NetworkAIError({required this.provider, required this.message});

  final String provider;
  @override
  final String message;

  /// Create a copy of AIProviderError
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $NetworkAIErrorCopyWith<NetworkAIError> get copyWith =>
      _$NetworkAIErrorCopyWithImpl<NetworkAIError>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is NetworkAIError &&
            (identical(other.provider, provider) ||
                other.provider == provider) &&
            (identical(other.message, message) || other.message == message));
  }

  @override
  int get hashCode => Object.hash(runtimeType, provider, message);

  @override
  String toString() {
    return 'AIProviderError.networkError(provider: $provider, message: $message)';
  }
}

/// @nodoc
abstract mixin class $NetworkAIErrorCopyWith<$Res>
    implements $AIProviderErrorCopyWith<$Res> {
  factory $NetworkAIErrorCopyWith(
          NetworkAIError value, $Res Function(NetworkAIError) _then) =
      _$NetworkAIErrorCopyWithImpl;
  @override
  @useResult
  $Res call({String provider, String message});
}

/// @nodoc
class _$NetworkAIErrorCopyWithImpl<$Res>
    implements $NetworkAIErrorCopyWith<$Res> {
  _$NetworkAIErrorCopyWithImpl(this._self, this._then);

  final NetworkAIError _self;
  final $Res Function(NetworkAIError) _then;

  /// Create a copy of AIProviderError
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? provider = null,
    Object? message = null,
  }) {
    return _then(NetworkAIError(
      provider: null == provider
          ? _self.provider
          : provider // ignore: cast_nullable_to_non_nullable
              as String,
      message: null == message
          ? _self.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class InvalidAIResponse implements AIProviderError {
  const InvalidAIResponse({required this.provider, required this.message});

  final String provider;
  @override
  final String message;

  /// Create a copy of AIProviderError
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $InvalidAIResponseCopyWith<InvalidAIResponse> get copyWith =>
      _$InvalidAIResponseCopyWithImpl<InvalidAIResponse>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is InvalidAIResponse &&
            (identical(other.provider, provider) ||
                other.provider == provider) &&
            (identical(other.message, message) || other.message == message));
  }

  @override
  int get hashCode => Object.hash(runtimeType, provider, message);

  @override
  String toString() {
    return 'AIProviderError.invalidResponse(provider: $provider, message: $message)';
  }
}

/// @nodoc
abstract mixin class $InvalidAIResponseCopyWith<$Res>
    implements $AIProviderErrorCopyWith<$Res> {
  factory $InvalidAIResponseCopyWith(
          InvalidAIResponse value, $Res Function(InvalidAIResponse) _then) =
      _$InvalidAIResponseCopyWithImpl;
  @override
  @useResult
  $Res call({String provider, String message});
}

/// @nodoc
class _$InvalidAIResponseCopyWithImpl<$Res>
    implements $InvalidAIResponseCopyWith<$Res> {
  _$InvalidAIResponseCopyWithImpl(this._self, this._then);

  final InvalidAIResponse _self;
  final $Res Function(InvalidAIResponse) _then;

  /// Create a copy of AIProviderError
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? provider = null,
    Object? message = null,
  }) {
    return _then(InvalidAIResponse(
      provider: null == provider
          ? _self.provider
          : provider // ignore: cast_nullable_to_non_nullable
              as String,
      message: null == message
          ? _self.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class TimeoutAIError implements AIProviderError {
  const TimeoutAIError({required this.provider, required this.message});

  final String provider;
  @override
  final String message;

  /// Create a copy of AIProviderError
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $TimeoutAIErrorCopyWith<TimeoutAIError> get copyWith =>
      _$TimeoutAIErrorCopyWithImpl<TimeoutAIError>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is TimeoutAIError &&
            (identical(other.provider, provider) ||
                other.provider == provider) &&
            (identical(other.message, message) || other.message == message));
  }

  @override
  int get hashCode => Object.hash(runtimeType, provider, message);

  @override
  String toString() {
    return 'AIProviderError.timeout(provider: $provider, message: $message)';
  }
}

/// @nodoc
abstract mixin class $TimeoutAIErrorCopyWith<$Res>
    implements $AIProviderErrorCopyWith<$Res> {
  factory $TimeoutAIErrorCopyWith(
          TimeoutAIError value, $Res Function(TimeoutAIError) _then) =
      _$TimeoutAIErrorCopyWithImpl;
  @override
  @useResult
  $Res call({String provider, String message});
}

/// @nodoc
class _$TimeoutAIErrorCopyWithImpl<$Res>
    implements $TimeoutAIErrorCopyWith<$Res> {
  _$TimeoutAIErrorCopyWithImpl(this._self, this._then);

  final TimeoutAIError _self;
  final $Res Function(TimeoutAIError) _then;

  /// Create a copy of AIProviderError
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? provider = null,
    Object? message = null,
  }) {
    return _then(TimeoutAIError(
      provider: null == provider
          ? _self.provider
          : provider // ignore: cast_nullable_to_non_nullable
              as String,
      message: null == message
          ? _self.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class InvalidAIRequest implements AIProviderError {
  const InvalidAIRequest({required this.provider, required this.message});

  final String provider;
  @override
  final String message;

  /// Create a copy of AIProviderError
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $InvalidAIRequestCopyWith<InvalidAIRequest> get copyWith =>
      _$InvalidAIRequestCopyWithImpl<InvalidAIRequest>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is InvalidAIRequest &&
            (identical(other.provider, provider) ||
                other.provider == provider) &&
            (identical(other.message, message) || other.message == message));
  }

  @override
  int get hashCode => Object.hash(runtimeType, provider, message);

  @override
  String toString() {
    return 'AIProviderError.invalidRequest(provider: $provider, message: $message)';
  }
}

/// @nodoc
abstract mixin class $InvalidAIRequestCopyWith<$Res>
    implements $AIProviderErrorCopyWith<$Res> {
  factory $InvalidAIRequestCopyWith(
          InvalidAIRequest value, $Res Function(InvalidAIRequest) _then) =
      _$InvalidAIRequestCopyWithImpl;
  @override
  @useResult
  $Res call({String provider, String message});
}

/// @nodoc
class _$InvalidAIRequestCopyWithImpl<$Res>
    implements $InvalidAIRequestCopyWith<$Res> {
  _$InvalidAIRequestCopyWithImpl(this._self, this._then);

  final InvalidAIRequest _self;
  final $Res Function(InvalidAIRequest) _then;

  /// Create a copy of AIProviderError
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? provider = null,
    Object? message = null,
  }) {
    return _then(InvalidAIRequest(
      provider: null == provider
          ? _self.provider
          : provider // ignore: cast_nullable_to_non_nullable
              as String,
      message: null == message
          ? _self.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class AllProvidersExhausted implements AIProviderError {
  const AllProvidersExhausted(
      {this.message =
          'All configured AI providers are exhausted or unavailable.'});

  @override
  @JsonKey()
  final String message;

  /// Create a copy of AIProviderError
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $AllProvidersExhaustedCopyWith<AllProvidersExhausted> get copyWith =>
      _$AllProvidersExhaustedCopyWithImpl<AllProvidersExhausted>(
          this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is AllProvidersExhausted &&
            (identical(other.message, message) || other.message == message));
  }

  @override
  int get hashCode => Object.hash(runtimeType, message);

  @override
  String toString() {
    return 'AIProviderError.allProvidersExhausted(message: $message)';
  }
}

/// @nodoc
abstract mixin class $AllProvidersExhaustedCopyWith<$Res>
    implements $AIProviderErrorCopyWith<$Res> {
  factory $AllProvidersExhaustedCopyWith(AllProvidersExhausted value,
          $Res Function(AllProvidersExhausted) _then) =
      _$AllProvidersExhaustedCopyWithImpl;
  @override
  @useResult
  $Res call({String message});
}

/// @nodoc
class _$AllProvidersExhaustedCopyWithImpl<$Res>
    implements $AllProvidersExhaustedCopyWith<$Res> {
  _$AllProvidersExhaustedCopyWithImpl(this._self, this._then);

  final AllProvidersExhausted _self;
  final $Res Function(AllProvidersExhausted) _then;

  /// Create a copy of AIProviderError
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? message = null,
  }) {
    return _then(AllProvidersExhausted(
      message: null == message
          ? _self.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

// dart format on
