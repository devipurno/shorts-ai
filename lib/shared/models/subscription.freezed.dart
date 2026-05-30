// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'subscription.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$Subscription {
  String get id;
  @JsonKey(name: 'user_id')
  String get userId;
  SubscriptionTier get tier;
  SubscriptionStatus get status;
  @JsonKey(name: 'started_at')
  DateTime get startedAt;
  @JsonKey(name: 'expires_at')
  DateTime? get expiresAt;
  @JsonKey(name: 'cancelled_at')
  DateTime? get cancelledAt;
  @JsonKey(name: 'payment_method')
  String? get paymentMethod;
  @JsonKey(name: 'auto_renew')
  bool get autoRenew;
  SubscriptionSource get source;

  /// Create a copy of Subscription
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $SubscriptionCopyWith<Subscription> get copyWith =>
      _$SubscriptionCopyWithImpl<Subscription>(
          this as Subscription, _$identity);

  /// Serializes this Subscription to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is Subscription &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.tier, tier) || other.tier == tier) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.startedAt, startedAt) ||
                other.startedAt == startedAt) &&
            (identical(other.expiresAt, expiresAt) ||
                other.expiresAt == expiresAt) &&
            (identical(other.cancelledAt, cancelledAt) ||
                other.cancelledAt == cancelledAt) &&
            (identical(other.paymentMethod, paymentMethod) ||
                other.paymentMethod == paymentMethod) &&
            (identical(other.autoRenew, autoRenew) ||
                other.autoRenew == autoRenew) &&
            (identical(other.source, source) || other.source == source));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, userId, tier, status,
      startedAt, expiresAt, cancelledAt, paymentMethod, autoRenew, source);

  @override
  String toString() {
    return 'Subscription(id: $id, userId: $userId, tier: $tier, status: $status, startedAt: $startedAt, expiresAt: $expiresAt, cancelledAt: $cancelledAt, paymentMethod: $paymentMethod, autoRenew: $autoRenew, source: $source)';
  }
}

/// @nodoc
abstract mixin class $SubscriptionCopyWith<$Res> {
  factory $SubscriptionCopyWith(
          Subscription value, $Res Function(Subscription) _then) =
      _$SubscriptionCopyWithImpl;
  @useResult
  $Res call(
      {String id,
      @JsonKey(name: 'user_id') String userId,
      SubscriptionTier tier,
      SubscriptionStatus status,
      @JsonKey(name: 'started_at') DateTime startedAt,
      @JsonKey(name: 'expires_at') DateTime? expiresAt,
      @JsonKey(name: 'cancelled_at') DateTime? cancelledAt,
      @JsonKey(name: 'payment_method') String? paymentMethod,
      @JsonKey(name: 'auto_renew') bool autoRenew,
      SubscriptionSource source});
}

/// @nodoc
class _$SubscriptionCopyWithImpl<$Res> implements $SubscriptionCopyWith<$Res> {
  _$SubscriptionCopyWithImpl(this._self, this._then);

  final Subscription _self;
  final $Res Function(Subscription) _then;

  /// Create a copy of Subscription
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? userId = null,
    Object? tier = null,
    Object? status = null,
    Object? startedAt = null,
    Object? expiresAt = freezed,
    Object? cancelledAt = freezed,
    Object? paymentMethod = freezed,
    Object? autoRenew = null,
    Object? source = null,
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
      tier: null == tier
          ? _self.tier
          : tier // ignore: cast_nullable_to_non_nullable
              as SubscriptionTier,
      status: null == status
          ? _self.status
          : status // ignore: cast_nullable_to_non_nullable
              as SubscriptionStatus,
      startedAt: null == startedAt
          ? _self.startedAt
          : startedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      expiresAt: freezed == expiresAt
          ? _self.expiresAt
          : expiresAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      cancelledAt: freezed == cancelledAt
          ? _self.cancelledAt
          : cancelledAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      paymentMethod: freezed == paymentMethod
          ? _self.paymentMethod
          : paymentMethod // ignore: cast_nullable_to_non_nullable
              as String?,
      autoRenew: null == autoRenew
          ? _self.autoRenew
          : autoRenew // ignore: cast_nullable_to_non_nullable
              as bool,
      source: null == source
          ? _self.source
          : source // ignore: cast_nullable_to_non_nullable
              as SubscriptionSource,
    ));
  }
}

