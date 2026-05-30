// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'thumbnail.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$Thumbnail {
  String get id;
  @JsonKey(name: 'project_id')
  String get projectId;
  @JsonKey(name: 'image_url')
  String get imageUrl;
  @JsonKey(name: 'is_variant_a')
  bool get isVariantA;
  @JsonKey(name: 'variant_b_image_url')
  String? get variantBImageUrl;
  @JsonKey(name: 'ctr_prediction')
  double get ctrPrediction;
  @JsonKey(name: 'selected_variant')
  ThumbnailVariant get selectedVariant;

  /// Create a copy of Thumbnail
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $ThumbnailCopyWith<Thumbnail> get copyWith =>
      _$ThumbnailCopyWithImpl<Thumbnail>(this as Thumbnail, _$identity);

  /// Serializes this Thumbnail to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is Thumbnail &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.projectId, projectId) ||
                other.projectId == projectId) &&
            (identical(other.imageUrl, imageUrl) ||
                other.imageUrl == imageUrl) &&
            (identical(other.isVariantA, isVariantA) ||
                other.isVariantA == isVariantA) &&
            (identical(other.variantBImageUrl, variantBImageUrl) ||
                other.variantBImageUrl == variantBImageUrl) &&
            (identical(other.ctrPrediction, ctrPrediction) ||
                other.ctrPrediction == ctrPrediction) &&
            (identical(other.selectedVariant, selectedVariant) ||
                other.selectedVariant == selectedVariant));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, projectId, imageUrl,
      isVariantA, variantBImageUrl, ctrPrediction, selectedVariant);

  @override
  String toString() {
    return 'Thumbnail(id: $id, projectId: $projectId, imageUrl: $imageUrl, isVariantA: $isVariantA, variantBImageUrl: $variantBImageUrl, ctrPrediction: $ctrPrediction, selectedVariant: $selectedVariant)';
  }
}

/// @nodoc
abstract mixin class $ThumbnailCopyWith<$Res> {
  factory $ThumbnailCopyWith(Thumbnail value, $Res Function(Thumbnail) _then) =
      _$ThumbnailCopyWithImpl;
  @useResult
  $Res call(
      {String id,
      @JsonKey(name: 'project_id') String projectId,
      @JsonKey(name: 'image_url') String imageUrl,
      @JsonKey(name: 'is_variant_a') bool isVariantA,
      @JsonKey(name: 'variant_b_image_url') String? variantBImageUrl,
      @JsonKey(name: 'ctr_prediction') double ctrPrediction,
      @JsonKey(name: 'selected_variant') ThumbnailVariant selectedVariant});
}

/// @nodoc
class _$ThumbnailCopyWithImpl<$Res> implements $ThumbnailCopyWith<$Res> {
  _$ThumbnailCopyWithImpl(this._self, this._then);

  final Thumbnail _self;
  final $Res Function(Thumbnail) _then;

  /// Create a copy of Thumbnail
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? projectId = null,
    Object? imageUrl = null,
    Object? isVariantA = null,
    Object? variantBImageUrl = freezed,
    Object? ctrPrediction = null,
    Object? selectedVariant = null,
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
      imageUrl: null == imageUrl
          ? _self.imageUrl
          : imageUrl // ignore: cast_nullable_to_non_nullable
              as String,
      isVariantA: null == isVariantA
          ? _self.isVariantA
          : isVariantA // ignore: cast_nullable_to_non_nullable
              as bool,
      variantBImageUrl: freezed == variantBImageUrl
          ? _self.variantBImageUrl
          : variantBImageUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      ctrPrediction: null == ctrPrediction
          ? _self.ctrPrediction
          : ctrPrediction // ignore: cast_nullable_to_non_nullable
              as double,
      selectedVariant: null == selectedVariant
          ? _self.selectedVariant
          : selectedVariant // ignore: cast_nullable_to_non_nullable
              as ThumbnailVariant,
    ));
  }
}

