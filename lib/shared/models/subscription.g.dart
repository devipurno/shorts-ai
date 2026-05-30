// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'subscription.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Subscription _$SubscriptionFromJson(Map<String, dynamic> json) =>
    _Subscription(
      id: json['id'] as String,
      userId: json['user_id'] as String,
      tier: $enumDecodeNullable(_$SubscriptionTierEnumMap, json['tier']) ??
          SubscriptionTier.free,
      status:
          $enumDecodeNullable(_$SubscriptionStatusEnumMap, json['status']) ??
              SubscriptionStatus.active,
      startedAt: DateTime.parse(json['started_at'] as String),
      expiresAt: json['expires_at'] == null
          ? null
          : DateTime.parse(json['expires_at'] as String),
      cancelledAt: json['cancelled_at'] == null
          ? null
          : DateTime.parse(json['cancelled_at'] as String),
      paymentMethod: json['payment_method'] as String?,
      autoRenew: json['auto_renew'] as bool? ?? false,
      source:
          $enumDecodeNullable(_$SubscriptionSourceEnumMap, json['source']) ??
              SubscriptionSource.trial,
    );

Map<String, dynamic> _$SubscriptionToJson(_Subscription instance) =>
    <String, dynamic>{
      'id': instance.id,
      'user_id': instance.userId,
      'tier': _$SubscriptionTierEnumMap[instance.tier]!,
      'status': _$SubscriptionStatusEnumMap[instance.status]!,
      'started_at': instance.startedAt.toIso8601String(),
      'expires_at': instance.expiresAt?.toIso8601String(),
      'cancelled_at': instance.cancelledAt?.toIso8601String(),
      'payment_method': instance.paymentMethod,
      'auto_renew': instance.autoRenew,
      'source': _$SubscriptionSourceEnumMap[instance.source]!,
    };

const _$SubscriptionTierEnumMap = {
  SubscriptionTier.free: 'free',
  SubscriptionTier.standard: 'standard',
  SubscriptionTier.premium: 'premium',
  SubscriptionTier.lifetime: 'lifetime',
};

const _$SubscriptionStatusEnumMap = {
  SubscriptionStatus.active: 'active',
  SubscriptionStatus.paused: 'paused',
  SubscriptionStatus.cancelled: 'cancelled',
  SubscriptionStatus.expired: 'expired',
};

const _$SubscriptionSourceEnumMap = {
  SubscriptionSource.trial: 'trial',
  SubscriptionSource.monthly: 'monthly',
  SubscriptionSource.yearly: 'yearly',
  SubscriptionSource.lifetime: 'lifetime',
  SubscriptionSource.referralCredit: 'referral_credit',
};
