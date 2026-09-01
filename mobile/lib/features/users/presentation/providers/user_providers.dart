import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/user_profile_repository.dart';
import '../../data/user_profile_model.dart';

final userProfileRepositoryProvider = Provider<UserProfileRepository>((ref) {
  return UserProfileRepository();
});

final userProfileProvider = StreamProvider.family<UserProfileModel?, String>(
  (ref, userId) {
    return ref.watch(userProfileRepositoryProvider).watchProfile(userId);
  },
);
