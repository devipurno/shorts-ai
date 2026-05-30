// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'subtitle.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$Subtitle {
  String get id;
  @JsonKey(name: 'project_id')
  String get projectId;
  String get language;
  SubtitleFormat get format;
  List<SubtitleSegment> get segments;
  SubtitleStyle get style;

  /// Create a copy of Subtitle
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $SubtitleCopyWith<Subtitle> get copyWith =>
      _$SubtitleCopyWithImpl<Subtitle>(this as Subtitle, _$identity);

  /// Serializes this Subtitle to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is Subtitle &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.projectId, projectId) ||
                other.projectId == projectId) &&
            (identical(other.language, language) ||
                other.language == language) &&
            (identical(other.format, format) || other.format == format) &&
            const DeepCollectionEquality().equals(other.segments, segments) &&
            (identical(other.style, style) || other.style == style));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, projectId, language, format,
      const DeepCollectionEquality().hash(segments), style);

  @override
  String toString() {
    return 'Subtitle(id: $id, projectId: $projectId, language: $language, format: $format, segments: $segments, style: $style)';
  }
}

/// @nodoc
abstract mixin class $SubtitleCopyWith<$Res> {
  factory $SubtitleCopyWith(Subtitle value, $Res Function(Subtitle) _then) =
      _$SubtitleCopyWithImpl;
  @useResult
  $Res call(
      {String id,
      @JsonKey(name: 'project_id') String projectId,
      String language,
      SubtitleFormat format,
      List<SubtitleSegment> segments,
      SubtitleStyle style});

  $SubtitleStyleCopyWith<$Res> get style;
}

/// @nodoc
class _$SubtitleCopyWithImpl<$Res> implements $SubtitleCopyWith<$Res> {
  _$SubtitleCopyWithImpl(this._self, this._then);

  final Subtitle _self;
  final $Res Function(Subtitle) _then;

  /// Create a copy of Subtitle
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? projectId = null,
    Object? language = null,
    Object? format = null,
    Object? segments = null,
    Object? style = null,
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
      language: null == language
          ? _self.language
          : language // ignore: cast_nullable_to_non_nullable
              as String,
      format: null == format
          ? _self.format
          : format // ignore: cast_nullable_to_non_nullable
              as SubtitleFormat,
      segments: null == segments
          ? _self.segments
          : segments // ignore: cast_nullable_to_non_nullable
              as List<SubtitleSegment>,
      style: null == style
          ? _self.style
          : style // ignore: cast_nullable_to_non_nullable
              as SubtitleStyle,
    ));
  }

  /// Create a copy of Subtitle
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $SubtitleStyleCopyWith<$Res> get style {
    return $SubtitleStyleCopyWith<$Res>(_self.style, (value) {
      return _then(_self.copyWith(style: value));
    });
  }
}

/// Adds pattern-matching-related methods to [Subtitle].
extension SubtitlePatterns on Subtitle {
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
    TResult Function(_Subtitle value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _Subtitle() when $default != null:
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
    TResult Function(_Subtitle value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _Subtitle():
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
    TResult? Function(_Subtitle value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _Subtitle() when $default != null:
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
            String language,
            SubtitleFormat format,
            List<SubtitleSegment> segments,
            SubtitleStyle style)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _Subtitle() when $default != null:
        return $default(_that.id, _that.projectId, _that.language, _that.format,
            _that.segments, _that.style);
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
            String language,
            SubtitleFormat format,
            List<SubtitleSegment> segments,
            SubtitleStyle style)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _Subtitle():
        return $default(_that.id, _that.projectId, _that.language, _that.format,
            _that.segments, _that.style);
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
            String language,
            SubtitleFormat format,
            List<SubtitleSegment> segments,
            SubtitleStyle style)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _Subtitle() when $default != null:
        return $default(_that.id, _that.projectId, _that.language, _that.format,
            _that.segments, _that.style);
      case _:
        return null;
    }
  }
}

/// @nodoc

