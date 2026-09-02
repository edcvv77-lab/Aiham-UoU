import 'package:cloud_firestore/cloud_firestore.dart';

class TypingService {
  TypingService(this._firestore);

  final FirebaseFirestore _firestore;

  DocumentReference<Map<String, dynamic>> _typingRef(String conversationId) {
    return _firestore.collection('conversations').doc(conversationId);
  }

  Future<void> setTyping({
    required String conversationId,
    required String userId,
    required bool value,
  }) {
    return _typingRef(conversationId).set({
      'typing': {userId: value},
      'updatedAt': FieldValue.serverTimestamp(),
    }, SetOptions(merge: true));
  }

  Stream<Map<String, dynamic>> watchTyping(String conversationId) {
    return _typingRef(conversationId)
        .snapshots()
        .map((snapshot) => snapshot.data()?['typing'] as Map<String, dynamic>? ?? {});
  }
}
