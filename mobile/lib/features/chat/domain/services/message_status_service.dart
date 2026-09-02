import 'package:cloud_firestore/cloud_firestore.dart';

class MessageStatusService {
  MessageStatusService(this._firestore);

  final FirebaseFirestore _firestore;

  Future<void> updateStatus({
    required String conversationId,
    required String messageId,
    required String status,
  }) {
    return _firestore
        .collection('conversations')
        .doc(conversationId)
        .collection('messages')
        .doc(messageId)
        .set({'status': status}, SetOptions(merge: true));
  }

  Future<void> markAsRead({
    required String conversationId,
    required String messageId,
  }) {
    return updateStatus(
      conversationId: conversationId,
      messageId: messageId,
      status: 'read',
    );
  }
}
