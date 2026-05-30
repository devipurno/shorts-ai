import 'package:freezed_annotation/freezed_annotation.dart';

part 'user.freezed.dart';
part 'user.g.dart';

@JsonEnum(fieldRename: FieldRename.snake)
enum SubscriptionTier { free, standard, premium, lifetime }

@freezed
abstract class User with _$User {
  const factory User({
    required String id,
    @Default('') String email,
    @Default('') String name,
    @JsonKey(name: 'avatar_url') String? avatarUrl,
    @JsonKey(name: 'phone_number') String? phoneNumber,
    @Default('id_ID') String locale,
    @Default('Asia/Bangkok') String timezone,
    @Default(SubscriptionTier.free) SubscriptionTier tier,
    @JsonKey(name: 'subscription_id') String? subscriptionId,
    @JsonKey(name: 'subscription_expires_at') DateTime? subscriptionExpiresAt,
    @JsonKey(name: 'trial_started_at') DateTime? trialStartedAt,
    @JsonKey(name: 'trial_ends_at') DateTime? trialEndsAt,
    @JsonKey(name: 'trial_days_remaining') @Default(0) int trialDaysRemaining,
    @JsonKey(name: 'referral_code') String? referralCode,
    @JsonKey(name: 'referred_by_user_id') String? referredByUserId,
    @JsonKey(name: 'created_at') required DateTime createdAt,
    @JsonKey(name: 'updated_at') required DateTime updatedAt,
    @JsonKey(name: 'last_login_at') DateTime? lastLoginAt,
  }) = _User;

  factory User.fromJson(Map<String, Object?> json) => _$UserFromJson(json);
}
