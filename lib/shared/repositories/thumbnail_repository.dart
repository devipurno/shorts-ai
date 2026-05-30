import '../models/thumbnail.dart';

abstract class ThumbnailRepository {
  Future<List<Thumbnail>> getAll({String? projectId});

  Future<Thumbnail?> getById(String id);

  Future<Thumbnail> create(Thumbnail thumbnail);

  Future<Thumbnail> update(Thumbnail thumbnail);

  Future<void> delete(String id);

  Stream<List<Thumbnail>> watch({String? projectId});
}
