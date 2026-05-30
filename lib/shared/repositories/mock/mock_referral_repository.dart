import 'dart:async';

import '../../../core/errors/app_exception.dart';
import '../../models/referral.dart';
import '../referral_repository.dart';
import 'mock_repository_utils.dart';

class MockReferralRepository implements ReferralRepository {
  MockReferralRepository({
    MockRepositoryConfig config = const MockRepositoryConfig(),
  }) : _runtime = MockRepositoryRuntime(config) {
    _referrals.addAll(_seedReferrals());
  }

  final MockRepositoryRuntime _runtime;
  final _controller = StreamController<void>.broadcast();
  final _referrals = <Referral>[];

  @override
  Future<List<Referral>> getAll({
    String? referrerUserId,
    String? refereeUserId,
  }) async {
    await _runtime.simulateNetwork();
    return List<Referral>.unmodifiable(_filter(referrerUserId, refereeUserId));
  }

  @override
  Future<Referral?> getById(String id) async {
    await _runtime.simulateNetwork();
    return _referrals.where((referral) => referral.id == id).firstOrNull;
  }

  @override
  Future<Referral> create(Referral referral) async {
    await _runtime.simulateNetwork();
    _referrals.add(referral);
    _emit();
    return referral;
  }

  @override
  Future<Referral> update(Referral referral) async {
    await _runtime.simulateNetwork();
    final index = _referrals.indexWhere((item) => item.id == referral.id);
    if (index == -1) {
      throw const NotFoundException(
        'Referral not found.',
        code: 'referral_not_found',
      );
    }
    _referrals[index] = referral;
    _emit();
    return referral;
  }

  @override
  Future<void> delete(String id) async {
    await _runtime.simulateNetwork();
    _referrals.removeWhere((referral) => referral.id == id);
    _emit();
  }

  @override
  Stream<List<Referral>> watch({
    String? referrerUserId,
    String? refereeUserId,
  }) async* {
    await _runtime.simulateNetwork();
    yield List<Referral>.unmodifiable(_filter(referrerUserId, refereeUserId));
    yield* _controller.stream.map(
      (_) =>
          List<Referral>.unmodifiable(_filter(referrerUserId, refereeUserId)),
    );
  }

  List<Referral> _seedReferrals() {
    return List<Referral>.generate(6, (index) {
      final rewarded = index % 3 == 0;
      return Referral(
        id: 'referral_${index + 1}',
        referrerUserId: 'user_${index % 3 + 1}',
        refereeUserId: 'user_${index + 10}',
        status: ReferralStatus.values[index % ReferralStatus.values.length],
        rewardAmount: rewarded ? 30000 : 0,
        rewardedAt: rewarded ? DateTime.now().toUtc() : null,
      );
    });
  }

  List<Referral> _filter(String? referrerUserId, String? refereeUserId) {
    return _referrals.where((referral) {
      final matchesReferrer =
          referrerUserId == null || referral.referrerUserId == referrerUserId;
      final matchesReferee =
          refereeUserId == null || referral.refereeUserId == refereeUserId;
      return matchesReferrer && matchesReferee;
    }).toList();
  }

  void _emit() => _controller.add(null);
}
