import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/message_model.dart';
import 'chat_repository.dart';

class FirestoreChatRepository implements ChatRepository {
  FirestoreChatRepository({FirebaseFirestore? firestore})
      : _firestore = firestore ?? FirebaseFirestore.instance;

  final FirebaseFirestore _firestore;

  CollectionReference<Map<String, dynamic>> _messages(
    String conversationId,
  ) {
    return _firestore
        .collection('conversations')
        .doc(conversationId)
        .collection('messages');
  }

  @override
  Stream<List<MessageModel>> watchMessages(String conversationId) {
    return _messages(conversationId)
        .orderBy('createdAt')
        .snapshots()
        .map(
          (snapshot) => snapshot.docs
              .map((doc) => MessageModel.fromMap(doc.id, doc.data()))
              .where((message) => !message.isExpired)
              .toList(growable: false),
        );
  }

  @override
  Future<void> sendMessage(MessageModel message) async {
    final conversationRef =
        _firestore.collection('conversations').doc(message.conversationId);
    final messageRef = _messages(message.conversationId).doc(message.id);

    final batch = _firestore.batch();
    batch.set(
      conversationRef,
      {
        'participants': [message.senderId, message.receiverId],
        'updatedAt': Timestamp.fromDate(message.createdAt.toUtc()),
      },
      SetOptions(merge: true),
    );
    batch.set(messageRef, message.toMap());
    await batch.commit();
  }

  @override
  Future<void> markMessagesAsRead({
    required String conversationId,
    required String userId,
  }) async {
    final snapshot = await _messages(conversationId)
        .where('receiverId', isEqualTo: userId)
        .where('status', isNotEqualTo: MessageStatus.read.name)
        .get();

    final batch = _firestore.batch();
    for (final doc in snapshot.docs) {
      batch.update(doc.reference, {'status': MessageStatus.read.name});
    }
    await batch.commit();
  }

  @override
  Future<void> markMessageAsDelivered({
    required String conversationId,
    required String messageId,
  }) async {
    await _messages(conversationId).doc(messageId).update({
      'status': MessageStatus.delivered.name,
    });
  }

  @override
  Future<void> deleteExpiredMessages() async {
    final expired = await _firestore
        .collectionGroup('messages')
        .where(
          'expireAt',
          isLessThanOrEqualTo: Timestamp.fromDate(DateTime.now().toUtc()),
        )
        .limit(100)
        .get();

    if (expired.docs.isEmpty) return;

    final batch = _firestore.batch();
    for (final doc in expired.docs) {
      batch.delete(doc.reference);
    }
    await batch.commit();
  }
}