@JsonSerializable(explicitToJson: true)
class _Subtitle implements Subtitle {
  const _Subtitle(
      {required this.id,
      @JsonKey(name: 'project_id') required this.projectId,
      this.language = 'id',
      this.format = SubtitleFormat.ass,
      final List<SubtitleSegment> segments = const <SubtitleSegment>[],
      this.style = const SubtitleStyle()})
      : _segments = segments;
  factory _Subtitle.fromJson(Map<String, dynamic> json) =>
      _$SubtitleFromJson(json);

  @override
  final String id;
  @override
  @JsonKey(name: 'project_id')
  final String projectId;
  @override
  @JsonKey()
  final String language;
  @override
  @JsonKey()
  final SubtitleFormat format;
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

  /// Create a copy of Subtitle
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$SubtitleCopyWith<_Subtitle> get copyWith =>
      __$SubtitleCopyWithImpl<_Subtitle>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$SubtitleToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _Subtitle &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.projectId, projectId) ||
                other.projectId == projectId) &&
            (identical(other.language, language) ||
                other.language == language) &&
            (identical(other.format, format) || other.format == format) &&
            const DeepCollectionEquality().equals(other._segments, _segments) &&
            (identical(other.style, style) || other.style == style));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, projectId, language, format,
      const DeepCollectionEquality().hash(_segments), style);

  @override
  String toString() {
    return 'Subtitle(id: $id, projectId: $projectId, language: $language, format: $format, segments: $segments, style: $style)';
  }
}

/// @nodoc
abstract mixin class _$SubtitleCopyWith<$Res>
    implements $SubtitleCopyWith<$Res> {
  factory _$SubtitleCopyWith(_Subtitle value, $Res Function(_Subtitle) _then) =
      __$SubtitleCopyWithImpl;
  @override
  @useResult
  $Res call(
      {String id,
      @JsonKey(name: 'project_id') String projectId,
      String language,
      SubtitleFormat format,
      List<SubtitleSegment> segments,
      SubtitleStyle style});

  @override
  $SubtitleStyleCopyWith<$Res> get style;
}

/// @nodoc
class __$SubtitleCopyWithImpl<$Res> implements _$SubtitleCopyWith<$Res> {
  __$SubtitleCopyWithImpl(this._self, this._then);

  final _Subtitle _self;
  final $Res Function(_Subtitle) _then;

  /// Create a copy of Subtitle
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? id = null,
    Object? projectId = null,
    Object? language = null,
    Object? format = null,
    Object? segments = null,
    Object? style = null,
  }) {
    return _then(_Subtitle(
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      projectId: null == projectId
          ? _self.projectId
          : projectId // ignore: cast_nullable_to_non_nullable
              as String,
      language: null == language
          ? _self.language
          : language // ignore: cast_nullable_to_non_nullable
              as String,
      format: null == format
          ? _self.format
          : format // ignore: cast_nullable_to_non_nullable
              as SubtitleFormat,
      segments: null == segments
          ? _self._segments
          : segments // ignore: cast_nullable_to_non_nullable
              as List<SubtitleSegment>,
      style: null == style
          ? _self.style
          : style // ignore: cast_nullable_to_non_nullable
              as SubtitleStyle,
    ));
  }

  /// Create a copy of Subtitle
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $SubtitleStyleCopyWith<$Res> get style {
    return $SubtitleStyleCopyWith<$Res>(_self.style, (value) {
      return _then(_self.copyWith(style: value));
    });
  }
}

/// @nodoc
mixin _$SubtitleSegment {
  @JsonKey(name: 'start_ms')
  int get startMs;
  @JsonKey(name: 'end_ms')
  int get endMs;
  String get text;
  List<Word> get words;

  /// Create a copy of SubtitleSegment
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $SubtitleSegmentCopyWith<SubtitleSegment> get copyWith =>
      _$SubtitleSegmentCopyWithImpl<SubtitleSegment>(
          this as SubtitleSegment, _$identity);

  /// Serializes this SubtitleSegment to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is SubtitleSegment &&
            (identical(other.startMs, startMs) || other.startMs == startMs) &&
            (identical(other.endMs, endMs) || other.endMs == endMs) &&
            (identical(other.text, text) || other.text == text) &&
            const DeepCollectionEquality().equals(other.words, words));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, startMs, endMs, text,
      const DeepCollectionEquality().hash(words));

  @override
  String toString() {
    return 'SubtitleSegment(startMs: $startMs, endMs: $endMs, text: $text, words: $words)';
  }
}

