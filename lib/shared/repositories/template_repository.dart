import '../models/template.dart';

abstract class TemplateRepository {
  Future<List<Template>> getAll();

  Future<Template?> getById(String id);

  Future<List<Template>> getByCategory(String category);

  Stream<List<Template>> watchAll();
}
