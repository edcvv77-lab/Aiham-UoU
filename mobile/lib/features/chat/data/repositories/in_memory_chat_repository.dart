import 'dart:async';

import '../models/message_model.dart';
import 'chat_repository.dart';

class InMemoryChatRepository implements ChatRepository {
  final Map<String, List<MessageModel>> _messagesByConversation = {};
  final Map<String, StreamController<List<MessageModel>>> _controllers = {};

  StreamController<List<MessageModel>> _controller(String conversationId) {
    return _controllers.putIfAbsent(
      conversationId,
      () => StreamController<List<MessageModel>>.broadcast(),
    );
  }

  List<MessageModel> _activeMessages(String conversationId) {
    final now = DateTime.now().toUtc();
    final messages = _messagesByConversation[conversationId] ?? const [];

    return messages
        .where((message) => message.expireAt.isAfter(now))
        .toList(growable: false)
      ..sort((a, b) => a.createdAt.compareTo(b.createdAt));
  }

  void _emit(String conversationId) {
    _controller(conversationId).add(_activeMessages(conversationId));
  }

  @override
  Stream<List<MessageModel>> watchMessages(String conversationId) async* {
    yield _activeMessages(conversationId);
    yield* _controller(conversationId).stream;
  }

  @override
  Future<void> sendMessage(MessageModel message) async {
    final messages =
        _messagesByConversation.putIfAbsent(message.conversationId, () => []);
    messages.add(message);
    _emit(message.conversationId);
  }

  @override
  Future<void> markMessagesAsRead({
    required String conversationId,
    required String userId,
  }) async {
    final messages = _messagesByConversation[conversationId];
    if (messages == null) return;
    _messagesByConversation[conversationId] = messages.map((message) {
      if (message.receiverId == userId) {
        return MessageModel(
          id: message.id,
          conversationId: message.conversationId,
          senderId: message.senderId,
          receiverId: message.receiverId,
          text: message.text,
          createdAt: message.createdAt,
          expireAt: message.expireAt,
          status: MessageStatus.read,
        );
      }
      return message;
    }).toList();
    _emit(conversationId);
  }

  @override
  Future<void> markMessageAsDelivered({
    required String conversationId,
    required String messageId,
  }) async {}

  @override
  Future<void> deleteExpiredMessages() async {
    for (final conversationId in _messagesByConversation.keys.toList()) {
      _messagesByConversation[conversationId] = _activeMessages(conversationId);
      _emit(conversationId);
    }
  }

  Future<void> dispose() async {
    for (final controller in _controllers.values) {
      await controller.close();
    }
  }
}
