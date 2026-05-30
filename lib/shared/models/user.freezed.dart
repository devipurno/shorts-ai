// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'user.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$User {
  String get id;
  String get email;
  String get name;
  @JsonKey(name: 'avatar_url')
  String? get avatarUrl;
  @JsonKey(name: 'phone_number')
  String? get phoneNumber;
  String get locale;
  String get timezone;
  SubscriptionTier get tier;
  @JsonKey(name: 'subscription_id')
  String? get subscriptionId;
  @JsonKey(name: 'subscription_expires_at')
  DateTime? get subscriptionExpiresAt;
  @JsonKey(name: 'trial_started_at')
  DateTime? get trialStartedAt;
  @JsonKey(name: 'trial_ends_at')
  DateTime? get trialEndsAt;
  @JsonKey(name: 'trial_days_remaining')
  int get trialDaysRemaining;
  @JsonKey(name: 'referral_code')
  String? get referralCode;
  @JsonKey(name: 'referred_by_user_id')
  String? get referredByUserId;
  @JsonKey(name: 'created_at')
  DateTime get createdAt;
  @JsonKey(name: 'updated_at')
  DateTime get updatedAt;
  @JsonKey(name: 'last_login_at')
  DateTime? get lastLoginAt;

  /// Create a copy of User
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $UserCopyWith<User> get copyWith =>
      _$UserCopyWithImpl<User>(this as User, _$identity);

  /// Serializes this User to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is User &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.email, email) || other.email == email) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.avatarUrl, avatarUrl) ||
                other.avatarUrl == avatarUrl) &&
            (identical(other.phoneNumber, phoneNumber) ||
                other.phoneNumber == phoneNumber) &&
            (identical(other.locale, locale) || other.locale == locale) &&
            (identical(other.timezone, timezone) ||
                other.timezone == timezone) &&
            (identical(other.tier, tier) || other.tier == tier) &&
            (identical(other.subscriptionId, subscriptionId) ||
                other.subscriptionId == subscriptionId) &&
            (identical(other.subscriptionExpiresAt, subscriptionExpiresAt) ||
                other.subscriptionExpiresAt == subscriptionExpiresAt) &&
            (identical(other.trialStartedAt, trialStartedAt) ||
                other.trialStartedAt == trialStartedAt) &&
            (identical(other.trialEndsAt, trialEndsAt) ||
                other.trialEndsAt == trialEndsAt) &&
            (identical(other.trialDaysRemaining, trialDaysRemaining) ||
                other.trialDaysRemaining == trialDaysRemaining) &&
            (identical(other.referralCode, referralCode) ||
                other.referralCode == referralCode) &&
            (identical(other.referredByUserId, referredByUserId) ||
                other.referredByUserId == referredByUserId) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt) &&
            (identical(other.lastLoginAt, lastLoginAt) ||
                other.lastLoginAt == lastLoginAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      email,
      name,
      avatarUrl,
      phoneNumber,
      locale,
      timezone,
      tier,
      subscriptionId,
      subscriptionExpiresAt,
      trialStartedAt,
      trialEndsAt,
      trialDaysRemaining,
      referralCode,
      referredByUserId,
      createdAt,
      updatedAt,
      lastLoginAt);

  @override
  String toString() {
    return 'User(id: $id, email: $email, name: $name, avatarUrl: $avatarUrl, phoneNumber: $phoneNumber, locale: $locale, timezone: $timezone, tier: $tier, subscriptionId: $subscriptionId, subscriptionExpiresAt: $subscriptionExpiresAt, trialStartedAt: $trialStartedAt, trialEndsAt: $trialEndsAt, trialDaysRemaining: $trialDaysRemaining, referralCode: $referralCode, referredByUserId: $referredByUserId, createdAt: $createdAt, updatedAt: $updatedAt, lastLoginAt: $lastLoginAt)';
  }
}

