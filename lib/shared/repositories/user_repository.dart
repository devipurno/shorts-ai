import '../models/user.dart';

abstract class UserRepository {
  Future<User?> getProfile(String userId);

  Future<User?> getById(String id);

  Future<User> updateProfile(User user);

  Stream<User?> watchProfile(String userId);
}