/// @nodoc
abstract mixin class $SubtitleSegmentCopyWith<$Res> {
  factory $SubtitleSegmentCopyWith(
          SubtitleSegment value, $Res Function(SubtitleSegment) _then) =
      _$SubtitleSegmentCopyWithImpl;
  @useResult
  $Res call(
      {@JsonKey(name: 'start_ms') int startMs,
      @JsonKey(name: 'end_ms') int endMs,
      String text,
      List<Word> words});
}

/// @nodoc
class _$SubtitleSegmentCopyWithImpl<$Res>
    implements $SubtitleSegmentCopyWith<$Res> {
  _$SubtitleSegmentCopyWithImpl(this._self, this._then);

  final SubtitleSegment _self;
  final $Res Function(SubtitleSegment) _then;

  /// Create a copy of SubtitleSegment
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? startMs = null,
    Object? endMs = null,
    Object? text = null,
    Object? words = null,
  }) {
    return _then(_self.copyWith(
      startMs: null == startMs
          ? _self.startMs
          : startMs // ignore: cast_nullable_to_non_nullable
              as int,
      endMs: null == endMs
          ? _self.endMs
          : endMs // ignore: cast_nullable_to_non_nullable
              as int,
      text: null == text
          ? _self.text
          : text // ignore: cast_nullable_to_non_nullable
              as String,
      words: null == words
          ? _self.words
          : words // ignore: cast_nullable_to_non_nullable
              as List<Word>,
    ));
  }
}

/// Adds pattern-matching-related methods to [SubtitleSegment].
extension SubtitleSegmentPatterns on SubtitleSegment {
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
    TResult Function(_SubtitleSegment value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _SubtitleSegment() when $default != null:
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
    TResult Function(_SubtitleSegment value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _SubtitleSegment():
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
    TResult? Function(_SubtitleSegment value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _SubtitleSegment() when $default != null:
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
    TResult Function(@JsonKey(name: 'start_ms') int startMs,
            @JsonKey(name: 'end_ms') int endMs, String text, List<Word> words)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _SubtitleSegment() when $default != null:
        return $default(_that.startMs, _that.endMs, _that.text, _that.words);
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
    TResult Function(@JsonKey(name: 'start_ms') int startMs,
            @JsonKey(name: 'end_ms') int endMs, String text, List<Word> words)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _SubtitleSegment():
        return $default(_that.startMs, _that.endMs, _that.text, _that.words);
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
    TResult? Function(@JsonKey(name: 'start_ms') int startMs,
            @JsonKey(name: 'end_ms') int endMs, String text, List<Word> words)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _SubtitleSegment() when $default != null:
        return $default(_that.startMs, _that.endMs, _that.text, _that.words);
      case _:
        return null;
    }
  }
}

/// @nodoc

@JsonSerializable(explicitToJson: true)
class _SubtitleSegment implements SubtitleSegment {
  const _SubtitleSegment(
      {@JsonKey(name: 'start_ms') this.startMs = 0,
      @JsonKey(name: 'end_ms') this.endMs = 0,
      this.text = '',
      final List<Word> words = const <Word>[]})
      : _words = words;
  factory _SubtitleSegment.fromJson(Map<String, dynamic> json) =>
      _$SubtitleSegmentFromJson(json);

  @override
  @JsonKey(name: 'start_ms')
  final int startMs;
  @override
  @JsonKey(name: 'end_ms')
  final int endMs;
  @override
  @JsonKey()
  final String text;
  final List<Word> _words;
  @override
  @JsonKey()
  List<Word> get words {
    if (_words is EqualUnmodifiableListView) return _words;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_words);
  }