/// @nodoc
abstract mixin class $UserCopyWith<$Res> {
  factory $UserCopyWith(User value, $Res Function(User) _then) =
      _$UserCopyWithImpl;
  @useResult
  $Res call(
      {String id,
      String email,
      String name,
      @JsonKey(name: 'avatar_url') String? avatarUrl,
      @JsonKey(name: 'phone_number') String? phoneNumber,
      String locale,
      String timezone,
      SubscriptionTier tier,
      @JsonKey(name: 'subscription_id') String? subscriptionId,
      @JsonKey(name: 'subscription_expires_at') DateTime? subscriptionExpiresAt,
      @JsonKey(name: 'trial_started_at') DateTime? trialStartedAt,
      @JsonKey(name: 'trial_ends_at') DateTime? trialEndsAt,
      @JsonKey(name: 'trial_days_remaining') int trialDaysRemaining,
      @JsonKey(name: 'referral_code') String? referralCode,
      @JsonKey(name: 'referred_by_user_id') String? referredByUserId,
      @JsonKey(name: 'created_at') DateTime createdAt,
      @JsonKey(name: 'updated_at') DateTime updatedAt,
      @JsonKey(name: 'last_login_at') DateTime? lastLoginAt});
}

/// @nodoc
class _$UserCopyWithImpl<$Res> implements $UserCopyWith<$Res> {
  _$UserCopyWithImpl(this._self, this._then);

  final User _self;
  final $Res Function(User) _then;

  /// Create a copy of User
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? email = null,
    Object? name = null,
    Object? avatarUrl = freezed,
    Object? phoneNumber = freezed,
    Object? locale = null,
    Object? timezone = null,
    Object? tier = null,
    Object? subscriptionId = freezed,
    Object? subscriptionExpiresAt = freezed,
    Object? trialStartedAt = freezed,
    Object? trialEndsAt = freezed,
    Object? trialDaysRemaining = null,
    Object? referralCode = freezed,
    Object? referredByUserId = freezed,
    Object? createdAt = null,
    Object? updatedAt = null,
    Object? lastLoginAt = freezed,
  }) {
    return _then(_self.copyWith(
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      email: null == email
          ? _self.email
          : email // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _self.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      avatarUrl: freezed == avatarUrl
          ? _self.avatarUrl
          : avatarUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      phoneNumber: freezed == phoneNumber
          ? _self.phoneNumber
          : phoneNumber // ignore: cast_nullable_to_non_nullable
              as String?,
      locale: null == locale
          ? _self.locale
          : locale // ignore: cast_nullable_to_non_nullable
              as String,
      timezone: null == timezone
          ? _self.timezone
          : timezone // ignore: cast_nullable_to_non_nullable
              as String,
      tier: null == tier
          ? _self.tier
          : tier // ignore: cast_nullable_to_non_nullable
              as SubscriptionTier,
      subscriptionId: freezed == subscriptionId
          ? _self.subscriptionId
          : subscriptionId // ignore: cast_nullable_to_non_nullable
              as String?,
      subscriptionExpiresAt: freezed == subscriptionExpiresAt
          ? _self.subscriptionExpiresAt
          : subscriptionExpiresAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      trialStartedAt: freezed == trialStartedAt
          ? _self.trialStartedAt
          : trialStartedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      trialEndsAt: freezed == trialEndsAt
          ? _self.trialEndsAt
          : trialEndsAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      trialDaysRemaining: null == trialDaysRemaining
          ? _self.trialDaysRemaining
          : trialDaysRemaining // ignore: cast_nullable_to_non_nullable
              as int,
      referralCode: freezed == referralCode
          ? _self.referralCode
          : referralCode // ignore: cast_nullable_to_non_nullable
              as String?,
      referredByUserId: freezed == referredByUserId
          ? _self.referredByUserId
          : referredByUserId // ignore: cast_nullable_to_non_nullable
              as String?,
      createdAt: null == createdAt
          ? _self.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      updatedAt: null == updatedAt
          ? _self.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      lastLoginAt: freezed == lastLoginAt
          ? _self.lastLoginAt
          : lastLoginAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ));
  }
}

