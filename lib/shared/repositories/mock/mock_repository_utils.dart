import 'dart:math';

import 'package:flutter/foundation.dart';

import '../../../core/errors/app_exception.dart';

class MockRepositoryConfig {
  const MockRepositoryConfig({
    this.minDelay = const Duration(milliseconds: 200),
    this.maxDelay = const Duration(milliseconds: 800),
    this.enableRandomFailures = kDebugMode,
    this.failRate = 0.05,
    this.randomSeed,
  });

  const MockRepositoryConfig.test()
      : minDelay = Duration.zero,
        maxDelay = Duration.zero,
        enableRandomFailures = false,
        failRate = 0,
        randomSeed = 7;

  final Duration minDelay;
  final Duration maxDelay;
  final bool enableRandomFailures;
  final double failRate;
  final int? randomSeed;
}

class MockRepositoryRuntime {
  MockRepositoryRuntime(this.config) : _random = Random(config.randomSeed);

  final MockRepositoryConfig config;
  final Random _random;

  Future<void> simulateNetwork() async {
    final delay = _nextDelay();
    if (delay > Duration.zero) {
      await Future<void>.delayed(delay);
    }

    if (kDebugMode &&
        config.enableRandomFailures &&
        _random.nextDouble() < config.failRate) {
      throw const NetworkException(
        'Mock network failure.',
        code: 'mock_random_failure',
      );
    }
  }

  int nextInt(int max) => _random.nextInt(max);

  double nextDouble() => _random.nextDouble();

  Duration _nextDelay() {
    final minMs = config.minDelay.inMilliseconds;
    final maxMs = config.maxDelay.inMilliseconds;
    if (maxMs <= minMs) {
      return Duration(milliseconds: minMs);
    }
    return Duration(milliseconds: minMs + _random.nextInt(maxMs - minMs + 1));
  }
}