  /// Create a copy of SubtitleSegment
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$SubtitleSegmentCopyWith<_SubtitleSegment> get copyWith =>
      __$SubtitleSegmentCopyWithImpl<_SubtitleSegment>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$SubtitleSegmentToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _SubtitleSegment &&
            (identical(other.startMs, startMs) || other.startMs == startMs) &&
            (identical(other.endMs, endMs) || other.endMs == endMs) &&
            (identical(other.text, text) || other.text == text) &&
            const DeepCollectionEquality().equals(other._words, _words));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, startMs, endMs, text,
      const DeepCollectionEquality().hash(_words));

  @override
  String toString() {
    return 'SubtitleSegment(startMs: $startMs, endMs: $endMs, text: $text, words: $words)';
  }
}

/// @nodoc
abstract mixin class _$SubtitleSegmentCopyWith<$Res>
    implements $SubtitleSegmentCopyWith<$Res> {
  factory _$SubtitleSegmentCopyWith(
          _SubtitleSegment value, $Res Function(_SubtitleSegment) _then) =
      __$SubtitleSegmentCopyWithImpl;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: 'start_ms') int startMs,
      @JsonKey(name: 'end_ms') int endMs,
      String text,
      List<Word> words});
}

/// @nodoc
class __$SubtitleSegmentCopyWithImpl<$Res>
    implements _$SubtitleSegmentCopyWith<$Res> {
  __$SubtitleSegmentCopyWithImpl(this._self, this._then);

  final _SubtitleSegment _self;
  final $Res Function(_SubtitleSegment) _then;

  /// Create a copy of SubtitleSegment
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? startMs = null,
    Object? endMs = null,
    Object? text = null,
    Object? words = null,
  }) {
    return _then(_SubtitleSegment(
      startMs: null == startMs
          ? _self.startMs
          : startMs // ignore: cast_nullable_to_non_nullable
              as int,
      endMs: null == endMs
          ? _self.endMs
          : endMs // ignore: cast_nullable_to_non_nullable
              as int,
      text: null == text
          ? _self.text
          : text // ignore: cast_nullable_to_non_nullable
              as String,
      words: null == words
          ? _self._words
          : words // ignore: cast_nullable_to_non_nullable
              as List<Word>,
    ));
  }
}

/// @nodoc
mixin _$Word {
  String get text;
  @JsonKey(name: 'start_ms')
  int get startMs;
  @JsonKey(name: 'end_ms')
  int get endMs;

  /// Create a copy of Word
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $WordCopyWith<Word> get copyWith =>
      _$WordCopyWithImpl<Word>(this as Word, _$identity);

  /// Serializes this Word to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is Word &&
            (identical(other.text, text) || other.text == text) &&
            (identical(other.startMs, startMs) || other.startMs == startMs) &&
            (identical(other.endMs, endMs) || other.endMs == endMs));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, text, startMs, endMs);

  @override
  String toString() {
    return 'Word(text: $text, startMs: $startMs, endMs: $endMs)';
  }
}

/// @nodoc
abstract mixin class $WordCopyWith<$Res> {
  factory $WordCopyWith(Word value, $Res Function(Word) _then) =
      _$WordCopyWithImpl;
  @useResult
  $Res call(
      {String text,
      @JsonKey(name: 'start_ms') int startMs,
      @JsonKey(name: 'end_ms') int endMs});
}

/// @nodoc
class _$WordCopyWithImpl<$Res> implements $WordCopyWith<$Res> {
  _$WordCopyWithImpl(this._self, this._then);

  final Word _self;
  final $Res Function(Word) _then;