/// Adds pattern-matching-related methods to [Subscription].
extension SubscriptionPatterns on Subscription {
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
    TResult Function(_Subscription value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _Subscription() when $default != null:
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
    TResult Function(_Subscription value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _Subscription():
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
    TResult? Function(_Subscription value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _Subscription() when $default != null:
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
            SubscriptionTier tier,
            SubscriptionStatus status,
            @JsonKey(name: 'started_at') DateTime startedAt,
            @JsonKey(name: 'expires_at') DateTime? expiresAt,
            @JsonKey(name: 'cancelled_at') DateTime? cancelledAt,
            @JsonKey(name: 'payment_method') String? paymentMethod,
            @JsonKey(name: 'auto_renew') bool autoRenew,
            SubscriptionSource source)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _Subscription() when $default != null:
        return $default(
            _that.id,
            _that.userId,
            _that.tier,
            _that.status,
            _that.startedAt,
            _that.expiresAt,
            _that.cancelledAt,
            _that.paymentMethod,
            _that.autoRenew,
            _that.source);
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
            SubscriptionTier tier,
            SubscriptionStatus status,
            @JsonKey(name: 'started_at') DateTime startedAt,
            @JsonKey(name: 'expires_at') DateTime? expiresAt,
            @JsonKey(name: 'cancelled_at') DateTime? cancelledAt,
            @JsonKey(name: 'payment_method') String? paymentMethod,
            @JsonKey(name: 'auto_renew') bool autoRenew,
            SubscriptionSource source)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _Subscription():
        return $default(
            _that.id,
            _that.userId,
            _that.tier,
            _that.status,
            _that.startedAt,
            _that.expiresAt,
            _that.cancelledAt,
            _that.paymentMethod,
            _that.autoRenew,
            _that.source);
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
            SubscriptionTier tier,
            SubscriptionStatus status,
            @JsonKey(name: 'started_at') DateTime startedAt,
            @JsonKey(name: 'expires_at') DateTime? expiresAt,
            @JsonKey(name: 'cancelled_at') DateTime? cancelledAt,
            @JsonKey(name: 'payment_method') String? paymentMethod,
            @JsonKey(name: 'auto_renew') bool autoRenew,
            SubscriptionSource source)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _Subscription() when $default != null:
        return $default(
            _that.id,
            _that.userId,
            _that.tier,
            _that.status,
            _that.startedAt,
            _that.expiresAt,
            _that.cancelledAt,
            _that.paymentMethod,
            _that.autoRenew,
            _that.source);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _Subscription implements Subscription {
  const _Subscription(
      {required this.id,
      @JsonKey(name: 'user_id') required this.userId,
      this.tier = SubscriptionTier.free,
      this.status = SubscriptionStatus.active,
      @JsonKey(name: 'started_at') required this.startedAt,
      @JsonKey(name: 'expires_at') this.expiresAt,
      @JsonKey(name: 'cancelled_at') this.cancelledAt,
      @JsonKey(name: 'payment_method') this.paymentMethod,
      @JsonKey(name: 'auto_renew') this.autoRenew = false,
      this.source = SubscriptionSource.trial});
  factory _Subscription.fromJson(Map<String, dynamic> json) =>
      _$SubscriptionFromJson(json);

  @override
  final String id;
  @override
  @JsonKey(name: 'user_id')
  final String userId;
  @override
  @JsonKey()
  final SubscriptionTier tier;
  @override
  @JsonKey()
  final SubscriptionStatus status;
  @override
  @JsonKey(name: 'started_at')
  final DateTime startedAt;
  @override
  @JsonKey(name: 'expires_at')
  final DateTime? expiresAt;
  @override
  @JsonKey(name: 'cancelled_at')
  final DateTime? cancelledAt;
  @override
  @JsonKey(name: 'payment_method')
  final String? paymentMethod;
  @override
  @JsonKey(name: 'auto_renew')
  final bool autoRenew;
  @override
  @JsonKey()
  final SubscriptionSource source;

  /// Create a copy of Subscription
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$SubscriptionCopyWith<_Subscription> get copyWith =>
      __$SubscriptionCopyWithImpl<_Subscription>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$SubscriptionToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _Subscription &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.tier, tier) || other.tier == tier) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.startedAt, startedAt) ||
                other.startedAt == startedAt) &&
            (identical(other.expiresAt, expiresAt) ||
                other.expiresAt == expiresAt) &&
            (identical(other.cancelledAt, cancelledAt) ||
                other.cancelledAt == cancelledAt) &&
            (identical(other.paymentMethod, paymentMethod) ||
                other.paymentMethod == paymentMethod) &&
            (identical(other.autoRenew, autoRenew) ||
                other.autoRenew == autoRenew) &&
            (identical(other.source, source) || other.source == source));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, userId, tier, status,
      startedAt, expiresAt, cancelledAt, paymentMethod, autoRenew, source);

  @override
  String toString() {
    return 'Subscription(id: $id, userId: $userId, tier: $tier, status: $status, startedAt: $startedAt, expiresAt: $expiresAt, cancelledAt: $cancelledAt, paymentMethod: $paymentMethod, autoRenew: $autoRenew, source: $source)';
  }
}

