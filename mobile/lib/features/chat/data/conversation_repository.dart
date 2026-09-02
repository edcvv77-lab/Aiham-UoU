import 'package:cloud_firestore/cloud_firestore.dart';

import 'models/conversation_model.dart';

class ConversationRepository {
  ConversationRepository(this._firestore);

  final FirebaseFirestore _firestore;

  Stream<List<ConversationModel>> watchUserConversations(String userId) {
    return _firestore
        .collection('conversations')
        .where('participants', arrayContains: userId)
        .orderBy('updatedAt', descending: true)
        .snapshots()
        .map(
          (snapshot) => snapshot.docs
              .map((doc) => ConversationModel.fromMap(doc.id, doc.data()))
              .toList(),
        );
  }
}
