// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'profile.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$CreatorProfile {
  @JsonKey(name: 'user_id')
  String get userId;
  @JsonKey(name: 'display_name')
  String get displayName;
  String get bio;
  @JsonKey(name: 'instagram_handle')
  String? get instagramHandle;
  @JsonKey(name: 'youtube_handle')
  String? get youtubeHandle;
  @JsonKey(name: 'tiktok_handle')
  String? get tiktokHandle;
  CreatorNiche get niche;
  @JsonKey(name: 'target_audience')
  String get targetAudience;
  @JsonKey(name: 'content_language')
  String get contentLanguage;
  @JsonKey(name: 'brand_kit_id')
  String? get brandKitId;

  /// Create a copy of CreatorProfile
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $CreatorProfileCopyWith<CreatorProfile> get copyWith =>
      _$CreatorProfileCopyWithImpl<CreatorProfile>(
          this as CreatorProfile, _$identity);

  /// Serializes this CreatorProfile to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is CreatorProfile &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.displayName, displayName) ||
                other.displayName == displayName) &&
            (identical(other.bio, bio) || other.bio == bio) &&
            (identical(other.instagramHandle, instagramHandle) ||
                other.instagramHandle == instagramHandle) &&
            (identical(other.youtubeHandle, youtubeHandle) ||
                other.youtubeHandle == youtubeHandle) &&
            (identical(other.tiktokHandle, tiktokHandle) ||
                other.tiktokHandle == tiktokHandle) &&
            (identical(other.niche, niche) || other.niche == niche) &&
            (identical(other.targetAudience, targetAudience) ||
                other.targetAudience == targetAudience) &&
            (identical(other.contentLanguage, contentLanguage) ||
                other.contentLanguage == contentLanguage) &&
            (identical(other.brandKitId, brandKitId) ||
                other.brandKitId == brandKitId));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      userId,
      displayName,
      bio,
      instagramHandle,
      youtubeHandle,
      tiktokHandle,
      niche,
      targetAudience,
      contentLanguage,
      brandKitId);

  @override
  String toString() {
    return 'CreatorProfile(userId: $userId, displayName: $displayName, bio: $bio, instagramHandle: $instagramHandle, youtubeHandle: $youtubeHandle, tiktokHandle: $tiktokHandle, niche: $niche, targetAudience: $targetAudience, contentLanguage: $contentLanguage, brandKitId: $brandKitId)';
  }
}

/// @nodoc
abstract mixin class $CreatorProfileCopyWith<$Res> {
  factory $CreatorProfileCopyWith(
          CreatorProfile value, $Res Function(CreatorProfile) _then) =
      _$CreatorProfileCopyWithImpl;
  @useResult
  $Res call(
      {@JsonKey(name: 'user_id') String userId,
      @JsonKey(name: 'display_name') String displayName,
      String bio,
      @JsonKey(name: 'instagram_handle') String? instagramHandle,
      @JsonKey(name: 'youtube_handle') String? youtubeHandle,
      @JsonKey(name: 'tiktok_handle') String? tiktokHandle,
      CreatorNiche niche,
      @JsonKey(name: 'target_audience') String targetAudience,
      @JsonKey(name: 'content_language') String contentLanguage,
      @JsonKey(name: 'brand_kit_id') String? brandKitId});
}

