import 'package:dio/dio.dart';

import '../../models/template.dart';
import '../template_repository.dart';
import 'api_repository_helpers.dart';

class ApiTemplateRepository implements TemplateRepository {
  ApiTemplateRepository({Dio? dio})
      : _client = ApiResourceClient<Template>(
          path: '/templates',
          fromJson: Template.fromJson,
          toJson: (template) => template.toJson(),
          idOf: (template) => template.id,
          dio: dio,
        );

  final ApiResourceClient<Template> _client;

  @override
  Future<List<Template>> getAll() => _client.getAll();

  @override
  Future<Template?> getById(String id) => _client.getById(id);

  @override
  Future<List<Template>> getByCategory(String category) {
    return _client.getAll(query: {'category': category});
  }

  @override
  Stream<List<Template>> watchAll() async* {
    yield await getAll();
  }
}