  /// Create a copy of Word
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? text = null,
    Object? startMs = null,
    Object? endMs = null,
  }) {
    return _then(_self.copyWith(
      text: null == text
          ? _self.text
          : text // ignore: cast_nullable_to_non_nullable
              as String,
      startMs: null == startMs
          ? _self.startMs
          : startMs // ignore: cast_nullable_to_non_nullable
              as int,
      endMs: null == endMs
          ? _self.endMs
          : endMs // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// Adds pattern-matching-related methods to [Word].
extension WordPatterns on Word {
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
    TResult Function(_Word value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _Word() when $default != null:
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
    TResult Function(_Word value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _Word():
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
    TResult? Function(_Word value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _Word() when $default != null:
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
    TResult Function(String text, @JsonKey(name: 'start_ms') int startMs,
            @JsonKey(name: 'end_ms') int endMs)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _Word() when $default != null:
        return $default(_that.text, _that.startMs, _that.endMs);
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
    TResult Function(String text, @JsonKey(name: 'start_ms') int startMs,
            @JsonKey(name: 'end_ms') int endMs)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _Word():
        return $default(_that.text, _that.startMs, _that.endMs);
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
    TResult? Function(String text, @JsonKey(name: 'start_ms') int startMs,
            @JsonKey(name: 'end_ms') int endMs)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _Word() when $default != null:
        return $default(_that.text, _that.startMs, _that.endMs);
      case _:
        return null;
    }
  }
}

/// @nodoc

@JsonSerializable(explicitToJson: true)
class _Word implements Word {
  const _Word(
      {this.text = '',
      @JsonKey(name: 'start_ms') this.startMs = 0,
      @JsonKey(name: 'end_ms') this.endMs = 0});
  factory _Word.fromJson(Map<String, dynamic> json) => _$WordFromJson(json);

  @override
  @JsonKey()
  final String text;
  @override
  @JsonKey(name: 'start_ms')
  final int startMs;
  @override
  @JsonKey(name: 'end_ms')
  final int endMs;

  /// Create a copy of Word
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$WordCopyWith<_Word> get copyWith =>
      __$WordCopyWithImpl<_Word>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$WordToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _Word &&
            (identical(other.text, text) || other.text == text) &&
            (identical(other.startMs, startMs) || other.startMs == startMs) &&
            (identical(other.endMs, endMs) || other.endMs == endMs));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, text, startMs, endMs);

  @override
  String toString() {
    return 'Word(text: $text, startMs: $startMs, endMs: $endMs)';
  }
}

/// @nodoc
abstract mixin class _$WordCopyWith<$Res> implements $WordCopyWith<$Res> {
  factory _$WordCopyWith(_Word value, $Res Function(_Word) _then) =
      __$WordCopyWithImpl;
  @override
  @useResult
  $Res call(
      {String text,
      @JsonKey(name: 'start_ms') int startMs,
      @JsonKey(name: 'end_ms') int endMs});
}

/// @nodoc
class __$WordCopyWithImpl<$Res> implements _$WordCopyWith<$Res> {
  __$WordCopyWithImpl(this._self, this._then);

  final _Word _self;
  final $Res Function(_Word) _then;

  /// Create a copy of Word
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? text = null,
    Object? startMs = null,
    Object? endMs = null,
  }) {
    return _then(_Word(
      text: null == text
          ? _self.text
          : text // ignore: cast_nullable_to_non_nullable
              as String,
      startMs: null == startMs
          ? _self.startMs
          : startMs // ignore: cast_nullable_to_non_nullable
              as int,
      endMs: null == endMs
          ? _self.endMs
          : endMs // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
mixin _$SubtitleStyle {
  @JsonKey(name: 'font_family')
  String get fontFamily;
  @JsonKey(name: 'font_size')
  double get fontSize;
  @JsonKey(name: 'font_color')
  String get fontColor;
  @JsonKey(name: 'stroke_color')
  String get strokeColor;
  String get position;
  String get animation;

  /// Create a copy of SubtitleStyle
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $SubtitleStyleCopyWith<SubtitleStyle> get copyWith =>
      _$SubtitleStyleCopyWithImpl<SubtitleStyle>(
          this as SubtitleStyle, _$identity);

  /// Serializes this SubtitleStyle to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is SubtitleStyle &&
            (identical(other.fontFamily, fontFamily) ||
                other.fontFamily == fontFamily) &&
            (identical(other.fontSize, fontSize) ||
                other.fontSize == fontSize) &&
            (identical(other.fontColor, fontColor) ||
                other.fontColor == fontColor) &&
            (identical(other.strokeColor, strokeColor) ||
                other.strokeColor == strokeColor) &&
            (identical(other.position, position) ||
                other.position == position) &&
            (identical(other.animation, animation) ||
                other.animation == animation));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, fontFamily, fontSize, fontColor,
      strokeColor, position, animation);

  @override
  String toString() {
    return 'SubtitleStyle(fontFamily: $fontFamily, fontSize: $fontSize, fontColor: $fontColor, strokeColor: $strokeColor, position: $position, animation: $animation)';
  }
}

/// @nodoc
abstract mixin class $SubtitleStyleCopyWith<$Res> {
  factory $SubtitleStyleCopyWith(
          SubtitleStyle value, $Res Function(SubtitleStyle) _then) =
      _$SubtitleStyleCopyWithImpl;
  @useResult
  $Res call(
      {@JsonKey(name: 'font_family') String fontFamily,
      @JsonKey(name: 'font_size') double fontSize,
      @JsonKey(name: 'font_color') String fontColor,
      @JsonKey(name: 'stroke_color') String strokeColor,
      String position,
      String animation});
}

/// @nodoc
class _$SubtitleStyleCopyWithImpl<$Res>
    implements $SubtitleStyleCopyWith<$Res> {
  _$SubtitleStyleCopyWithImpl(this._self, this._then);

  final SubtitleStyle _self;
  final $Res Function(SubtitleStyle) _then;

  /// Create a copy of SubtitleStyle
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? fontFamily = null,
    Object? fontSize = null,
    Object? fontColor = null,
    Object? strokeColor = null,
    Object? position = null,
    Object? animation = null,
  }) {
    return _then(_self.copyWith(
      fontFamily: null == fontFamily
          ? _self.fontFamily
          : fontFamily // ignore: cast_nullable_to_non_nullable
              as String,
      fontSize: null == fontSize
          ? _self.fontSize
          : fontSize // ignore: cast_nullable_to_non_nullable
              as double,
      fontColor: null == fontColor
          ? _self.fontColor
          : fontColor // ignore: cast_nullable_to_non_nullable
              as String,
      strokeColor: null == strokeColor
          ? _self.strokeColor
          : strokeColor // ignore: cast_nullable_to_non_nullable
              as String,
      position: null == position
          ? _self.position
          : position // ignore: cast_nullable_to_non_nullable
              as String,
      animation: null == animation
          ? _self.animation
          : animation // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// Adds pattern-matching-related methods to [SubtitleStyle].
extension SubtitleStylePatterns on SubtitleStyle {
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
    TResult Function(_SubtitleStyle value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _SubtitleStyle() when $default != null:
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
    TResult Function(_SubtitleStyle value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _SubtitleStyle():
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
    TResult? Function(_SubtitleStyle value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _SubtitleStyle() when $default != null:
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
            @JsonKey(name: 'font_family') String fontFamily,
            @JsonKey(name: 'font_size') double fontSize,
            @JsonKey(name: 'font_color') String fontColor,
            @JsonKey(name: 'stroke_color') String strokeColor,
            String position,
            String animation)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _SubtitleStyle() when $default != null:
        return $default(_that.fontFamily, _that.fontSize, _that.fontColor,
            _that.strokeColor, _that.position, _that.animation);
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
            @JsonKey(name: 'font_family') String fontFamily,
            @JsonKey(name: 'font_size') double fontSize,
            @JsonKey(name: 'font_color') String fontColor,
            @JsonKey(name: 'stroke_color') String strokeColor,
            String position,
            String animation)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _SubtitleStyle():
        return $default(_that.fontFamily, _that.fontSize, _that.fontColor,
            _that.strokeColor, _that.position, _that.animation);
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
            @JsonKey(name: 'font_family') String fontFamily,
            @JsonKey(name: 'font_size') double fontSize,
            @JsonKey(name: 'font_color') String fontColor,
            @JsonKey(name: 'stroke_color') String strokeColor,
            String position,
            String animation)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _SubtitleStyle() when $default != null:
        return $default(_that.fontFamily, _that.fontSize, _that.fontColor,
            _that.strokeColor, _that.position, _that.animation);
      case _:
        return null;
    }
  }
}

/// @nodoc

@JsonSerializable(explicitToJson: true)
class _SubtitleStyle implements SubtitleStyle {
  const _SubtitleStyle(
      {@JsonKey(name: 'font_family') this.fontFamily = 'Inter',
      @JsonKey(name: 'font_size') this.fontSize = 42,
      @JsonKey(name: 'font_color') this.fontColor = '#FFFFFF',
      @JsonKey(name: 'stroke_color') this.strokeColor = '#0B0C10',
      this.position = 'bottom',
      this.animation = 'karaoke'});
  factory _SubtitleStyle.fromJson(Map<String, dynamic> json) =>
      _$SubtitleStyleFromJson(json);

  @override
  @JsonKey(name: 'font_family')
  final String fontFamily;
  @override
  @JsonKey(name: 'font_size')
  final double fontSize;
  @override
  @JsonKey(name: 'font_color')
  final String fontColor;
  @override
  @JsonKey(name: 'stroke_color')
  final String strokeColor;
  @override
  @JsonKey()
  final String position;
  @override
  @JsonKey()
  final String animation;

  /// Create a copy of SubtitleStyle
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$SubtitleStyleCopyWith<_SubtitleStyle> get copyWith =>
      __$SubtitleStyleCopyWithImpl<_SubtitleStyle>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$SubtitleStyleToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _SubtitleStyle &&
            (identical(other.fontFamily, fontFamily) ||
                other.fontFamily == fontFamily) &&
            (identical(other.fontSize, fontSize) ||
                other.fontSize == fontSize) &&
            (identical(other.fontColor, fontColor) ||
                other.fontColor == fontColor) &&
            (identical(other.strokeColor, strokeColor) ||
                other.strokeColor == strokeColor) &&
            (identical(other.position, position) ||
                other.position == position) &&
            (identical(other.animation, animation) ||
                other.animation == animation));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, fontFamily, fontSize, fontColor,
      strokeColor, position, animation);

  @override
  String toString() {
    return 'SubtitleStyle(fontFamily: $fontFamily, fontSize: $fontSize, fontColor: $fontColor, strokeColor: $strokeColor, position: $position, animation: $animation)';
  }
}

