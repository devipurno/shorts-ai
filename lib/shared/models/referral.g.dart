// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'referral.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Referral _$ReferralFromJson(Map<String, dynamic> json) => _Referral(
      id: json['id'] as String,
      referrerUserId: json['referrer_user_id'] as String,
      refereeUserId: json['referee_user_id'] as String,
      status: $enumDecodeNullable(_$ReferralStatusEnumMap, json['status']) ??
          ReferralStatus.pending,
      rewardAmount: (json['reward_amount'] as num?)?.toDouble() ?? 0,
      rewardedAt: json['rewarded_at'] == null
          ? null
          : DateTime.parse(json['rewarded_at'] as String),
    );

Map<String, dynamic> _$ReferralToJson(_Referral instance) => <String, dynamic>{
      'id': instance.id,
      'referrer_user_id': instance.referrerUserId,
      'referee_user_id': instance.refereeUserId,
      'status': _$ReferralStatusEnumMap[instance.status]!,
      'reward_amount': instance.rewardAmount,
      'rewarded_at': instance.rewardedAt?.toIso8601String(),
    };

const _$ReferralStatusEnumMap = {
  ReferralStatus.pending: 'pending',
  ReferralStatus.confirmed: 'confirmed',
  ReferralStatus.rewarded: 'rewarded',
};