/// @nodoc
abstract mixin class _$SubscriptionCopyWith<$Res>
    implements $SubscriptionCopyWith<$Res> {
  factory _$SubscriptionCopyWith(
          _Subscription value, $Res Function(_Subscription) _then) =
      __$SubscriptionCopyWithImpl;
  @override
  @useResult
  $Res call(
      {String id,
      @JsonKey(name: 'user_id') String userId,
      SubscriptionTier tier,
      SubscriptionStatus status,
      @JsonKey(name: 'started_at') DateTime startedAt,
      @JsonKey(name: 'expires_at') DateTime? expiresAt,
      @JsonKey(name: 'cancelled_at') DateTime? cancelledAt,
      @JsonKey(name: 'payment_method') String? paymentMethod,
      @JsonKey(name: 'auto_renew') bool autoRenew,
      SubscriptionSource source});
}

/// @nodoc
class __$SubscriptionCopyWithImpl<$Res>
    implements _$SubscriptionCopyWith<$Res> {
  __$SubscriptionCopyWithImpl(this._self, this._then);

  final _Subscription _self;
  final $Res Function(_Subscription) _then;

  /// Create a copy of Subscription
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? id = null,
    Object? userId = null,
    Object? tier = null,
    Object? status = null,
    Object? startedAt = null,
    Object? expiresAt = freezed,
    Object? cancelledAt = freezed,
    Object? paymentMethod = freezed,
    Object? autoRenew = null,
    Object? source = null,
  }) {
    return _then(_Subscription(
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      userId: null == userId
          ? _self.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
      tier: null == tier
          ? _self.tier
          : tier // ignore: cast_nullable_to_non_nullable
              as SubscriptionTier,
      status: null == status
          ? _self.status
          : status // ignore: cast_nullable_to_non_nullable
              as SubscriptionStatus,
      startedAt: null == startedAt
          ? _self.startedAt
          : startedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      expiresAt: freezed == expiresAt
          ? _self.expiresAt
          : expiresAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      cancelledAt: freezed == cancelledAt
          ? _self.cancelledAt
          : cancelledAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      paymentMethod: freezed == paymentMethod
          ? _self.paymentMethod
          : paymentMethod // ignore: cast_nullable_to_non_nullable
              as String?,
      autoRenew: null == autoRenew
          ? _self.autoRenew
          : autoRenew // ignore: cast_nullable_to_non_nullable
              as bool,
      source: null == source
          ? _self.source
          : source // ignore: cast_nullable_to_non_nullable
              as SubscriptionSource,
    ));
  }
}

// dart format on
