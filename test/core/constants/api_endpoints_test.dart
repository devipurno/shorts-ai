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

  group('auth endpoints', () {
    test('returns correct paths', () {
      expect(ApiEndpoints.authSession, '/auth/session');
      expect(ApiEndpoints.authLogin, '/auth/login');
      expect(ApiEndpoints.authSignup, '/auth/signup');
      expect(ApiEndpoints.authLogout, '/auth/logout');
      expect(ApiEndpoints.authRefresh, '/auth/refresh');
      expect(ApiEndpoints.authForgotPassword, '/auth/forgot-password');
    });
  });

  group('project endpoints', () {
    test('projectGenerate builds correct path', () {
      expect(
        ApiEndpoints.projectGenerate('p-1'),
        '/projects/p-1/generate',
      );
    });
  });

  group('upload endpoints', () {
    test('returns correct paths', () {
      expect(ApiEndpoints.uploads, '/uploads');
      expect(ApiEndpoints.upload('u-1'), '/uploads/u-1');
    });
  });

  group('processing endpoints', () {
    test('returns correct paths', () {
      expect(ApiEndpoints.processingBatches, '/processing-batches');
      expect(
        ApiEndpoints.processingBatch('b-1'),
        '/processing-batches/b-1',
      );
      expect(ApiEndpoints.processingJobs, '/processing-jobs');
      expect(
        ApiEndpoints.processingJob('j-1'),
        '/processing-jobs/j-1',
      );
      expect(
        ApiEndpoints.retryProcessingJob('j-1'),
        '/processing-jobs/j-1/retry',
      );
    });
  });

  group('generated shorts endpoints', () {
    test('returns correct paths', () {
      expect(ApiEndpoints.generatedShorts, '/generated-shorts');
      expect(
        ApiEndpoints.generatedShort('s-1'),
        '/generated-shorts/s-1',
      );
      expect(
        ApiEndpoints.rejectThumbnail('s-1', 't-1'),
        '/generated-shorts/s-1/thumbnails/t-1/reject',
      );
    });
  });

  group('misc endpoints', () {
    test('returns correct paths', () {
      expect(ApiEndpoints.uploadQueue, '/upload-queue');
      expect(
        ApiEndpoints.uploadQueueItem('q-1'),
        '/upload-queue/q-1',
      );
      expect(ApiEndpoints.analyticsOverview, '/analytics/overview');
      expect(ApiEndpoints.brandKits, '/brand-kits');
      expect(ApiEndpoints.calendarPosts, '/calendar/posts');
      expect(ApiEndpoints.billingPlans, '/billing/plans');
    });
  });
}
