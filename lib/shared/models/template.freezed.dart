// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'template.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$Template {
  String get id;
  String get name;
  String get description;
  String get category;
  @JsonKey(name: 'thumbnail_url')
  String? get thumbnailUrl;
  @JsonKey(name: 'preview_video_url')
  String? get previewVideoUrl;
  TemplateStructure get structure;
  TemplateDifficulty get difficulty;
  TemplateTier get tier;
  @JsonKey(name: 'times_used')
  int get timesUsed;
  double get rating;

  /// Create a copy of Template
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $TemplateCopyWith<Template> get copyWith =>
      _$TemplateCopyWithImpl<Template>(this as Template, _$identity);

  /// Serializes this Template to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is Template &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.category, category) ||
                other.category == category) &&
            (identical(other.thumbnailUrl, thumbnailUrl) ||
                other.thumbnailUrl == thumbnailUrl) &&
            (identical(other.previewVideoUrl, previewVideoUrl) ||
                other.previewVideoUrl == previewVideoUrl) &&
            (identical(other.structure, structure) ||
                other.structure == structure) &&
            (identical(other.difficulty, difficulty) ||
                other.difficulty == difficulty) &&
            (identical(other.tier, tier) || other.tier == tier) &&
            (identical(other.timesUsed, timesUsed) ||
                other.timesUsed == timesUsed) &&
            (identical(other.rating, rating) || other.rating == rating));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      name,
      description,
      category,
      thumbnailUrl,
      previewVideoUrl,
      structure,
      difficulty,
      tier,
      timesUsed,
      rating);

  @override
  String toString() {
    return 'Template(id: $id, name: $name, description: $description, category: $category, thumbnailUrl: $thumbnailUrl, previewVideoUrl: $previewVideoUrl, structure: $structure, difficulty: $difficulty, tier: $tier, timesUsed: $timesUsed, rating: $rating)';
  }
}

/// @nodoc
abstract mixin class $TemplateCopyWith<$Res> {
  factory $TemplateCopyWith(Template value, $Res Function(Template) _then) =
      _$TemplateCopyWithImpl;
  @useResult
  $Res call(
      {String id,
      String name,
      String description,
      String category,
      @JsonKey(name: 'thumbnail_url') String? thumbnailUrl,
      @JsonKey(name: 'preview_video_url') String? previewVideoUrl,
      TemplateStructure structure,
      TemplateDifficulty difficulty,
      TemplateTier tier,
      @JsonKey(name: 'times_used') int timesUsed,
      double rating});

  $TemplateStructureCopyWith<$Res> get structure;
}

/// @nodoc
class _$TemplateCopyWithImpl<$Res> implements $TemplateCopyWith<$Res> {
  _$TemplateCopyWithImpl(this._self, this._then);

  final Template _self;
  final $Res Function(Template) _then;

  /// Create a copy of Template
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? description = null,
    Object? category = null,
    Object? thumbnailUrl = freezed,
    Object? previewVideoUrl = freezed,
    Object? structure = null,
    Object? difficulty = null,
    Object? tier = null,
    Object? timesUsed = null,
    Object? rating = null,
  }) {
    return _then(_self.copyWith(
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _self.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      description: null == description
          ? _self.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      category: null == category
          ? _self.category
          : category // ignore: cast_nullable_to_non_nullable
              as String,
      thumbnailUrl: freezed == thumbnailUrl
          ? _self.thumbnailUrl
          : thumbnailUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      previewVideoUrl: freezed == previewVideoUrl
          ? _self.previewVideoUrl
          : previewVideoUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      structure: null == structure
          ? _self.structure
          : structure // ignore: cast_nullable_to_non_nullable
              as TemplateStructure,
      difficulty: null == difficulty
          ? _self.difficulty
          : difficulty // ignore: cast_nullable_to_non_nullable
              as TemplateDifficulty,
      tier: null == tier
          ? _self.tier
          : tier // ignore: cast_nullable_to_non_nullable
              as TemplateTier,
      timesUsed: null == timesUsed
          ? _self.timesUsed
          : timesUsed // ignore: cast_nullable_to_non_nullable
              as int,
      rating: null == rating
          ? _self.rating
          : rating // ignore: cast_nullable_to_non_nullable
              as double,
    ));
  }

  /// Create a copy of Template
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $TemplateStructureCopyWith<$Res> get structure {
    return $TemplateStructureCopyWith<$Res>(_self.structure, (value) {
      return _then(_self.copyWith(structure: value));
    });
  }
}

