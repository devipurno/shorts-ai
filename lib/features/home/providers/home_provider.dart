import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../shared/models/project.dart';
import '../../../shared/models/template.dart';
import '../../../shared/repositories/analytics_repository.dart';
import '../../../shared/repositories/providers.dart';
import '../../auth/providers/current_user_provider.dart';

const _fallbackUserId = 'user_1';

const homeTips = [
  'Buka video dengan konflik atau hasil akhir dalam 3 detik pertama.',
  'Pakai caption besar untuk kalimat yang paling emosional.',
  'Potong jeda napas panjang supaya retention tetap rapat.',
  'Mulai dari payoff, lalu mundur ke konteks.',
  'Gunakan satu CTA saja agar penonton tidak bingung.',
  'Thumbnail terbaik biasanya punya wajah jelas dan kontras tinggi.',
  'Durasi 25-45 detik sering paling aman untuk edukasi cepat.',
  'Simpan template brand supaya produksi harian terasa konsisten.',
  'Hook pertanyaan bekerja baik untuk niche edukasi dan finance.',
  'Review analytics kemarin sebelum membuat batch baru hari ini.',
];

final homeDataProvider = FutureProvider<HomeData>((ref) async {
  final user = ref.watch(currentUserProvider);
  final userId = user?.id ?? _fallbackUserId;
  final projectRepository = ref.watch(projectRepositoryProvider);
  final templateRepository = ref.watch(templateRepositoryProvider);
  final analyticsRepository = ref.watch(analyticsRepositoryProvider);

  final results = await Future.wait([
    projectRepository.getAll(userId: userId),
    templateRepository.getAll(),
    analyticsRepository.getUserStats(userId),
  ]);

  final projects = (results[0] as List<Project>).toList()
    ..sort((a, b) => b.updatedAt.compareTo(a.updatedAt));
  final templates = (results[1] as List<Template>).toList()
    ..sort((a, b) => b.timesUsed.compareTo(a.timesUsed));
  final stats = results[2] as UserAnalyticsStats;
  final now = DateTime.now();

  return HomeData(
    recentProjects: projects.take(5).toList(growable: false),
    spotlightTemplates: templates.take(5).toList(growable: false),
    streakCount: _deriveStreak(stats),
    tipOfTheDay: homeTips[now.day % homeTips.length],
    hasUnreadNotifications: stats.totalEvents > 0,
  );
});

class HomeData {
  const HomeData({
    required this.recentProjects,
    required this.spotlightTemplates,
    required this.streakCount,
    required this.tipOfTheDay,
    required this.hasUnreadNotifications,
  });

  final List<Project> recentProjects;
  final List<Template> spotlightTemplates;
  final int streakCount;
  final String tipOfTheDay;
  final bool hasUnreadNotifications;
}

int _deriveStreak(UserAnalyticsStats stats) {
  final activityScore =
      stats.projectCreatedCount + stats.generationStartedCount;
  if (activityScore <= 0) {
    return 1;
  }
  return activityScore.clamp(1, 30);
}
