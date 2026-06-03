import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shorts_ai/core/ai/models/ai_request.dart';
import 'package:shorts_ai/core/ai/providers/provider_utils.dart';
import 'package:shorts_ai/core/utils/result.dart';

void main() {
  group('aiFailure', () {
    test('maps DioException connectionTimeout to timeout error', () {
      final error = DioException(
        type: DioExceptionType.connectionTimeout,
        requestOptions: RequestOptions(path: '/ai'),
        message: 'timed out',
      );
      final result = aiFailure<LLMResponse>('gemini', error);
      expect(result, isA<Failure<LLMResponse, AIProviderError>>());
      final failure = result as Failure<LLMResponse, AIProviderError>;
      expect(failure.error, isA<TimeoutAIError>());
      expect((failure.error as TimeoutAIError).provider, 'gemini');
    });

    test('maps DioException receiveTimeout to timeout error', () {
      final error = DioException(
        type: DioExceptionType.receiveTimeout,
        requestOptions: RequestOptions(path: '/ai'),
      );
      final result = aiFailure<LLMResponse>('groq', error);
      final failure = result as Failure<LLMResponse, AIProviderError>;
      expect(failure.error, isA<TimeoutAIError>());
    });

    test('maps DioException sendTimeout to timeout error', () {
      final error = DioException(
        type: DioExceptionType.sendTimeout,
        requestOptions: RequestOptions(path: '/ai'),
      );
      final result = aiFailure<LLMResponse>('deepseek', error);
      final failure = result as Failure<LLMResponse, AIProviderError>;
      expect(failure.error, isA<TimeoutAIError>());
    });

    test('maps 429 status to quotaExceeded', () {
      final error = DioException(
        type: DioExceptionType.badResponse,
        requestOptions: RequestOptions(path: '/ai'),
        response: Response(
          statusCode: 429,
          requestOptions: RequestOptions(path: '/ai'),
        ),
      );
      final result = aiFailure<LLMResponse>('gemini', error);
      final failure = result as Failure<LLMResponse, AIProviderError>;
      expect(failure.error, isA<QuotaExceeded>());
      expect((failure.error as QuotaExceeded).provider, 'gemini');
    });

    test('maps generic DioException to networkError', () {
      final error = DioException(
        type: DioExceptionType.badResponse,
        requestOptions: RequestOptions(path: '/ai'),
        response: Response(
          statusCode: 500,
          requestOptions: RequestOptions(path: '/ai'),
        ),
        message: 'Server error',
      );
      final result = aiFailure<LLMResponse>('groq', error);
      final failure = result as Failure<LLMResponse, AIProviderError>;
      expect(failure.error, isA<NetworkAIError>());
    });

    test('maps non-DioException to invalidResponse', () {
      final result = aiFailure<LLMResponse>('groq', FormatException('bad'));
      final failure = result as Failure<LLMResponse, AIProviderError>;
      expect(failure.error, isA<InvalidAIResponse>());
      expect((failure.error as InvalidAIResponse).provider, 'groq');
    });
  });

  group('bearerHeaders', () {
    test('returns Authorization and Content-Type headers', () {
      final headers = bearerHeaders('my-token');
      expect(headers['Authorization'], 'Bearer my-token');
      expect(headers['Content-Type'], 'application/json');
    });
  });

  group('AIResultX', () {
    test('isSuccess returns true for Success', () {
      const result =
          Result<LLMResponse, AIProviderError>.success(
            LLMResponse(text: 'hi', provider: 'test'),
          );
      expect(result.isSuccess, isTrue);
    });

    test('isSuccess returns false for Failure', () {
      const result = Result<LLMResponse, AIProviderError>.failure(
        AIProviderError.allProvidersExhausted(),
      );
      expect(result.isSuccess, isFalse);
    });

    test('valueOrNull returns value for Success', () {
      const result =
          Result<LLMResponse, AIProviderError>.success(
            LLMResponse(text: 'hello', provider: 'gemini'),
          );
      expect(result.valueOrNull, isNotNull);
      expect(result.valueOrNull!.text, 'hello');
    });

    test('valueOrNull returns null for Failure', () {
      const result = Result<LLMResponse, AIProviderError>.failure(
        AIProviderError.allProvidersExhausted(),
      );
      expect(result.valueOrNull, isNull);
    });

    test('errorOrNull returns error for Failure', () {
      const result = Result<LLMResponse, AIProviderError>.failure(
        AIProviderError.quotaExceeded(provider: 'gemini'),
      );
      expect(result.errorOrNull, isA<QuotaExceeded>());
    });

    test('errorOrNull returns null for Success', () {
      const result =
          Result<LLMResponse, AIProviderError>.success(
            LLMResponse(text: 'ok', provider: 'test'),
          );
      expect(result.errorOrNull, isNull);
    });
  });
}
