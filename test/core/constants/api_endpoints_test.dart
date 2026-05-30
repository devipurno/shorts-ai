import 'package:flutter_test/flutter_test.dart';
import 'package:shorts_ai/core/constants/api_endpoints.dart';

void main() {
  test('exposes static and dynamic API endpoint paths', () {
    expect(ApiEndpoints.health, '/health');
    expect(ApiEndpoints.projects, '/projects');
    expect(ApiEndpoints.project('project-1'), '/projects/project-1');
    expect(
      ApiEndpoints.projectSources('project-1'),
      '/projects/project-1/sources',
    );
    expect(
      ApiEndpoints.processingJobEvents('job-1'),
      '/processing-jobs/job-1/events',
    );
    expect(
      ApiEndpoints.selectThumbnail('short-1', 'thumb-1'),
      '/generated-shorts/short-1/thumbnails/thumb-1/select',
    );
  });
}
