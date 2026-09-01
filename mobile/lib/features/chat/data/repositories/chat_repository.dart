import '../models/message_model.dart';

abstract class ChatRepository {
  Stream<List<MessageModel>> watchMessages(String conversationId);

  Future<void> sendMessage(MessageModel message);

  Future<void> deleteExpiredMessages();
}