/// Adds pattern-matching-related methods to [User].
extension UserPatterns on User {
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
    TResult Function(_User value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _User() when $default != null:
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
    TResult Function(_User value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _User():
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
    TResult? Function(_User value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _User() when $default != null:
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
            String email,
            String name,
            @JsonKey(name: 'avatar_url') String? avatarUrl,
            @JsonKey(name: 'phone_number') String? phoneNumber,
            String locale,
            String timezone,
            SubscriptionTier tier,
            @JsonKey(name: 'subscription_id') String? subscriptionId,
            @JsonKey(name: 'subscription_expires_at')
            DateTime? subscriptionExpiresAt,
            @JsonKey(name: 'trial_started_at') DateTime? trialStartedAt,
            @JsonKey(name: 'trial_ends_at') DateTime? trialEndsAt,
            @JsonKey(name: 'trial_days_remaining') int trialDaysRemaining,
            @JsonKey(name: 'referral_code') String? referralCode,
            @JsonKey(name: 'referred_by_user_id') String? referredByUserId,
            @JsonKey(name: 'created_at') DateTime createdAt,
            @JsonKey(name: 'updated_at') DateTime updatedAt,
            @JsonKey(name: 'last_login_at') DateTime? lastLoginAt)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _User() when $default != null:
        return $default(
            _that.id,
            _that.email,
            _that.name,
            _that.avatarUrl,
            _that.phoneNumber,
            _that.locale,
            _that.timezone,
            _that.tier,
            _that.subscriptionId,
            _that.subscriptionExpiresAt,
            _that.trialStartedAt,
            _that.trialEndsAt,
            _that.trialDaysRemaining,
            _that.referralCode,
            _that.referredByUserId,
            _that.createdAt,
            _that.updatedAt,
            _that.lastLoginAt);
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
            String email,
            String name,
            @JsonKey(name: 'avatar_url') String? avatarUrl,
            @JsonKey(name: 'phone_number') String? phoneNumber,
            String locale,
            String timezone,
            SubscriptionTier tier,
            @JsonKey(name: 'subscription_id') String? subscriptionId,
            @JsonKey(name: 'subscription_expires_at')
            DateTime? subscriptionExpiresAt,
            @JsonKey(name: 'trial_started_at') DateTime? trialStartedAt,
            @JsonKey(name: 'trial_ends_at') DateTime? trialEndsAt,
            @JsonKey(name: 'trial_days_remaining') int trialDaysRemaining,
            @JsonKey(name: 'referral_code') String? referralCode,
            @JsonKey(name: 'referred_by_user_id') String? referredByUserId,
            @JsonKey(name: 'created_at') DateTime createdAt,
            @JsonKey(name: 'updated_at') DateTime updatedAt,
            @JsonKey(name: 'last_login_at') DateTime? lastLoginAt)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _User():
        return $default(
            _that.id,
            _that.email,
            _that.name,
            _that.avatarUrl,
            _that.phoneNumber,
            _that.locale,
            _that.timezone,
            _that.tier,
            _that.subscriptionId,
            _that.subscriptionExpiresAt,
            _that.trialStartedAt,
            _that.trialEndsAt,
            _that.trialDaysRemaining,
            _that.referralCode,
            _that.referredByUserId,
            _that.createdAt,
            _that.updatedAt,
            _that.lastLoginAt);
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
            String email,
            String name,
            @JsonKey(name: 'avatar_url') String? avatarUrl,
            @JsonKey(name: 'phone_number') String? phoneNumber,
            String locale,
            String timezone,
            SubscriptionTier tier,
            @JsonKey(name: 'subscription_id') String? subscriptionId,
            @JsonKey(name: 'subscription_expires_at')
            DateTime? subscriptionExpiresAt,
            @JsonKey(name: 'trial_started_at') DateTime? trialStartedAt,
            @JsonKey(name: 'trial_ends_at') DateTime? trialEndsAt,
            @JsonKey(name: 'trial_days_remaining') int trialDaysRemaining,
            @JsonKey(name: 'referral_code') String? referralCode,
            @JsonKey(name: 'referred_by_user_id') String? referredByUserId,
            @JsonKey(name: 'created_at') DateTime createdAt,
            @JsonKey(name: 'updated_at') DateTime updatedAt,
            @JsonKey(name: 'last_login_at') DateTime? lastLoginAt)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _User() when $default != null:
        return $default(
            _that.id,
            _that.email,
            _that.name,
            _that.avatarUrl,
            _that.phoneNumber,
            _that.locale,
            _that.timezone,
            _that.tier,
            _that.subscriptionId,
            _that.subscriptionExpiresAt,
            _that.trialStartedAt,
            _that.trialEndsAt,
            _that.trialDaysRemaining,
            _that.referralCode,
            _that.referredByUserId,
            _that.createdAt,
            _that.updatedAt,
            _that.lastLoginAt);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _User implements User {
  const _User(
      {required this.id,
      this.email = '',
      this.name = '',
      @JsonKey(name: 'avatar_url') this.avatarUrl,
      @JsonKey(name: 'phone_number') this.phoneNumber,
      this.locale = 'id_ID',
      this.timezone = 'Asia/Bangkok',
      this.tier = SubscriptionTier.free,
      @JsonKey(name: 'subscription_id') this.subscriptionId,
      @JsonKey(name: 'subscription_expires_at') this.subscriptionExpiresAt,
      @JsonKey(name: 'trial_started_at') this.trialStartedAt,
      @JsonKey(name: 'trial_ends_at') this.trialEndsAt,
      @JsonKey(name: 'trial_days_remaining') this.trialDaysRemaining = 0,
      @JsonKey(name: 'referral_code') this.referralCode,
      @JsonKey(name: 'referred_by_user_id') this.referredByUserId,
      @JsonKey(name: 'created_at') required this.createdAt,
      @JsonKey(name: 'updated_at') required this.updatedAt,
      @JsonKey(name: 'last_login_at') this.lastLoginAt});
  factory _User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  @override
  final String id;
  @override
  @JsonKey()
  final String email;
  @override
  @JsonKey()
  final String name;
  @override
  @JsonKey(name: 'avatar_url')
  final String? avatarUrl;
  @override
  @JsonKey(name: 'phone_number')
  final String? phoneNumber;
  @override
  @JsonKey()
  final String locale;
  @override
  @JsonKey()
  final String timezone;
  @override
  @JsonKey()
  final SubscriptionTier tier;
  @override
  @JsonKey(name: 'subscription_id')
  final String? subscriptionId;
  @override
  @JsonKey(name: 'subscription_expires_at')
  final DateTime? subscriptionExpiresAt;
  @override
  @JsonKey(name: 'trial_started_at')
  final DateTime? trialStartedAt;
  @override
  @JsonKey(name: 'trial_ends_at')
  final DateTime? trialEndsAt;
  @override
  @JsonKey(name: 'trial_days_remaining')
  final int trialDaysRemaining;
  @override
  @JsonKey(name: 'referral_code')
  final String? referralCode;
  @override
  @JsonKey(name: 'referred_by_user_id')
  final String? referredByUserId;
  @override
  @JsonKey(name: 'created_at')
  final DateTime createdAt;
  @override
  @JsonKey(name: 'updated_at')
  final DateTime updatedAt;
  @override
  @JsonKey(name: 'last_login_at')
  final DateTime? lastLoginAt;

  /// Create a copy of User
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$UserCopyWith<_User> get copyWith =>
      __$UserCopyWithImpl<_User>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$UserToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _User &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.email, email) || other.email == email) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.avatarUrl, avatarUrl) ||
                other.avatarUrl == avatarUrl) &&
            (identical(other.phoneNumber, phoneNumber) ||
                other.phoneNumber == phoneNumber) &&
            (identical(other.locale, locale) || other.locale == locale) &&
            (identical(other.timezone, timezone) ||
                other.timezone == timezone) &&
            (identical(other.tier, tier) || other.tier == tier) &&
            (identical(other.subscriptionId, subscriptionId) ||
                other.subscriptionId == subscriptionId) &&
            (identical(other.subscriptionExpiresAt, subscriptionExpiresAt) ||
                other.subscriptionExpiresAt == subscriptionExpiresAt) &&
            (identical(other.trialStartedAt, trialStartedAt) ||
                other.trialStartedAt == trialStartedAt) &&
            (identical(other.trialEndsAt, trialEndsAt) ||
                other.trialEndsAt == trialEndsAt) &&
            (identical(other.trialDaysRemaining, trialDaysRemaining) ||
                other.trialDaysRemaining == trialDaysRemaining) &&
            (identical(other.referralCode, referralCode) ||
                other.referralCode == referralCode) &&
            (identical(other.referredByUserId, referredByUserId) ||
                other.referredByUserId == referredByUserId) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt) &&
            (identical(other.lastLoginAt, lastLoginAt) ||
                other.lastLoginAt == lastLoginAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      email,
      name,
      avatarUrl,
      phoneNumber,
      locale,
      timezone,
      tier,
      subscriptionId,
      subscriptionExpiresAt,
      trialStartedAt,
      trialEndsAt,
      trialDaysRemaining,
      referralCode,
      referredByUserId,
      createdAt,
      updatedAt,
      lastLoginAt);

  @override
  String toString() {
    return 'User(id: $id, email: $email, name: $name, avatarUrl: $avatarUrl, phoneNumber: $phoneNumber, locale: $locale, timezone: $timezone, tier: $tier, subscriptionId: $subscriptionId, subscriptionExpiresAt: $subscriptionExpiresAt, trialStartedAt: $trialStartedAt, trialEndsAt: $trialEndsAt, trialDaysRemaining: $trialDaysRemaining, referralCode: $referralCode, referredByUserId: $referredByUserId, createdAt: $createdAt, updatedAt: $updatedAt, lastLoginAt: $lastLoginAt)';
  }
}

