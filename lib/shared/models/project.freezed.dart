// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'project.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$Project {
  String get id;
  @JsonKey(name: 'user_id')
  String get userId;
  String get title;
  String get description;
  ProjectStatus get status;
  @JsonKey(name: 'original_video_url')
  String? get originalVideoUrl;
  @JsonKey(name: 'processed_video_url')
  String? get processedVideoUrl;
  @JsonKey(name: 'thumbnail_url')
  String? get thumbnailUrl;
  int get duration;
  @JsonKey(name: 'aspect_ratio')
  String get aspectRatio;
  String get resolution;
  @JsonKey(name: 'template_id')
  String? get templateId;
  @JsonKey(name: 'brand_kit_id')
  String? get brandKitId;
  List<String> get tags;
  @JsonKey(name: 'created_at')
  DateTime get createdAt;
  @JsonKey(name: 'updated_at')
  DateTime get updatedAt;
  @JsonKey(name: 'published_at')
  DateTime? get publishedAt;

  /// Create a copy of Project
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $ProjectCopyWith<Project> get copyWith =>
      _$ProjectCopyWithImpl<Project>(this as Project, _$identity);

  /// Serializes this Project to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is Project &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.originalVideoUrl, originalVideoUrl) ||
                other.originalVideoUrl == originalVideoUrl) &&
            (identical(other.processedVideoUrl, processedVideoUrl) ||
                other.processedVideoUrl == processedVideoUrl) &&
            (identical(other.thumbnailUrl, thumbnailUrl) ||
                other.thumbnailUrl == thumbnailUrl) &&
            (identical(other.duration, duration) ||
                other.duration == duration) &&
            (identical(other.aspectRatio, aspectRatio) ||
                other.aspectRatio == aspectRatio) &&
            (identical(other.resolution, resolution) ||
                other.resolution == resolution) &&
            (identical(other.templateId, templateId) ||
                other.templateId == templateId) &&
            (identical(other.brandKitId, brandKitId) ||
                other.brandKitId == brandKitId) &&
            const DeepCollectionEquality().equals(other.tags, tags) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt) &&
            (identical(other.publishedAt, publishedAt) ||
                other.publishedAt == publishedAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      userId,
      title,
      description,
      status,
      originalVideoUrl,
      processedVideoUrl,
      thumbnailUrl,
      duration,
      aspectRatio,
      resolution,
      templateId,
      brandKitId,
      const DeepCollectionEquality().hash(tags),
      createdAt,
      updatedAt,
      publishedAt);

  @override
  String toString() {
    return 'Project(id: $id, userId: $userId, title: $title, description: $description, status: $status, originalVideoUrl: $originalVideoUrl, processedVideoUrl: $processedVideoUrl, thumbnailUrl: $thumbnailUrl, duration: $duration, aspectRatio: $aspectRatio, resolution: $resolution, templateId: $templateId, brandKitId: $brandKitId, tags: $tags, createdAt: $createdAt, updatedAt: $updatedAt, publishedAt: $publishedAt)';
  }
}

/// @nodoc
abstract mixin class $ProjectCopyWith<$Res> {
  factory $ProjectCopyWith(Project value, $Res Function(Project) _then) =
      _$ProjectCopyWithImpl;
  @useResult
  $Res call(
      {String id,
      @JsonKey(name: 'user_id') String userId,
      String title,
      String description,
      ProjectStatus status,
      @JsonKey(name: 'original_video_url') String? originalVideoUrl,
      @JsonKey(name: 'processed_video_url') String? processedVideoUrl,
      @JsonKey(name: 'thumbnail_url') String? thumbnailUrl,
      int duration,
      @JsonKey(name: 'aspect_ratio') String aspectRatio,
      String resolution,
      @JsonKey(name: 'template_id') String? templateId,
      @JsonKey(name: 'brand_kit_id') String? brandKitId,
      List<String> tags,
      @JsonKey(name: 'created_at') DateTime createdAt,
      @JsonKey(name: 'updated_at') DateTime updatedAt,
      @JsonKey(name: 'published_at') DateTime? publishedAt});
}

/// @nodoc
class _$ProjectCopyWithImpl<$Res> implements $ProjectCopyWith<$Res> {
  _$ProjectCopyWithImpl(this._self, this._then);

  final Project _self;
  final $Res Function(Project) _then;

