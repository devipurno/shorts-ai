import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http_mock_adapter/http_mock_adapter.dart';
import 'package:shorts_ai/core/ai/cache/upstash_client.dart';

void main() {
  group('UpstashClient', () {
    late Dio dio;
    late DioAdapter adapter;

    setUp(() {
      dio = Dio(BaseOptions(baseUrl: 'https://upstash.test'));
      adapter = DioAdapter(dio: dio);
    });

    test('isConfigured returns false when url or token is null', () {
      final client = UpstashClient(dio: dio, restUrl: null, token: null);
      expect(client.isConfigured, isFalse);
    });

    test('isConfigured returns false when url is empty', () {
      final client = UpstashClient(dio: dio, restUrl: '', token: 'tok');
      expect(client.isConfigured, isFalse);
    });

    test('isConfigured returns false when token is empty', () {
      final client =
          UpstashClient(dio: dio, restUrl: 'https://upstash.test', token: '');
      expect(client.isConfigured, isFalse);
    });

    test('isConfigured returns true when both url and token are set', () {
      final client = UpstashClient(
        dio: dio,
        restUrl: 'https://upstash.test',
        token: 'secret',
      );
      expect(client.isConfigured, isTrue);
    });

    test('get sends GET pipeline and returns result', () async {
      final client = UpstashClient(
        dio: dio,
        restUrl: 'https://upstash.test',
        token: 'tok',
      );
      adapter.onPost(
        'https://upstash.test/pipeline',
        (server) => server.reply(200, [
          {'result': 'cached_value'}
        ]),
        data: [
          ['GET', 'my_key']
        ],
      );
      final result = await client.get('my_key');
      expect(result, 'cached_value');
    });

    test('get returns null when result is null', () async {
      final client = UpstashClient(
        dio: dio,
        restUrl: 'https://upstash.test',
        token: 'tok',
      );
      adapter.onPost(
        'https://upstash.test/pipeline',
        (server) => server.reply(200, [
          {'result': null}
        ]),
        data: [
          ['GET', 'missing']
        ],
      );
      final result = await client.get('missing');
      expect(result, isNull);
    });

    test('set sends SET pipeline with EX when ttl is provided', () async {
      final client = UpstashClient(
        dio: dio,
        restUrl: 'https://upstash.test',
        token: 'tok',
      );
      adapter.onPost(
        'https://upstash.test/pipeline',
        (server) => server.reply(200, [
          {'result': 'OK'}
        ]),
        data: [
          ['SET', 'k', 'v', 'EX', 60]
        ],
      );
      await client.set('k', 'v', ttl: const Duration(seconds: 60));
    });

    test('set sends SET pipeline without EX when no ttl', () async {
      final client = UpstashClient(
        dio: dio,
        restUrl: 'https://upstash.test',
        token: 'tok',
      );
      adapter.onPost(
        'https://upstash.test/pipeline',
        (server) => server.reply(200, [
          {'result': 'OK'}
        ]),
        data: [
          ['SET', 'k', 'v']
        ],
      );
      await client.set('k', 'v');
    });

    test('delete sends DEL pipeline', () async {
      final client = UpstashClient(
        dio: dio,
        restUrl: 'https://upstash.test',
        token: 'tok',
      );
      adapter.onPost(
        'https://upstash.test/pipeline',
        (server) => server.reply(200, [
          {'result': 1}
        ]),
        data: [
          ['DEL', 'k']
        ],
      );
      await client.delete('k');
    });

    test('pipeline throws StateError when not configured', () {
      final client = UpstashClient(dio: dio, restUrl: null, token: null);
      expect(
        () => client.pipeline([
          ['GET', 'x']
        ]),
        throwsStateError,
      );
    });

    test('pipeline throws on error response item', () async {
      final client = UpstashClient(
        dio: dio,
        restUrl: 'https://upstash.test',
        token: 'tok',
      );
      adapter.onPost(
        'https://upstash.test/pipeline',
        (server) => server.reply(200, [
          {'error': 'WRONGTYPE Operation against a key'}
        ]),
        data: [
          ['GET', 'bad']
        ],
      );
      expect(
        () => client.get('bad'),
        throwsStateError,
      );
    });

    test('pipeline strips trailing slash from restUrl', () async {
      final client = UpstashClient(
        dio: dio,
        restUrl: 'https://upstash.test/',
        token: 'tok',
      );
      adapter.onPost(
        'https://upstash.test/pipeline',
        (server) => server.reply(200, [
          {'result': 'ok'}
        ]),
        data: [
          ['GET', 'x']
        ],
      );
      expect(await client.get('x'), 'ok');
    });
  });
}