/// @nodoc
abstract mixin class _$UserCopyWith<$Res> implements $UserCopyWith<$Res> {
  factory _$UserCopyWith(_User value, $Res Function(_User) _then) =
      __$UserCopyWithImpl;
  @override
  @useResult
  $Res call(
      {String id,
      String email,
      String name,
      @JsonKey(name: 'avatar_url') String? avatarUrl,
      @JsonKey(name: 'phone_number') String? phoneNumber,
      String locale,
      String timezone,
      SubscriptionTier tier,
      @JsonKey(name: 'subscription_id') String? subscriptionId,
      @JsonKey(name: 'subscription_expires_at') DateTime? subscriptionExpiresAt,
      @JsonKey(name: 'trial_started_at') DateTime? trialStartedAt,
      @JsonKey(name: 'trial_ends_at') DateTime? trialEndsAt,
      @JsonKey(name: 'trial_days_remaining') int trialDaysRemaining,
      @JsonKey(name: 'referral_code') String? referralCode,
      @JsonKey(name: 'referred_by_user_id') String? referredByUserId,
      @JsonKey(name: 'created_at') DateTime createdAt,
      @JsonKey(name: 'updated_at') DateTime updatedAt,
      @JsonKey(name: 'last_login_at') DateTime? lastLoginAt});
}

