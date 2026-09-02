import 'package:cloud_firestore/cloud_firestore.dart';

class UserSearchService {
  final FirebaseFirestore _firestore;

  UserSearchService({FirebaseFirestore? firestore})
      : _firestore = firestore ?? FirebaseFirestore.instance;

  Stream<List<Map<String, dynamic>>> searchByName(String query) {
    if (query.trim().isEmpty) {
      return Stream.value(const []);
    }

    return _firestore
        .collection('users')
        .orderBy('displayName')
        .startAt([query])
        .endAt(['$query\uf8ff'])
        .limit(20)
        .snapshots()
        .map((snapshot) => snapshot.docs.map((doc) {
              return {
                'id': doc.id,
                ...doc.data(),
              };
            }).toList());
  }
}
