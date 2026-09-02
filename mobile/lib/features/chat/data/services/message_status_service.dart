import 'package:cloud_firestore/cloud_firestore.dart';

class MessageStatusService {
  final FirebaseFirestore _firestore;

  MessageStatusService({FirebaseFirestore? firestore})
      : _firestore = firestore ?? FirebaseFirestore.instance;

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
        .update({'status': status});
  }

  Future<void> markAsRead({
    required String conversationId,
  }) async {
    final messages = await _firestore
        .collection('conversations')
        .doc(conversationId)
        .collection('messages')
        .where('status', isEqualTo: 'delivered')
        .get();

    final batch = _firestore.batch();
    for (final doc in messages.docs) {
      batch.update(doc.reference, {'status': 'read'});
    }
    await batch.commit();
  }
}