/// Adds pattern-matching-related methods to [Thumbnail].
extension ThumbnailPatterns on Thumbnail {
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
    TResult Function(_Thumbnail value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _Thumbnail() when $default != null:
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
    TResult Function(_Thumbnail value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _Thumbnail():
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
    TResult? Function(_Thumbnail value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _Thumbnail() when $default != null:
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
            @JsonKey(name: 'image_url') String imageUrl,
            @JsonKey(name: 'is_variant_a') bool isVariantA,
            @JsonKey(name: 'variant_b_image_url') String? variantBImageUrl,
            @JsonKey(name: 'ctr_prediction') double ctrPrediction,
            @JsonKey(name: 'selected_variant')
            ThumbnailVariant selectedVariant)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _Thumbnail() when $default != null:
        return $default(
            _that.id,
            _that.projectId,
            _that.imageUrl,
            _that.isVariantA,
            _that.variantBImageUrl,
            _that.ctrPrediction,
            _that.selectedVariant);
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
            @JsonKey(name: 'image_url') String imageUrl,
            @JsonKey(name: 'is_variant_a') bool isVariantA,
            @JsonKey(name: 'variant_b_image_url') String? variantBImageUrl,
            @JsonKey(name: 'ctr_prediction') double ctrPrediction,
            @JsonKey(name: 'selected_variant') ThumbnailVariant selectedVariant)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _Thumbnail():
        return $default(
            _that.id,
            _that.projectId,
            _that.imageUrl,
            _that.isVariantA,
            _that.variantBImageUrl,
            _that.ctrPrediction,
            _that.selectedVariant);
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
            @JsonKey(name: 'image_url') String imageUrl,
            @JsonKey(name: 'is_variant_a') bool isVariantA,
            @JsonKey(name: 'variant_b_image_url') String? variantBImageUrl,
            @JsonKey(name: 'ctr_prediction') double ctrPrediction,
            @JsonKey(name: 'selected_variant')
            ThumbnailVariant selectedVariant)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _Thumbnail() when $default != null:
        return $default(
            _that.id,
            _that.projectId,
            _that.imageUrl,
            _that.isVariantA,
            _that.variantBImageUrl,
            _that.ctrPrediction,
            _that.selectedVariant);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _Thumbnail implements Thumbnail {
  const _Thumbnail(
      {required this.id,
      @JsonKey(name: 'project_id') required this.projectId,
      @JsonKey(name: 'image_url') this.imageUrl = '',
      @JsonKey(name: 'is_variant_a') this.isVariantA = true,
      @JsonKey(name: 'variant_b_image_url') this.variantBImageUrl,
      @JsonKey(name: 'ctr_prediction') this.ctrPrediction = 0,
      @JsonKey(name: 'selected_variant')
      this.selectedVariant = ThumbnailVariant.a});
  factory _Thumbnail.fromJson(Map<String, dynamic> json) =>
      _$ThumbnailFromJson(json);

  @override
  final String id;
  @override
  @JsonKey(name: 'project_id')
  final String projectId;
  @override
  @JsonKey(name: 'image_url')
  final String imageUrl;
  @override
  @JsonKey(name: 'is_variant_a')
  final bool isVariantA;
  @override
  @JsonKey(name: 'variant_b_image_url')
  final String? variantBImageUrl;
  @override
  @JsonKey(name: 'ctr_prediction')
  final double ctrPrediction;
  @override
  @JsonKey(name: 'selected_variant')
  final ThumbnailVariant selectedVariant;

  /// Create a copy of Thumbnail
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$ThumbnailCopyWith<_Thumbnail> get copyWith =>
      __$ThumbnailCopyWithImpl<_Thumbnail>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$ThumbnailToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _Thumbnail &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.projectId, projectId) ||
                other.projectId == projectId) &&
            (identical(other.imageUrl, imageUrl) ||
                other.imageUrl == imageUrl) &&
            (identical(other.isVariantA, isVariantA) ||
                other.isVariantA == isVariantA) &&
            (identical(other.variantBImageUrl, variantBImageUrl) ||
                other.variantBImageUrl == variantBImageUrl) &&
            (identical(other.ctrPrediction, ctrPrediction) ||
                other.ctrPrediction == ctrPrediction) &&
            (identical(other.selectedVariant, selectedVariant) ||
                other.selectedVariant == selectedVariant));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, projectId, imageUrl,
      isVariantA, variantBImageUrl, ctrPrediction, selectedVariant);

  @override
  String toString() {
    return 'Thumbnail(id: $id, projectId: $projectId, imageUrl: $imageUrl, isVariantA: $isVariantA, variantBImageUrl: $variantBImageUrl, ctrPrediction: $ctrPrediction, selectedVariant: $selectedVariant)';
  }
}

/// @nodoc
abstract mixin class _$ThumbnailCopyWith<$Res>
    implements $ThumbnailCopyWith<$Res> {
  factory _$ThumbnailCopyWith(
          _Thumbnail value, $Res Function(_Thumbnail) _then) =
      __$ThumbnailCopyWithImpl;
  @override
  @useResult
  $Res call(
      {String id,
      @JsonKey(name: 'project_id') String projectId,
      @JsonKey(name: 'image_url') String imageUrl,
      @JsonKey(name: 'is_variant_a') bool isVariantA,
      @JsonKey(name: 'variant_b_image_url') String? variantBImageUrl,
      @JsonKey(name: 'ctr_prediction') double ctrPrediction,
      @JsonKey(name: 'selected_variant') ThumbnailVariant selectedVariant});
}

/// @nodoc
class __$ThumbnailCopyWithImpl<$Res> implements _$ThumbnailCopyWith<$Res> {
  __$ThumbnailCopyWithImpl(this._self, this._then);

  final _Thumbnail _self;
  final $Res Function(_Thumbnail) _then;

  /// Create a copy of Thumbnail
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? id = null,
    Object? projectId = null,
    Object? imageUrl = null,
    Object? isVariantA = null,
    Object? variantBImageUrl = freezed,
    Object? ctrPrediction = null,
    Object? selectedVariant = null,
  }) {
    return _then(_Thumbnail(
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      projectId: null == projectId
          ? _self.projectId
          : projectId // ignore: cast_nullable_to_non_nullable
              as String,
      imageUrl: null == imageUrl
          ? _self.imageUrl
          : imageUrl // ignore: cast_nullable_to_non_nullable
              as String,
      isVariantA: null == isVariantA
          ? _self.isVariantA
          : isVariantA // ignore: cast_nullable_to_non_nullable
              as bool,
      variantBImageUrl: freezed == variantBImageUrl
          ? _self.variantBImageUrl
          : variantBImageUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      ctrPrediction: null == ctrPrediction
          ? _self.ctrPrediction
          : ctrPrediction // ignore: cast_nullable_to_non_nullable
              as double,
      selectedVariant: null == selectedVariant
          ? _self.selectedVariant
          : selectedVariant // ignore: cast_nullable_to_non_nullable
              as ThumbnailVariant,
    ));
  }
}

// dart format on
