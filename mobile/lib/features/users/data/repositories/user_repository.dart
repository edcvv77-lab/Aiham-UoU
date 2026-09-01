import '../models/app_user_model.dart';

abstract class UserRepository {
  Future<void> saveProfile(AppUserModel user);
  Stream<List<AppUserModel>> searchUsers(String query);
  Stream<AppUserModel?> watchUser(String uid);
}