/// Adds pattern-matching-related methods to [Template].
extension TemplatePatterns on Template {
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
    TResult Function(_Template value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _Template() when $default != null:
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
    TResult Function(_Template value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _Template():
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
    TResult? Function(_Template value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _Template() when $default != null:
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
            String name,
            String description,
            String category,
            @JsonKey(name: 'thumbnail_url') String? thumbnailUrl,
            @JsonKey(name: 'preview_video_url') String? previewVideoUrl,
            TemplateStructure structure,
            TemplateDifficulty difficulty,
            TemplateTier tier,
            @JsonKey(name: 'times_used') int timesUsed,
            double rating)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _Template() when $default != null:
        return $default(
            _that.id,
            _that.name,
            _that.description,
            _that.category,
            _that.thumbnailUrl,
            _that.previewVideoUrl,
            _that.structure,
            _that.difficulty,
            _that.tier,
            _that.timesUsed,
            _that.rating);
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
            String name,
            String description,
            String category,
            @JsonKey(name: 'thumbnail_url') String? thumbnailUrl,
            @JsonKey(name: 'preview_video_url') String? previewVideoUrl,
            TemplateStructure structure,
            TemplateDifficulty difficulty,
            TemplateTier tier,
            @JsonKey(name: 'times_used') int timesUsed,
            double rating)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _Template():
        return $default(
            _that.id,
            _that.name,
            _that.description,
            _that.category,
            _that.thumbnailUrl,
            _that.previewVideoUrl,
            _that.structure,
            _that.difficulty,
            _that.tier,
            _that.timesUsed,
            _that.rating);
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
            String name,
            String description,
            String category,
            @JsonKey(name: 'thumbnail_url') String? thumbnailUrl,
            @JsonKey(name: 'preview_video_url') String? previewVideoUrl,
            TemplateStructure structure,
            TemplateDifficulty difficulty,
            TemplateTier tier,
            @JsonKey(name: 'times_used') int timesUsed,
            double rating)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _Template() when $default != null:
        return $default(
            _that.id,
            _that.name,
            _that.description,
            _that.category,
            _that.thumbnailUrl,
            _that.previewVideoUrl,
            _that.structure,
            _that.difficulty,
            _that.tier,
            _that.timesUsed,
            _that.rating);
      case _:
        return null;
    }
  }
}

/// @nodoc

@JsonSerializable(explicitToJson: true)
class _Template implements Template {
  const _Template(
      {required this.id,
      this.name = '',
      this.description = '',
      this.category = 'general',
      @JsonKey(name: 'thumbnail_url') this.thumbnailUrl,
      @JsonKey(name: 'preview_video_url') this.previewVideoUrl,
      this.structure = const TemplateStructure(),
      this.difficulty = TemplateDifficulty.easy,
      this.tier = TemplateTier.free,
      @JsonKey(name: 'times_used') this.timesUsed = 0,
      this.rating = 0});
  factory _Template.fromJson(Map<String, dynamic> json) =>
      _$TemplateFromJson(json);

  @override
  final String id;
  @override
  @JsonKey()
  final String name;
  @override
  @JsonKey()
  final String description;
  @override
  @JsonKey()
  final String category;
  @override
  @JsonKey(name: 'thumbnail_url')
  final String? thumbnailUrl;
  @override
  @JsonKey(name: 'preview_video_url')
  final String? previewVideoUrl;
  @override
  @JsonKey()
  final TemplateStructure structure;
  @override
  @JsonKey()
  final TemplateDifficulty difficulty;
  @override
  @JsonKey()
  final TemplateTier tier;
  @override
  @JsonKey(name: 'times_used')
  final int timesUsed;
  @override
  @JsonKey()
  final double rating;