/// @nodoc
class __$UserCopyWithImpl<$Res> implements _$UserCopyWith<$Res> {
  __$UserCopyWithImpl(this._self, this._then);

  final _User _self;
  final $Res Function(_User) _then;

  /// Create a copy of User
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? id = null,
    Object? email = null,
    Object? name = null,
    Object? avatarUrl = freezed,
    Object? phoneNumber = freezed,
    Object? locale = null,
    Object? timezone = null,
    Object? tier = null,
    Object? subscriptionId = freezed,
    Object? subscriptionExpiresAt = freezed,
    Object? trialStartedAt = freezed,
    Object? trialEndsAt = freezed,
    Object? trialDaysRemaining = null,
    Object? referralCode = freezed,
    Object? referredByUserId = freezed,
    Object? createdAt = null,
    Object? updatedAt = null,
    Object? lastLoginAt = freezed,
  }) {
    return _then(_User(
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      email: null == email
          ? _self.email
          : email // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _self.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      avatarUrl: freezed == avatarUrl
          ? _self.avatarUrl
          : avatarUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      phoneNumber: freezed == phoneNumber
          ? _self.phoneNumber
          : phoneNumber // ignore: cast_nullable_to_non_nullable
              as String?,
      locale: null == locale
          ? _self.locale
          : locale // ignore: cast_nullable_to_non_nullable
              as String,
      timezone: null == timezone
          ? _self.timezone
          : timezone // ignore: cast_nullable_to_non_nullable
              as String,
      tier: null == tier
          ? _self.tier
          : tier // ignore: cast_nullable_to_non_nullable
              as SubscriptionTier,
      subscriptionId: freezed == subscriptionId
          ? _self.subscriptionId
          : subscriptionId // ignore: cast_nullable_to_non_nullable
              as String?,
      subscriptionExpiresAt: freezed == subscriptionExpiresAt
          ? _self.subscriptionExpiresAt
          : subscriptionExpiresAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      trialStartedAt: freezed == trialStartedAt
          ? _self.trialStartedAt
          : trialStartedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      trialEndsAt: freezed == trialEndsAt
          ? _self.trialEndsAt
          : trialEndsAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      trialDaysRemaining: null == trialDaysRemaining
          ? _self.trialDaysRemaining
          : trialDaysRemaining // ignore: cast_nullable_to_non_nullable
              as int,
      referralCode: freezed == referralCode
          ? _self.referralCode
          : referralCode // ignore: cast_nullable_to_non_nullable
              as String?,
      referredByUserId: freezed == referredByUserId
          ? _self.referredByUserId
          : referredByUserId // ignore: cast_nullable_to_non_nullable
              as String?,
      createdAt: null == createdAt
          ? _self.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      updatedAt: null == updatedAt
          ? _self.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      lastLoginAt: freezed == lastLoginAt
          ? _self.lastLoginAt
          : lastLoginAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ));
  }
}

// dart format on