  /// Create a copy of Project
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? userId = null,
    Object? title = null,
    Object? description = null,
    Object? status = null,
    Object? originalVideoUrl = freezed,
    Object? processedVideoUrl = freezed,
    Object? thumbnailUrl = freezed,
    Object? duration = null,
    Object? aspectRatio = null,
    Object? resolution = null,
    Object? templateId = freezed,
    Object? brandKitId = freezed,
    Object? tags = null,
    Object? createdAt = null,
    Object? updatedAt = null,
    Object? publishedAt = freezed,
  }) {
    return _then(_self.copyWith(
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      userId: null == userId
          ? _self.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
      title: null == title
          ? _self.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      description: null == description
          ? _self.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      status: null == status
          ? _self.status
          : status // ignore: cast_nullable_to_non_nullable
              as ProjectStatus,
      originalVideoUrl: freezed == originalVideoUrl
          ? _self.originalVideoUrl
          : originalVideoUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      processedVideoUrl: freezed == processedVideoUrl
          ? _self.processedVideoUrl
          : processedVideoUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      thumbnailUrl: freezed == thumbnailUrl
          ? _self.thumbnailUrl
          : thumbnailUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      duration: null == duration
          ? _self.duration
          : duration // ignore: cast_nullable_to_non_nullable
              as int,
      aspectRatio: null == aspectRatio
          ? _self.aspectRatio
          : aspectRatio // ignore: cast_nullable_to_non_nullable
              as String,
      resolution: null == resolution
          ? _self.resolution
          : resolution // ignore: cast_nullable_to_non_nullable
              as String,
      templateId: freezed == templateId
          ? _self.templateId
          : templateId // ignore: cast_nullable_to_non_nullable
              as String?,
      brandKitId: freezed == brandKitId
          ? _self.brandKitId
          : brandKitId // ignore: cast_nullable_to_non_nullable
              as String?,
      tags: null == tags
          ? _self.tags
          : tags // ignore: cast_nullable_to_non_nullable
              as List<String>,
      createdAt: null == createdAt
          ? _self.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      updatedAt: null == updatedAt
          ? _self.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      publishedAt: freezed == publishedAt
          ? _self.publishedAt
          : publishedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ));
  }
}

