import 'package:cloud_firestore/cloud_firestore.dart';

class ConversationService {
  ConversationService({FirebaseFirestore? firestore})
      : _firestore = firestore ?? FirebaseFirestore.instance;

  final FirebaseFirestore _firestore;

  Future<String> createConversation({
    required String currentUserId,
    required String otherUserId,
  }) async {
    final query = await _firestore
        .collection('conversations')
        .where('participants', arrayContains: currentUserId)
        .get();

    for (final doc in query.docs) {
      final users = List<String>.from(doc.data()['participants'] ?? []);
      if (users.contains(otherUserId)) return doc.id;
    }

    final ref = await _firestore.collection('conversations').add({
      'participants': [currentUserId, otherUserId],
      'lastMessage': '',
      'createdAt': FieldValue.serverTimestamp(),
      'updatedAt': FieldValue.serverTimestamp(),
    });

    return ref.id;
  }
}