  /// Create a copy of Template
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$TemplateCopyWith<_Template> get copyWith =>
      __$TemplateCopyWithImpl<_Template>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$TemplateToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _Template &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.category, category) ||
                other.category == category) &&
            (identical(other.thumbnailUrl, thumbnailUrl) ||
                other.thumbnailUrl == thumbnailUrl) &&
            (identical(other.previewVideoUrl, previewVideoUrl) ||
                other.previewVideoUrl == previewVideoUrl) &&
            (identical(other.structure, structure) ||
                other.structure == structure) &&
            (identical(other.difficulty, difficulty) ||
                other.difficulty == difficulty) &&
            (identical(other.tier, tier) || other.tier == tier) &&
            (identical(other.timesUsed, timesUsed) ||
                other.timesUsed == timesUsed) &&
            (identical(other.rating, rating) || other.rating == rating));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      name,
      description,
      category,
      thumbnailUrl,
      previewVideoUrl,
      structure,
      difficulty,
      tier,
      timesUsed,
      rating);

  @override
  String toString() {
    return 'Template(id: $id, name: $name, description: $description, category: $category, thumbnailUrl: $thumbnailUrl, previewVideoUrl: $previewVideoUrl, structure: $structure, difficulty: $difficulty, tier: $tier, timesUsed: $timesUsed, rating: $rating)';
  }
}

/// @nodoc
abstract mixin class _$TemplateCopyWith<$Res>
    implements $TemplateCopyWith<$Res> {
  factory _$TemplateCopyWith(_Template value, $Res Function(_Template) _then) =
      __$TemplateCopyWithImpl;
  @override
  @useResult
  $Res call(
      {String id,
      String name,
      String description,
      String category,
      @JsonKey(name: 'thumbnail_url') String? thumbnailUrl,
      @JsonKey(name: 'preview_video_url') String? previewVideoUrl,
      TemplateStructure structure,
      TemplateDifficulty difficulty,
      TemplateTier tier,
      @JsonKey(name: 'times_used') int timesUsed,
      double rating});

  @override
  $TemplateStructureCopyWith<$Res> get structure;
}

/// @nodoc
class __$TemplateCopyWithImpl<$Res> implements _$TemplateCopyWith<$Res> {
  __$TemplateCopyWithImpl(this._self, this._then);

  final _Template _self;
  final $Res Function(_Template) _then;

  /// Create a copy of Template
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? description = null,
    Object? category = null,
    Object? thumbnailUrl = freezed,
    Object? previewVideoUrl = freezed,
    Object? structure = null,
    Object? difficulty = null,
    Object? tier = null,
    Object? timesUsed = null,
    Object? rating = null,
  }) {
    return _then(_Template(
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _self.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      description: null == description
          ? _self.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      category: null == category
          ? _self.category
          : category // ignore: cast_nullable_to_non_nullable
              as String,
      thumbnailUrl: freezed == thumbnailUrl
          ? _self.thumbnailUrl
          : thumbnailUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      previewVideoUrl: freezed == previewVideoUrl
          ? _self.previewVideoUrl
          : previewVideoUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      structure: null == structure
          ? _self.structure
          : structure // ignore: cast_nullable_to_non_nullable
              as TemplateStructure,
      difficulty: null == difficulty
          ? _self.difficulty
          : difficulty // ignore: cast_nullable_to_non_nullable
              as TemplateDifficulty,
      tier: null == tier
          ? _self.tier
          : tier // ignore: cast_nullable_to_non_nullable
              as TemplateTier,
      timesUsed: null == timesUsed
          ? _self.timesUsed
          : timesUsed // ignore: cast_nullable_to_non_nullable
              as int,
      rating: null == rating
          ? _self.rating
          : rating // ignore: cast_nullable_to_non_nullable
              as double,
    ));
  }

  /// Create a copy of Template
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $TemplateStructureCopyWith<$Res> get structure {
    return $TemplateStructureCopyWith<$Res>(_self.structure, (value) {
      return _then(_self.copyWith(structure: value));
    });
  }
}

