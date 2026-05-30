// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_User _$UserFromJson(Map<String, dynamic> json) => _User(
      id: json['id'] as String,
      email: json['email'] as String? ?? '',
      name: json['name'] as String? ?? '',
      avatarUrl: json['avatar_url'] as String?,
      phoneNumber: json['phone_number'] as String?,
      locale: json['locale'] as String? ?? 'id_ID',
      timezone: json['timezone'] as String? ?? 'Asia/Bangkok',
      tier: $enumDecodeNullable(_$SubscriptionTierEnumMap, json['tier']) ??
          SubscriptionTier.free,
      subscriptionId: json['subscription_id'] as String?,
      subscriptionExpiresAt: json['subscription_expires_at'] == null
          ? null
          : DateTime.parse(json['subscription_expires_at'] as String),
      trialStartedAt: json['trial_started_at'] == null
          ? null
          : DateTime.parse(json['trial_started_at'] as String),
      trialEndsAt: json['trial_ends_at'] == null
          ? null
          : DateTime.parse(json['trial_ends_at'] as String),
      trialDaysRemaining: (json['trial_days_remaining'] as num?)?.toInt() ?? 0,
      referralCode: json['referral_code'] as String?,
      referredByUserId: json['referred_by_user_id'] as String?,
      createdAt: DateTime.parse(json['created_at'] as String),
      updatedAt: DateTime.parse(json['updated_at'] as String),
      lastLoginAt: json['last_login_at'] == null
          ? null
          : DateTime.parse(json['last_login_at'] as String),
    );

Map<String, dynamic> _$UserToJson(_User instance) => <String, dynamic>{
      'id': instance.id,
      'email': instance.email,
      'name': instance.name,
      'avatar_url': instance.avatarUrl,
      'phone_number': instance.phoneNumber,
      'locale': instance.locale,
      'timezone': instance.timezone,
      'tier': _$SubscriptionTierEnumMap[instance.tier]!,
      'subscription_id': instance.subscriptionId,
      'subscription_expires_at':
          instance.subscriptionExpiresAt?.toIso8601String(),
      'trial_started_at': instance.trialStartedAt?.toIso8601String(),
      'trial_ends_at': instance.trialEndsAt?.toIso8601String(),
      'trial_days_remaining': instance.trialDaysRemaining,
      'referral_code': instance.referralCode,
      'referred_by_user_id': instance.referredByUserId,
      'created_at': instance.createdAt.toIso8601String(),
      'updated_at': instance.updatedAt.toIso8601String(),
      'last_login_at': instance.lastLoginAt?.toIso8601String(),
    };

const _$SubscriptionTierEnumMap = {
  SubscriptionTier.free: 'free',
  SubscriptionTier.standard: 'standard',
  SubscriptionTier.premium: 'premium',
  SubscriptionTier.lifetime: 'lifetime',
};
