class ApiEndpoints {
  ApiEndpoints._();

  static const String health = '/health';

  static const String authSession = '/auth/session';
  static const String authLogin = '/auth/login';
  static const String authSignup = '/auth/signup';
  static const String authLogout = '/auth/logout';
  static const String authRefresh = '/auth/refresh';
  static const String authForgotPassword = '/auth/forgot-password';

  static const String projects = '/projects';
  static String project(String projectId) => '/projects/$projectId';
  static String projectSources(String projectId) =>
      '/projects/$projectId/sources';
  static String projectGenerate(String projectId) =>
      '/projects/$projectId/generate';

  static const String uploads = '/uploads';
  static String upload(String uploadId) => '/uploads/$uploadId';

  static const String processingBatches = '/processing-batches';
  static String processingBatch(String batchId) =>
      '/processing-batches/$batchId';

  static const String processingJobs = '/processing-jobs';
  static String processingJob(String jobId) => '/processing-jobs/$jobId';
  static String processingJobEvents(String jobId) =>
      '/processing-jobs/$jobId/events';
  static String retryProcessingJob(String jobId) =>
      '/processing-jobs/$jobId/retry';

  static const String generatedShorts = '/generated-shorts';
  static String generatedShort(String shortId) => '/generated-shorts/$shortId';
  static String selectThumbnail(String shortId, String thumbnailId) =>
      '/generated-shorts/$shortId/thumbnails/$thumbnailId/select';
  static String rejectThumbnail(String shortId, String thumbnailId) =>
      '/generated-shorts/$shortId/thumbnails/$thumbnailId/reject';

  static const String uploadQueue = '/upload-queue';
  static String uploadQueueItem(String queueId) => '/upload-queue/$queueId';

  static const String analyticsOverview = '/analytics/overview';
  static const String brandKits = '/brand-kits';
  static const String calendarPosts = '/calendar/posts';
  static const String billingPlans = '/billing/plans';
}
