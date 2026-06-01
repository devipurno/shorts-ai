import 'dart:async';
import 'dart:io';

import 'package:faker/faker.dart';

import '../../models/user.dart';
import '../user_repository.dart';
import 'mock_repository_utils.dart';

/// Public API surface for `MockUserRepository`.
class MockUserRepository implements UserRepository {
  MockUserRepository({
    MockRepositoryConfig config = const MockRepositoryConfig(),
  })  : _runtime = MockRepositoryRuntime(config),
        _faker = Faker() {
    _users.addAll(_seedUsers());
  }

  final MockRepositoryRuntime _runtime;
  final Faker _faker;
  final _controller = StreamController<void>.broadcast();
  final _users = <User>[];

  @override
  Future<User?> getProfile(String userId) => getById(userId);

  @override
  Future<User?> getById(String id) async {
    await _runtime.simulateNetwork();
    return _users.where((user) => user.id == id).firstOrNull;
  }

  @override
  Future<User> updateProfile(User user) async {
    await _runtime.simulateNetwork();
    final index = _users.indexWhere((item) => item.id == user.id);
    final updated = user.copyWith(updatedAt: DateTime.now().toUtc());
    if (index == -1) {
      _users.add(updated);
    } else {
      _users[index] = updated;
    }
    _emit();
    return updated;
  }

  @override
  Future<String> uploadAvatar(File file, {required String userId}) async {
    await _runtime.simulateNetwork();
    return 'https://mock.autoshort.local/avatars/$userId/${file.uri.pathSegments.last}';
  }

  @override
  Stream<User?> watchProfile(String userId) async* {
    await _runtime.simulateNetwork();
    yield _find(userId);
    yield* _controller.stream.map((_) => _find(userId));
  }

  List<User> _seedUsers() {
    return List<User>.generate(8, (index) {
      final now = DateTime.now().toUtc().subtract(Duration(days: index));
      final email = _faker.internet.email();
      return User(
        id: 'user_${index + 1}',
        email: email,
        name: _faker.person.name(),
        avatarUrl: 'https://i.pravatar.cc/256?u=$email',
        phoneNumber: '+62812${1000000 + _runtime.nextInt(8999999)}',
        locale: 'id_ID',
        timezone: 'Asia/Bangkok',
        tier: SubscriptionTier.values[index % SubscriptionTier.values.length],
        referralCode: 'AS${1000 + index}',
        createdAt: now,
        updatedAt: now,
        lastLoginAt: now,
      );
    });
  }

  User? _find(String id) => _users.where((user) => user.id == id).firstOrNull;

  void _emit() => _controller.add(null);
}