/// Adds pattern-matching-related methods to [Project].
extension ProjectPatterns on Project {
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
    TResult Function(_Project value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _Project() when $default != null:
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
    TResult Function(_Project value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _Project():
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
    TResult? Function(_Project value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _Project() when $default != null:
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
            @JsonKey(name: 'user_id') String userId,
            String title,
            String description,
            ProjectStatus status,
            @JsonKey(name: 'original_video_url') String? originalVideoUrl,
            @JsonKey(name: 'processed_video_url') String? processedVideoUrl,
            @JsonKey(name: 'thumbnail_url') String? thumbnailUrl,
            int duration,
            @JsonKey(name: 'aspect_ratio') String aspectRatio,
            String resolution,
            @JsonKey(name: 'template_id') String? templateId,
            @JsonKey(name: 'brand_kit_id') String? brandKitId,
            List<String> tags,
            @JsonKey(name: 'created_at') DateTime createdAt,
            @JsonKey(name: 'updated_at') DateTime updatedAt,
            @JsonKey(name: 'published_at') DateTime? publishedAt)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _Project() when $default != null:
        return $default(
            _that.id,
            _that.userId,
            _that.title,
            _that.description,
            _that.status,
            _that.originalVideoUrl,
            _that.processedVideoUrl,
            _that.thumbnailUrl,
            _that.duration,
            _that.aspectRatio,
            _that.resolution,
            _that.templateId,
            _that.brandKitId,
            _that.tags,
            _that.createdAt,
            _that.updatedAt,
            _that.publishedAt);
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
            @JsonKey(name: 'user_id') String userId,
            String title,
            String description,
            ProjectStatus status,
            @JsonKey(name: 'original_video_url') String? originalVideoUrl,
            @JsonKey(name: 'processed_video_url') String? processedVideoUrl,
            @JsonKey(name: 'thumbnail_url') String? thumbnailUrl,
            int duration,
            @JsonKey(name: 'aspect_ratio') String aspectRatio,
            String resolution,
            @JsonKey(name: 'template_id') String? templateId,
            @JsonKey(name: 'brand_kit_id') String? brandKitId,
            List<String> tags,
            @JsonKey(name: 'created_at') DateTime createdAt,
            @JsonKey(name: 'updated_at') DateTime updatedAt,
            @JsonKey(name: 'published_at') DateTime? publishedAt)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _Project():
        return $default(
            _that.id,
            _that.userId,
            _that.title,
            _that.description,
            _that.status,
            _that.originalVideoUrl,
            _that.processedVideoUrl,
            _that.thumbnailUrl,
            _that.duration,
            _that.aspectRatio,
            _that.resolution,
            _that.templateId,
            _that.brandKitId,
            _that.tags,
            _that.createdAt,
            _that.updatedAt,
            _that.publishedAt);
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
            @JsonKey(name: 'user_id') String userId,
            String title,
            String description,
            ProjectStatus status,
            @JsonKey(name: 'original_video_url') String? originalVideoUrl,
            @JsonKey(name: 'processed_video_url') String? processedVideoUrl,
            @JsonKey(name: 'thumbnail_url') String? thumbnailUrl,
            int duration,
            @JsonKey(name: 'aspect_ratio') String aspectRatio,
            String resolution,
            @JsonKey(name: 'template_id') String? templateId,
            @JsonKey(name: 'brand_kit_id') String? brandKitId,
            List<String> tags,
            @JsonKey(name: 'created_at') DateTime createdAt,
            @JsonKey(name: 'updated_at') DateTime updatedAt,
            @JsonKey(name: 'published_at') DateTime? publishedAt)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _Project() when $default != null:
        return $default(
            _that.id,
            _that.userId,
            _that.title,
            _that.description,
            _that.status,
            _that.originalVideoUrl,
            _that.processedVideoUrl,
            _that.thumbnailUrl,
            _that.duration,
            _that.aspectRatio,
            _that.resolution,
            _that.templateId,
            _that.brandKitId,
            _that.tags,
            _that.createdAt,
            _that.updatedAt,
            _that.publishedAt);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _Project implements Project {
  const _Project(
      {required this.id,
      @JsonKey(name: 'user_id') required this.userId,
      this.title = 'Untitled project',
      this.description = '',
      this.status = ProjectStatus.draft,
      @JsonKey(name: 'original_video_url') this.originalVideoUrl,
      @JsonKey(name: 'processed_video_url') this.processedVideoUrl,
      @JsonKey(name: 'thumbnail_url') this.thumbnailUrl,
      this.duration = 0,
      @JsonKey(name: 'aspect_ratio') this.aspectRatio = '9:16',
      this.resolution = '1080x1920',
      @JsonKey(name: 'template_id') this.templateId,
      @JsonKey(name: 'brand_kit_id') this.brandKitId,
      final List<String> tags = const <String>[],
      @JsonKey(name: 'created_at') required this.createdAt,
      @JsonKey(name: 'updated_at') required this.updatedAt,
      @JsonKey(name: 'published_at') this.publishedAt})
      : _tags = tags;
  factory _Project.fromJson(Map<String, dynamic> json) =>
      _$ProjectFromJson(json);

  @override
  final String id;
  @override
  @JsonKey(name: 'user_id')
  final String userId;
  @override
  @JsonKey()
  final String title;
  @override
  @JsonKey()
  final String description;
  @override
  @JsonKey()
  final ProjectStatus status;
  @override
  @JsonKey(name: 'original_video_url')
  final String? originalVideoUrl;
  @override
  @JsonKey(name: 'processed_video_url')
  final String? processedVideoUrl;
  @override
  @JsonKey(name: 'thumbnail_url')
  final String? thumbnailUrl;
  @override
  @JsonKey()
  final int duration;
  @override
  @JsonKey(name: 'aspect_ratio')
  final String aspectRatio;
  @override
  @JsonKey()
  final String resolution;
  @override
  @JsonKey(name: 'template_id')
  final String? templateId;
  @override
  @JsonKey(name: 'brand_kit_id')
  final String? brandKitId;
  final List<String> _tags;
  @override
  @JsonKey()
  List<String> get tags {
    if (_tags is EqualUnmodifiableListView) return _tags;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_tags);
  }

  @override
  @JsonKey(name: 'created_at')
  final DateTime createdAt;
  @override
  @JsonKey(name: 'updated_at')
  final DateTime updatedAt;
  @override
  @JsonKey(name: 'published_at')
  final DateTime? publishedAt;

