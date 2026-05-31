import 'package:dio/dio.dart';

import '../ai_service.dart';
import '../models/ai_request.dart';
import '../../utils/result.dart';

AIResult<T> aiFailure<T>(String provider, Object error) {
  if (error is DioException) {
    if (error.type == DioExceptionType.connectionTimeout ||
        error.type == DioExceptionType.receiveTimeout ||
        error.type == DioExceptionType.sendTimeout) {
      return Result.failure(
        AIProviderError.timeout(provider: provider, message: error.message ?? ''),
      );
    }
    final status = error.response?.statusCode;
    if (status == 429) {
      return Result.failure(
        AIProviderError.quotaExceeded(provider: provider, message: 'Quota exceeded'),
      );
    }
    return Result.failure(
      AIProviderError.networkError(
        provider: provider,
        message: error.message ?? error.toString(),
      ),
    );
  }

  return Result.failure(
    AIProviderError.invalidResponse(provider: provider, message: error.toString()),
  );
}

Map<String, String> bearerHeaders(String token) => {
      'Authorization': 'Bearer $token',
      'Content-Type': 'application/json',
    };

extension AIResultX<T> on AIResult<T> {
  bool get isSuccess => this is Success<T, AIProviderError>;

  T? get valueOrNull => switch (this) {
        Success<T, AIProviderError>(:final value) => value,
        _ => null,
      };

  AIProviderError? get errorOrNull => switch (this) {
        Failure<T, AIProviderError>(:final error) => error,
        _ => null,
      };
}
