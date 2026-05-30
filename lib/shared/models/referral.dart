import 'package:freezed_annotation/freezed_annotation.dart';

part 'referral.freezed.dart';
part 'referral.g.dart';

@JsonEnum(fieldRename: FieldRename.snake)
enum ReferralStatus { pending, confirmed, rewarded }

@freezed
abstract class Referral with _$Referral {
  const factory Referral({
    required String id,
    @JsonKey(name: 'referrer_user_id') required String referrerUserId,
    @JsonKey(name: 'referee_user_id') required String refereeUserId,
    @Default(ReferralStatus.pending) ReferralStatus status,
    @JsonKey(name: 'reward_amount') @Default(0) double rewardAmount,
    @JsonKey(name: 'rewarded_at') DateTime? rewardedAt,
  }) = _Referral;

  factory Referral.fromJson(Map<String, Object?> json) =>
      _$ReferralFromJson(json);
}
