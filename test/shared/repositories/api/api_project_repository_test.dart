import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http_mock_adapter/http_mock_adapter.dart';
import 'package:shorts_ai/core/errors/app_exception.dart';
import 'package:shorts_ai/core/network/dio_client.dart';
import 'package:shorts_ai/shared/models/project.dart';
import 'package:shorts_ai/shared/repositories/api/api_project_repository.dart';

void main() {
  late Dio dio;
  late DioAdapter adapter;
  late ApiProjectRepository repository;

  setUp(() {
    dio = Dio(BaseOptions(baseUrl: 'https://api.autoshort.test'));
    adapter = DioAdapter(dio: dio);
    dio.interceptors.add(ErrorMappingInterceptor());
    repository = ApiProjectRepository(dio: dio);
  });

  test('getAll sends user filter and parses wrapped data list', () async {
    adapter.onGet(
      '/projects',
      queryParameters: {'user_id': 'user_1'},
      (server) => server.reply(200, {
        'ok': true,
        'data': [_projectJson('project_1')],
      }),
    );

    final projects = await repository.getAll(userId: 'user_1');

    expect(projects, hasLength(1));
    expect(projects.single.id, 'project_1');
  });

  test('create, update, delete call expected project endpoints', () async {
    final project = _project('project_2');

    adapter.onPost(
      '/projects',
      data: project.toJson(),
      (server) => server.reply(200, {'data': project.toJson()}),
    );
    adapter.onPatch(
      '/projects/project_2',
      data: project.copyWith(title: 'Updated').toJson(),
      (server) => server.reply(
        200,
        {'data': project.copyWith(title: 'Updated').toJson()},
      ),
    );
    adapter.onDelete(
      '/projects/project_2',
      (server) => server.reply(204, null),
    );

    expect((await repository.create(project)).id, 'project_2');
    expect(
      (await repository.update(project.copyWith(title: 'Updated'))).title,
      'Updated',
    );
    await repository.delete('project_2');
  });

  test('getById returns null on 404 and maps 500 to ServerException', () async {
    adapter.onGet(
      '/projects/missing',
      (server) => server.reply(404, {'message': 'missing'}),
    );
    adapter.onGet(
      '/projects/broken',
      (server) => server.reply(500, {'message': 'broken'}),
    );

    expect(await repository.getById('missing'), isNull);
    await expectLater(
      repository.getById('broken'),
      throwsA(isA<ServerException>()),
    );
  });
}

Project _project(String id) {
  return Project(
    id: id,
    userId: 'user_1',
    title: 'Launch Clip',
    createdAt: DateTime.utc(2026, 6),
    updatedAt: DateTime.utc(2026, 6),
  );
}

Map<String, Object?> _projectJson(String id) => _project(id).toJson();
