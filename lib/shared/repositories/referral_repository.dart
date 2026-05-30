import '../models/referral.dart';

abstract class ReferralRepository {
  Future<List<Referral>> getAll({
    String? referrerUserId,
    String? refereeUserId,
  });

  Future<Referral?> getById(String id);

  Future<Referral> create(Referral referral);

  Future<Referral> update(Referral referral);

  Future<void> delete(String id);

  Stream<List<Referral>> watch({
    String? referrerUserId,
    String? refereeUserId,
  });
}