/// @nodoc
mixin _$TemplateStructure {
  int get duration;
  List<String> get hooks;
  List<String> get segments;
  List<String> get transitions;
  List<String> get music;

  /// Create a copy of TemplateStructure
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $TemplateStructureCopyWith<TemplateStructure> get copyWith =>
      _$TemplateStructureCopyWithImpl<TemplateStructure>(
          this as TemplateStructure, _$identity);

  /// Serializes this TemplateStructure to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is TemplateStructure &&
            (identical(other.duration, duration) ||
                other.duration == duration) &&
            const DeepCollectionEquality().equals(other.hooks, hooks) &&
            const DeepCollectionEquality().equals(other.segments, segments) &&
            const DeepCollectionEquality()
                .equals(other.transitions, transitions) &&
            const DeepCollectionEquality().equals(other.music, music));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      duration,
      const DeepCollectionEquality().hash(hooks),
      const DeepCollectionEquality().hash(segments),
      const DeepCollectionEquality().hash(transitions),
      const DeepCollectionEquality().hash(music));

  @override
  String toString() {
    return 'TemplateStructure(duration: $duration, hooks: $hooks, segments: $segments, transitions: $transitions, music: $music)';
  }
}

/// @nodoc
abstract mixin class $TemplateStructureCopyWith<$Res> {
  factory $TemplateStructureCopyWith(
          TemplateStructure value, $Res Function(TemplateStructure) _then) =
      _$TemplateStructureCopyWithImpl;
  @useResult
  $Res call(
      {int duration,
      List<String> hooks,
      List<String> segments,
      List<String> transitions,
      List<String> music});
}

/// @nodoc
class _$TemplateStructureCopyWithImpl<$Res>
    implements $TemplateStructureCopyWith<$Res> {
  _$TemplateStructureCopyWithImpl(this._self, this._then);

  final TemplateStructure _self;
  final $Res Function(TemplateStructure) _then;

  /// Create a copy of TemplateStructure
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? duration = null,
    Object? hooks = null,
    Object? segments = null,
    Object? transitions = null,
    Object? music = null,
  }) {
    return _then(_self.copyWith(
      duration: null == duration
          ? _self.duration
          : duration // ignore: cast_nullable_to_non_nullable
              as int,
      hooks: null == hooks
          ? _self.hooks
          : hooks // ignore: cast_nullable_to_non_nullable
              as List<String>,
      segments: null == segments
          ? _self.segments
          : segments // ignore: cast_nullable_to_non_nullable
              as List<String>,
      transitions: null == transitions
          ? _self.transitions
          : transitions // ignore: cast_nullable_to_non_nullable
              as List<String>,
      music: null == music
          ? _self.music
          : music // ignore: cast_nullable_to_non_nullable
              as List<String>,
    ));
  }
}

/// Adds pattern-matching-related methods to [TemplateStructure].
extension TemplateStructurePatterns on TemplateStructure {
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
    TResult Function(_TemplateStructure value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _TemplateStructure() when $default != null:
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
    TResult Function(_TemplateStructure value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _TemplateStructure():
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
    TResult? Function(_TemplateStructure value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _TemplateStructure() when $default != null:
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
    TResult Function(int duration, List<String> hooks, List<String> segments,
            List<String> transitions, List<String> music)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _TemplateStructure() when $default != null:
        return $default(_that.duration, _that.hooks, _that.segments,
            _that.transitions, _that.music);
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
    TResult Function(int duration, List<String> hooks, List<String> segments,
            List<String> transitions, List<String> music)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _TemplateStructure():
        return $default(_that.duration, _that.hooks, _that.segments,
            _that.transitions, _that.music);
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
    TResult? Function(int duration, List<String> hooks, List<String> segments,
            List<String> transitions, List<String> music)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _TemplateStructure() when $default != null:
        return $default(_that.duration, _that.hooks, _that.segments,
            _that.transitions, _that.music);
      case _:
        return null;
    }
  }
}

/// @nodoc

@JsonSerializable(explicitToJson: true)
class _TemplateStructure implements TemplateStructure {
  const _TemplateStructure(
      {this.duration = 0,
      final List<String> hooks = const <String>[],
      final List<String> segments = const <String>[],
      final List<String> transitions = const <String>[],
      final List<String> music = const <String>[]})
      : _hooks = hooks,
        _segments = segments,
        _transitions = transitions,
        _music = music;
  factory _TemplateStructure.fromJson(Map<String, dynamic> json) =>
      _$TemplateStructureFromJson(json);

