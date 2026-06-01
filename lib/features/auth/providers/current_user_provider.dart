import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/user.dart';
import 'auth_provider.dart';

final currentUserProvider = Provider<User?>((ref) {
  final authState = ref.watch(authProvider);
  return switch (authState) {
    Authenticated(:final user) => user,
    _ => null,
  };
});

final displayNameProvider = Provider<String>((ref) {
  final authState = ref.watch(authProvider);
  return switch (authState) {
    Authenticated(:final user) => _displayNameFromFeatureUser(user),
    _ => 'Devi',
  };
});

String _displayNameFromFeatureUser(User user) {
  final name = user.name?.trim();
  if (name != null && name.isNotEmpty) {
    return name;
  }
  if (user.email.contains('@')) {
    return user.email.split('@').first;
  }
  return 'Devi';
}
