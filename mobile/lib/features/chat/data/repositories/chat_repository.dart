import '../models/message_model.dart';

abstract class ChatRepository {
  Stream<List<MessageModel>> watchMessages(String conversationId);

  Future<void> sendMessage(MessageModel message);

  Future<void> markMessagesAsRead({
    required String conversationId,
    required String userId,
  });

  Future<void> markMessageAsDelivered({
    required String conversationId,
    required String messageId,
  });

  Future<void> deleteExpiredMessages();
}