  @override
  @JsonKey()
  final int duration;
  final List<String> _hooks;
  @override
  @JsonKey()
  List<String> get hooks {
    if (_hooks is EqualUnmodifiableListView) return _hooks;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_hooks);
  }

  final List<String> _segments;
  @override
  @JsonKey()
  List<String> get segments {
    if (_segments is EqualUnmodifiableListView) return _segments;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_segments);
  }

  final List<String> _transitions;
  @override
  @JsonKey()
  List<String> get transitions {
    if (_transitions is EqualUnmodifiableListView) return _transitions;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_transitions);
  }

  final List<String> _music;
  @override
  @JsonKey()
  List<String> get music {
    if (_music is EqualUnmodifiableListView) return _music;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_music);
  }

  /// Create a copy of TemplateStructure
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$TemplateStructureCopyWith<_TemplateStructure> get copyWith =>
      __$TemplateStructureCopyWithImpl<_TemplateStructure>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$TemplateStructureToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _TemplateStructure &&
            (identical(other.duration, duration) ||
                other.duration == duration) &&
            const DeepCollectionEquality().equals(other._hooks, _hooks) &&
            const DeepCollectionEquality().equals(other._segments, _segments) &&
            const DeepCollectionEquality()
                .equals(other._transitions, _transitions) &&
            const DeepCollectionEquality().equals(other._music, _music));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      duration,
      const DeepCollectionEquality().hash(_hooks),
      const DeepCollectionEquality().hash(_segments),
      const DeepCollectionEquality().hash(_transitions),
      const DeepCollectionEquality().hash(_music));

  @override
  String toString() {
    return 'TemplateStructure(duration: $duration, hooks: $hooks, segments: $segments, transitions: $transitions, music: $music)';
  }
}

/// @nodoc
abstract mixin class _$TemplateStructureCopyWith<$Res>
    implements $TemplateStructureCopyWith<$Res> {
  factory _$TemplateStructureCopyWith(
          _TemplateStructure value, $Res Function(_TemplateStructure) _then) =
      __$TemplateStructureCopyWithImpl;
  @override
  @useResult
  $Res call(
      {int duration,
      List<String> hooks,
      List<String> segments,
      List<String> transitions,
      List<String> music});
}

/// @nodoc
class __$TemplateStructureCopyWithImpl<$Res>
    implements _$TemplateStructureCopyWith<$Res> {
  __$TemplateStructureCopyWithImpl(this._self, this._then);

  final _TemplateStructure _self;
  final $Res Function(_TemplateStructure) _then;

  /// Create a copy of TemplateStructure
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? duration = null,
    Object? hooks = null,
    Object? segments = null,
    Object? transitions = null,
    Object? music = null,
  }) {
    return _then(_TemplateStructure(
      duration: null == duration
          ? _self.duration
          : duration // ignore: cast_nullable_to_non_nullable
              as int,
      hooks: null == hooks
          ? _self._hooks
          : hooks // ignore: cast_nullable_to_non_nullable
              as List<String>,
      segments: null == segments
          ? _self._segments
          : segments // ignore: cast_nullable_to_non_nullable
              as List<String>,
      transitions: null == transitions
          ? _self._transitions
          : transitions // ignore: cast_nullable_to_non_nullable
              as List<String>,
      music: null == music
          ? _self._music
          : music // ignore: cast_nullable_to_non_nullable
              as List<String>,
    ));
  }
}

// dart format on