/// @nodoc
class _$CreatorProfileCopyWithImpl<$Res>
    implements $CreatorProfileCopyWith<$Res> {
  _$CreatorProfileCopyWithImpl(this._self, this._then);

  final CreatorProfile _self;
  final $Res Function(CreatorProfile) _then;

  /// Create a copy of CreatorProfile
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? userId = null,
    Object? displayName = null,
    Object? bio = null,
    Object? instagramHandle = freezed,
    Object? youtubeHandle = freezed,
    Object? tiktokHandle = freezed,
    Object? niche = null,
    Object? targetAudience = null,
    Object? contentLanguage = null,
    Object? brandKitId = freezed,
  }) {
    return _then(_self.copyWith(
      userId: null == userId
          ? _self.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
      displayName: null == displayName
          ? _self.displayName
          : displayName // ignore: cast_nullable_to_non_nullable
              as String,
      bio: null == bio
          ? _self.bio
          : bio // ignore: cast_nullable_to_non_nullable
              as String,
      instagramHandle: freezed == instagramHandle
          ? _self.instagramHandle
          : instagramHandle // ignore: cast_nullable_to_non_nullable
              as String?,
      youtubeHandle: freezed == youtubeHandle
          ? _self.youtubeHandle
          : youtubeHandle // ignore: cast_nullable_to_non_nullable
              as String?,
      tiktokHandle: freezed == tiktokHandle
          ? _self.tiktokHandle
          : tiktokHandle // ignore: cast_nullable_to_non_nullable
              as String?,
      niche: null == niche
          ? _self.niche
          : niche // ignore: cast_nullable_to_non_nullable
              as CreatorNiche,
      targetAudience: null == targetAudience
          ? _self.targetAudience
          : targetAudience // ignore: cast_nullable_to_non_nullable
              as String,
      contentLanguage: null == contentLanguage
          ? _self.contentLanguage
          : contentLanguage // ignore: cast_nullable_to_non_nullable
              as String,
      brandKitId: freezed == brandKitId
          ? _self.brandKitId
          : brandKitId // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// Adds pattern-matching-related methods to [CreatorProfile].
extension CreatorProfilePatterns on CreatorProfile {
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
    TResult Function(_CreatorProfile value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _CreatorProfile() when $default != null:
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
    TResult Function(_CreatorProfile value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _CreatorProfile():
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
    TResult? Function(_CreatorProfile value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _CreatorProfile() when $default != null:
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
            @JsonKey(name: 'user_id') String userId,
            @JsonKey(name: 'display_name') String displayName,
            String bio,
            @JsonKey(name: 'instagram_handle') String? instagramHandle,
            @JsonKey(name: 'youtube_handle') String? youtubeHandle,
            @JsonKey(name: 'tiktok_handle') String? tiktokHandle,
            CreatorNiche niche,
            @JsonKey(name: 'target_audience') String targetAudience,
            @JsonKey(name: 'content_language') String contentLanguage,
            @JsonKey(name: 'brand_kit_id') String? brandKitId)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _CreatorProfile() when $default != null:
        return $default(
            _that.userId,
            _that.displayName,
            _that.bio,
            _that.instagramHandle,
            _that.youtubeHandle,
            _that.tiktokHandle,
            _that.niche,
            _that.targetAudience,
            _that.contentLanguage,
            _that.brandKitId);
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
            @JsonKey(name: 'user_id') String userId,
            @JsonKey(name: 'display_name') String displayName,
            String bio,
            @JsonKey(name: 'instagram_handle') String? instagramHandle,
            @JsonKey(name: 'youtube_handle') String? youtubeHandle,
            @JsonKey(name: 'tiktok_handle') String? tiktokHandle,
            CreatorNiche niche,
            @JsonKey(name: 'target_audience') String targetAudience,
            @JsonKey(name: 'content_language') String contentLanguage,
            @JsonKey(name: 'brand_kit_id') String? brandKitId)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _CreatorProfile():
        return $default(
            _that.userId,
            _that.displayName,
            _that.bio,
            _that.instagramHandle,
            _that.youtubeHandle,
            _that.tiktokHandle,
            _that.niche,
            _that.targetAudience,
            _that.contentLanguage,
            _that.brandKitId);
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
            @JsonKey(name: 'user_id') String userId,
            @JsonKey(name: 'display_name') String displayName,
            String bio,
            @JsonKey(name: 'instagram_handle') String? instagramHandle,
            @JsonKey(name: 'youtube_handle') String? youtubeHandle,
            @JsonKey(name: 'tiktok_handle') String? tiktokHandle,
            CreatorNiche niche,
            @JsonKey(name: 'target_audience') String targetAudience,
            @JsonKey(name: 'content_language') String contentLanguage,
            @JsonKey(name: 'brand_kit_id') String? brandKitId)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _CreatorProfile() when $default != null:
        return $default(
            _that.userId,
            _that.displayName,
            _that.bio,
            _that.instagramHandle,
            _that.youtubeHandle,
            _that.tiktokHandle,
            _that.niche,
            _that.targetAudience,
            _that.contentLanguage,
            _that.brandKitId);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _CreatorProfile implements CreatorProfile {
  const _CreatorProfile(
      {@JsonKey(name: 'user_id') required this.userId,
      @JsonKey(name: 'display_name') this.displayName = '',
      this.bio = '',
      @JsonKey(name: 'instagram_handle') this.instagramHandle,
      @JsonKey(name: 'youtube_handle') this.youtubeHandle,
      @JsonKey(name: 'tiktok_handle') this.tiktokHandle,
      this.niche = CreatorNiche.other,
      @JsonKey(name: 'target_audience') this.targetAudience = '',
      @JsonKey(name: 'content_language') this.contentLanguage = 'id',
      @JsonKey(name: 'brand_kit_id') this.brandKitId});
  factory _CreatorProfile.fromJson(Map<String, dynamic> json) =>
      _$CreatorProfileFromJson(json);

  @override
  @JsonKey(name: 'user_id')
  final String userId;
  @override
  @JsonKey(name: 'display_name')
  final String displayName;
  @override
  @JsonKey()
  final String bio;
  @override
  @JsonKey(name: 'instagram_handle')
  final String? instagramHandle;
  @override
  @JsonKey(name: 'youtube_handle')
  final String? youtubeHandle;
  @override
  @JsonKey(name: 'tiktok_handle')
  final String? tiktokHandle;
  @override
  @JsonKey()
  final CreatorNiche niche;
  @override
  @JsonKey(name: 'target_audience')
  final String targetAudience;
  @override
  @JsonKey(name: 'content_language')
  final String contentLanguage;
  @override
  @JsonKey(name: 'brand_kit_id')
  final String? brandKitId;

  /// Create a copy of CreatorProfile
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$CreatorProfileCopyWith<_CreatorProfile> get copyWith =>
      __$CreatorProfileCopyWithImpl<_CreatorProfile>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$CreatorProfileToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _CreatorProfile &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.displayName, displayName) ||
                other.displayName == displayName) &&
            (identical(other.bio, bio) || other.bio == bio) &&
            (identical(other.instagramHandle, instagramHandle) ||
                other.instagramHandle == instagramHandle) &&
            (identical(other.youtubeHandle, youtubeHandle) ||
                other.youtubeHandle == youtubeHandle) &&
            (identical(other.tiktokHandle, tiktokHandle) ||
                other.tiktokHandle == tiktokHandle) &&
            (identical(other.niche, niche) || other.niche == niche) &&
            (identical(other.targetAudience, targetAudience) ||
                other.targetAudience == targetAudience) &&
            (identical(other.contentLanguage, contentLanguage) ||
                other.contentLanguage == contentLanguage) &&
            (identical(other.brandKitId, brandKitId) ||
                other.brandKitId == brandKitId));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      userId,
      displayName,
      bio,
      instagramHandle,
      youtubeHandle,
      tiktokHandle,
      niche,
      targetAudience,
      contentLanguage,
      brandKitId);

  @override
  String toString() {
    return 'CreatorProfile(userId: $userId, displayName: $displayName, bio: $bio, instagramHandle: $instagramHandle, youtubeHandle: $youtubeHandle, tiktokHandle: $tiktokHandle, niche: $niche, targetAudience: $targetAudience, contentLanguage: $contentLanguage, brandKitId: $brandKitId)';
  }
}

