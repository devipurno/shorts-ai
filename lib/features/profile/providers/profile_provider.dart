import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';

import '../../../shared/models/user.dart' as shared_user;
import '../../../shared/repositories/providers.dart';
import '../../auth/providers/current_user_provider.dart';

final profileStatsProvider = FutureProvider<ProfileStats>((ref) async {
  final user = ref.watch(currentUserProvider);
  if (user == null) {
    return const ProfileStats.empty();
  }

  final projectRepository = ref.watch(projectRepositoryProvider);
  final analyticsRepository = ref.watch(analyticsRepositoryProvider);

  final projects = await projectRepository.getAll(userId: user.id);
  final analytics = await analyticsRepository.getUserStats(user.id);

  final totalViews = analytics.totalEvents * 125;
  final followersGained = analytics.generationStartedCount * 18;

  return ProfileStats(
    videosCreated: projects.length,
    totalViews: totalViews,
    followersGained: followersGained,
  );
});

final profileSubscriptionProvider = FutureProvider((ref) async {
  final user = ref.watch(currentUserProvider);
  if (user == null) {
    return null;
  }

  return ref.watch(subscriptionRepositoryProvider).getByUserId(user.id);
});

final editProfileProvider =
    StateNotifierProvider<EditProfileNotifier, EditProfileState>((ref) {
  return EditProfileNotifier();
});

class ProfileStats {
  const ProfileStats({
    required this.videosCreated,
    required this.totalViews,
    required this.followersGained,
  });

  const ProfileStats.empty()
      : videosCreated = 0,
        totalViews = 0,
        followersGained = 0;

  final int videosCreated;
  final int totalViews;
  final int followersGained;
}

class EditProfileNotifier extends StateNotifier<EditProfileState> {
  EditProfileNotifier() : super(const EditProfileState());

  void setName(String value) {
    state = state.copyWith(name: value);
  }

  void setBio(String value) {
    state = state.copyWith(bio: value);
  }

  void setInstagramHandle(String value) {
    state = state.copyWith(instagramHandle: value);
  }

  void setYoutubeHandle(String value) {
    state = state.copyWith(youtubeHandle: value);
  }

  void setTiktokHandle(String value) {
    state = state.copyWith(tiktokHandle: value);
  }

  void setAvatarPath(String? value) {
    state = state.copyWith(avatarPath: value);
  }

  void hydrate({
    required String name,
    String bio = '',
    String instagramHandle = '',
    String youtubeHandle = '',
    String tiktokHandle = '',
    String? avatarPath,
  }) {
    state = EditProfileState(
      name: name,
      bio: bio,
      instagramHandle: instagramHandle,
      youtubeHandle: youtubeHandle,
      tiktokHandle: tiktokHandle,
      avatarPath: avatarPath,
    );
  }
}

class EditProfileState {
  const EditProfileState({
    this.name = '',
    this.bio = '',
    this.instagramHandle = '',
    this.youtubeHandle = '',
    this.tiktokHandle = '',
    this.avatarPath,
  });

  final String name;
  final String bio;
  final String instagramHandle;
  final String youtubeHandle;
  final String tiktokHandle;
  final String? avatarPath;

  bool get isValid => name.trim().isNotEmpty;

  EditProfileState copyWith({
    String? name,
    String? bio,
    String? instagramHandle,
    String? youtubeHandle,
    String? tiktokHandle,
    Object? avatarPath = _sentinel,
  }) {
    return EditProfileState(
      name: name ?? this.name,
      bio: bio ?? this.bio,
      instagramHandle: instagramHandle ?? this.instagramHandle,
      youtubeHandle: youtubeHandle ?? this.youtubeHandle,
      tiktokHandle: tiktokHandle ?? this.tiktokHandle,
      avatarPath: identical(avatarPath, _sentinel)
          ? this.avatarPath
          : avatarPath as String?,
    );
  }

  shared_user.User toSharedUser({
    required String id,
    required String email,
    required shared_user.SubscriptionTier tier,
  }) {
    final now = DateTime.now().toUtc();
    return shared_user.User(
      id: id,
      email: email,
      name: name.trim(),
      avatarUrl: avatarPath,
      tier: tier,
      createdAt: now,
      updatedAt: now,
      lastLoginAt: now,
    );
  }
}

const _sentinel = Object();
