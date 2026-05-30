import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shorts_ai/features/auth/models/user.dart';
import 'package:shorts_ai/features/auth/providers/auth_provider.dart';
import 'package:shorts_ai/features/auth/providers/current_user_provider.dart';

void main() {
  ProviderContainer createContainer() {
    final container = ProviderContainer(
      overrides: [
        authMockDelayProvider.overrideWithValue(Duration.zero),
      ],
    );
    addTearDown(container.dispose);
    return container;
  }

  test('authProvider starts unauthenticated', () {
    final container = createContainer();

    expect(container.read(authProvider), isA<Unauthenticated>());
    expect(container.read(currentUserProvider), isNull);
  });

  test('mock login success transitions to Authenticated', () async {
    final container = createContainer();
    final states = <AuthState>[];

    container.listen<AuthState>(
      authProvider,
      (previous, next) => states.add(next),
      fireImmediately: true,
    );

    await container
        .read(authProvider.notifier)
        .login('devi@autoshort.id', 'secret');

    final state = container.read(authProvider);
    expect(states.first, isA<Unauthenticated>());
    expect(states, contains(isA<Authenticating>()));
    expect(state, isA<Authenticated>());
    expect(container.read(currentUserProvider), isA<User>());
    expect((state as Authenticated).user.email, 'devi@autoshort.id');
  });

  test('mock login fail transitions to AuthError', () async {
    final container = createContainer();

    await container.read(authProvider.notifier).login('fail@test.id', 'secret');

    final state = container.read(authProvider);
    expect(state, isA<AuthError>());
    expect((state as AuthError).message, contains('Invalid mock credentials'));
    expect(container.read(currentUserProvider), isNull);
  });

  test('signup, refreshSession, and logout transition safely', () async {
    final container = createContainer();
    final notifier = container.read(authProvider.notifier);

    await notifier.signup('new@autoshort.id', 'secret', 'New Creator');
    expect(container.read(authProvider), isA<Authenticated>());

    await notifier.refreshSession();
    expect(container.read(authProvider), isA<Authenticated>());

    await notifier.logout();
    expect(container.read(authProvider), isA<Unauthenticated>());

    await notifier.refreshSession();
    expect(container.read(authProvider), isA<Unauthenticated>());
  });
}
