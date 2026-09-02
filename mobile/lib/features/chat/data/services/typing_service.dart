import 'package:cloud_firestore/cloud_firestore.dart';

class TypingService {
  final FirebaseFirestore _firestore;

  TypingService({FirebaseFirestore? firestore})
      : _firestore = firestore ?? FirebaseFirestore.instance;

  Future<void> setTyping({
    required String conversationId,
    required bool value,
  }) {
    return _firestore
        .collection('conversations')
        .doc(conversationId)
        .update({'isTyping': value});
  }

  Stream<bool> watchTyping(String conversationId) {
    return _firestore
        .collection('conversations')
        .doc(conversationId)
        .snapshots()
        .map((snapshot) => snapshot.data()?['isTyping'] as bool? ?? false);
  }
}
