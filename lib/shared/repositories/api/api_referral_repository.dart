import 'package:dio/dio.dart';

import '../../models/referral.dart';
import '../referral_repository.dart';
import 'api_repository_helpers.dart';

class ApiReferralRepository implements ReferralRepository {
  ApiReferralRepository({Dio? dio})
      : _client = ApiResourceClient<Referral>(
          path: '/referrals',
          fromJson: Referral.fromJson,
          toJson: (referral) => referral.toJson(),
          idOf: (referral) => referral.id,
          dio: dio,
        );

  final ApiResourceClient<Referral> _client;

  @override
  Future<List<Referral>> getAll({
    String? referrerUserId,
    String? refereeUserId,
  }) {
    return _client.getAll(query: {
      'referrer_user_id': referrerUserId,
      'referee_user_id': refereeUserId,
    });
  }

  @override
  Future<Referral?> getById(String id) => _client.getById(id);

  @override
  Future<Referral> create(Referral referral) => _client.create(referral);

  @override
  Future<Referral> update(Referral referral) => _client.update(referral);

  @override
  Future<void> delete(String id) => _client.delete(id);

  @override
  Stream<List<Referral>> watch({
    String? referrerUserId,
    String? refereeUserId,
  }) async* {
    yield await getAll(
      referrerUserId: referrerUserId,
      refereeUserId: refereeUserId,
    );
  }
}
