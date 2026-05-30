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