/// @nodoc
abstract mixin class _$SubtitleStyleCopyWith<$Res>
    implements $SubtitleStyleCopyWith<$Res> {
  factory _$SubtitleStyleCopyWith(
          _SubtitleStyle value, $Res Function(_SubtitleStyle) _then) =
      __$SubtitleStyleCopyWithImpl;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: 'font_family') String fontFamily,
      @JsonKey(name: 'font_size') double fontSize,
      @JsonKey(name: 'font_color') String fontColor,
      @JsonKey(name: 'stroke_color') String strokeColor,
      String position,
      String animation});
}

/// @nodoc
class __$SubtitleStyleCopyWithImpl<$Res>
    implements _$SubtitleStyleCopyWith<$Res> {
  __$SubtitleStyleCopyWithImpl(this._self, this._then);

  final _SubtitleStyle _self;
  final $Res Function(_SubtitleStyle) _then;

  /// Create a copy of SubtitleStyle
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? fontFamily = null,
    Object? fontSize = null,
    Object? fontColor = null,
    Object? strokeColor = null,
    Object? position = null,
    Object? animation = null,
  }) {
    return _then(_SubtitleStyle(
      fontFamily: null == fontFamily
          ? _self.fontFamily
          : fontFamily // ignore: cast_nullable_to_non_nullable
              as String,
      fontSize: null == fontSize
          ? _self.fontSize
          : fontSize // ignore: cast_nullable_to_non_nullable
              as double,
      fontColor: null == fontColor
          ? _self.fontColor
          : fontColor // ignore: cast_nullable_to_non_nullable
              as String,
      strokeColor: null == strokeColor
          ? _self.strokeColor
          : strokeColor // ignore: cast_nullable_to_non_nullable
              as String,
      position: null == position
          ? _self.position
          : position // ignore: cast_nullable_to_non_nullable
              as String,
      animation: null == animation
          ? _self.animation
          : animation // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

// dart format on
