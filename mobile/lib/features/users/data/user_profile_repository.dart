import 'package:cloud_firestore/cloud_firestore.dart';

import 'user_profile_model.dart';

class UserProfileRepository {
  final FirebaseFirestore _firestore;

  UserProfileRepository({FirebaseFirestore? firestore})
      : _firestore = firestore ?? FirebaseFirestore.instance;

  Future<void> createProfile(UserProfileModel profile) {
    return _firestore
        .collection('users')
        .doc(profile.id)
        .set(profile.toMap());
  }

  Future<UserProfileModel?> getProfile(String id) async {
    final snapshot = await _firestore.collection('users').doc(id).get();
    if (!snapshot.exists || snapshot.data() == null) return null;
    return UserProfileModel.fromMap(snapshot.data()!);
  }

  Stream<UserProfileModel?> watchProfile(String id) {
    return _firestore.collection('users').doc(id).snapshots().map((snapshot) {
      if (!snapshot.exists || snapshot.data() == null) return null;
      return UserProfileModel.fromMap(snapshot.data()!);
    });
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> searchUsers(String query) {
    return _firestore
        .collection('users')
        .where('username', isGreaterThanOrEqualTo: query)
        .where('username', isLessThan: '$query\uf8ff')
        .snapshots();
  }
}