/// @nodoc
abstract mixin class _$CreatorProfileCopyWith<$Res>
    implements $CreatorProfileCopyWith<$Res> {
  factory _$CreatorProfileCopyWith(
          _CreatorProfile value, $Res Function(_CreatorProfile) _then) =
      __$CreatorProfileCopyWithImpl;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: 'user_id') String userId,
      @JsonKey(name: 'display_name') String displayName,
      String bio,
      @JsonKey(name: 'instagram_handle') String? instagramHandle,
      @JsonKey(name: 'youtube_handle') String? youtubeHandle,
      @JsonKey(name: 'tiktok_handle') String? tiktokHandle,
      CreatorNiche niche,
      @JsonKey(name: 'target_audience') String targetAudience,
      @JsonKey(name: 'content_language') String contentLanguage,
      @JsonKey(name: 'brand_kit_id') String? brandKitId});
}

/// @nodoc
class __$CreatorProfileCopyWithImpl<$Res>
    implements _$CreatorProfileCopyWith<$Res> {
  __$CreatorProfileCopyWithImpl(this._self, this._then);

  final _CreatorProfile _self;
  final $Res Function(_CreatorProfile) _then;

  /// Create a copy of CreatorProfile
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? userId = null,
    Object? displayName = null,
    Object? bio = null,
    Object? instagramHandle = freezed,
    Object? youtubeHandle = freezed,
    Object? tiktokHandle = freezed,
    Object? niche = null,
    Object? targetAudience = null,
    Object? contentLanguage = null,
    Object? brandKitId = freezed,
  }) {
    return _then(_CreatorProfile(
      userId: null == userId
          ? _self.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
      displayName: null == displayName
          ? _self.displayName
          : displayName // ignore: cast_nullable_to_non_nullable
              as String,
      bio: null == bio
          ? _self.bio
          : bio // ignore: cast_nullable_to_non_nullable
              as String,
      instagramHandle: freezed == instagramHandle
          ? _self.instagramHandle
          : instagramHandle // ignore: cast_nullable_to_non_nullable
              as String?,
      youtubeHandle: freezed == youtubeHandle
          ? _self.youtubeHandle
          : youtubeHandle // ignore: cast_nullable_to_non_nullable
              as String?,
      tiktokHandle: freezed == tiktokHandle
          ? _self.tiktokHandle
          : tiktokHandle // ignore: cast_nullable_to_non_nullable
              as String?,
      niche: null == niche
          ? _self.niche
          : niche // ignore: cast_nullable_to_non_nullable
              as CreatorNiche,
      targetAudience: null == targetAudience
          ? _self.targetAudience
          : targetAudience // ignore: cast_nullable_to_non_nullable
              as String,
      contentLanguage: null == contentLanguage
          ? _self.contentLanguage
          : contentLanguage // ignore: cast_nullable_to_non_nullable
              as String,
      brandKitId: freezed == brandKitId
          ? _self.brandKitId
          : brandKitId // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

// dart format on
