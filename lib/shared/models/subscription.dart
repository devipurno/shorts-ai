import 'package:freezed_annotation/freezed_annotation.dart';

import 'user.dart';

part 'subscription.freezed.dart';
part 'subscription.g.dart';

@JsonEnum(fieldRename: FieldRename.snake)
enum SubscriptionStatus { active, paused, cancelled, expired }

@JsonEnum(fieldRename: FieldRename.snake)
enum SubscriptionSource { trial, monthly, yearly, lifetime, referralCredit }

@freezed
abstract class Subscription with _$Subscription {
  const factory Subscription({
    required String id,
    @JsonKey(name: 'user_id') required String userId,
    @Default(SubscriptionTier.free) SubscriptionTier tier,
    @Default(SubscriptionStatus.active) SubscriptionStatus status,
    @JsonKey(name: 'started_at') required DateTime startedAt,
    @JsonKey(name: 'expires_at') DateTime? expiresAt,
    @JsonKey(name: 'cancelled_at') DateTime? cancelledAt,
    @JsonKey(name: 'payment_method') String? paymentMethod,
    @JsonKey(name: 'auto_renew') @Default(false) bool autoRenew,
    @Default(SubscriptionSource.trial) SubscriptionSource source,
  }) = _Subscription;

  factory Subscription.fromJson(Map<String, Object?> json) =>
      _$SubscriptionFromJson(json);
}