  /// Create a copy of Project
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$ProjectCopyWith<_Project> get copyWith =>
      __$ProjectCopyWithImpl<_Project>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$ProjectToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _Project &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.originalVideoUrl, originalVideoUrl) ||
                other.originalVideoUrl == originalVideoUrl) &&
            (identical(other.processedVideoUrl, processedVideoUrl) ||
                other.processedVideoUrl == processedVideoUrl) &&
            (identical(other.thumbnailUrl, thumbnailUrl) ||
                other.thumbnailUrl == thumbnailUrl) &&
            (identical(other.duration, duration) ||
                other.duration == duration) &&
            (identical(other.aspectRatio, aspectRatio) ||
                other.aspectRatio == aspectRatio) &&
            (identical(other.resolution, resolution) ||
                other.resolution == resolution) &&
            (identical(other.templateId, templateId) ||
                other.templateId == templateId) &&
            (identical(other.brandKitId, brandKitId) ||
                other.brandKitId == brandKitId) &&
            const DeepCollectionEquality().equals(other._tags, _tags) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt) &&
            (identical(other.publishedAt, publishedAt) ||
                other.publishedAt == publishedAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      userId,
      title,
      description,
      status,
      originalVideoUrl,
      processedVideoUrl,
      thumbnailUrl,
      duration,
      aspectRatio,
      resolution,
      templateId,
      brandKitId,
      const DeepCollectionEquality().hash(_tags),
      createdAt,
      updatedAt,
      publishedAt);

  @override
  String toString() {
    return 'Project(id: $id, userId: $userId, title: $title, description: $description, status: $status, originalVideoUrl: $originalVideoUrl, processedVideoUrl: $processedVideoUrl, thumbnailUrl: $thumbnailUrl, duration: $duration, aspectRatio: $aspectRatio, resolution: $resolution, templateId: $templateId, brandKitId: $brandKitId, tags: $tags, createdAt: $createdAt, updatedAt: $updatedAt, publishedAt: $publishedAt)';
  }
}

/// @nodoc
abstract mixin class _$ProjectCopyWith<$Res> implements $ProjectCopyWith<$Res> {
  factory _$ProjectCopyWith(_Project value, $Res Function(_Project) _then) =
      __$ProjectCopyWithImpl;
  @override
  @useResult
  $Res call(
      {String id,
      @JsonKey(name: 'user_id') String userId,
      String title,
      String description,
      ProjectStatus status,
      @JsonKey(name: 'original_video_url') String? originalVideoUrl,
      @JsonKey(name: 'processed_video_url') String? processedVideoUrl,
      @JsonKey(name: 'thumbnail_url') String? thumbnailUrl,
      int duration,
      @JsonKey(name: 'aspect_ratio') String aspectRatio,
      String resolution,
      @JsonKey(name: 'template_id') String? templateId,
      @JsonKey(name: 'brand_kit_id') String? brandKitId,
      List<String> tags,
      @JsonKey(name: 'created_at') DateTime createdAt,
      @JsonKey(name: 'updated_at') DateTime updatedAt,
      @JsonKey(name: 'published_at') DateTime? publishedAt});
}

/// @nodoc
class __$ProjectCopyWithImpl<$Res> implements _$ProjectCopyWith<$Res> {
  __$ProjectCopyWithImpl(this._self, this._then);

  final _Project _self;
  final $Res Function(_Project) _then;

  /// Create a copy of Project
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? id = null,
    Object? userId = null,
    Object? title = null,
    Object? description = null,
    Object? status = null,
    Object? originalVideoUrl = freezed,
    Object? processedVideoUrl = freezed,
    Object? thumbnailUrl = freezed,
    Object? duration = null,
    Object? aspectRatio = null,
    Object? resolution = null,
    Object? templateId = freezed,
    Object? brandKitId = freezed,
    Object? tags = null,
    Object? createdAt = null,
    Object? updatedAt = null,
    Object? publishedAt = freezed,
  }) {
    return _then(_Project(
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      userId: null == userId
          ? _self.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
      title: null == title
          ? _self.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      description: null == description
          ? _self.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      status: null == status
          ? _self.status
          : status // ignore: cast_nullable_to_non_nullable
              as ProjectStatus,
      originalVideoUrl: freezed == originalVideoUrl
          ? _self.originalVideoUrl
          : originalVideoUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      processedVideoUrl: freezed == processedVideoUrl
          ? _self.processedVideoUrl
          : processedVideoUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      thumbnailUrl: freezed == thumbnailUrl
          ? _self.thumbnailUrl
          : thumbnailUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      duration: null == duration
          ? _self.duration
          : duration // ignore: cast_nullable_to_non_nullable
              as int,
      aspectRatio: null == aspectRatio
          ? _self.aspectRatio
          : aspectRatio // ignore: cast_nullable_to_non_nullable
              as String,
      resolution: null == resolution
          ? _self.resolution
          : resolution // ignore: cast_nullable_to_non_nullable
              as String,
      templateId: freezed == templateId
          ? _self.templateId
          : templateId // ignore: cast_nullable_to_non_nullable
              as String?,
      brandKitId: freezed == brandKitId
          ? _self.brandKitId
          : brandKitId // ignore: cast_nullable_to_non_nullable
              as String?,
      tags: null == tags
          ? _self._tags
          : tags // ignore: cast_nullable_to_non_nullable
              as List<String>,
      createdAt: null == createdAt
          ? _self.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      updatedAt: null == updatedAt
          ? _self.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      publishedAt: freezed == publishedAt
          ? _self.publishedAt
          : publishedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ));
  }
}

// dart format on
