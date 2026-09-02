import 'message_status.dart';

class ChatMessage {
  final String id;
  final String senderId;
  final String receiverId;
  final String text;
  final DateTime createdAt;
  final DateTime expireAt;
  final MessageStatus status;

  const ChatMessage({
    required this.id,
    required this.senderId,
    required this.receiverId,
    required this.text,
    required this.createdAt,
    required this.expireAt,
    this.status = MessageStatus.sent,
  });

  bool get isExpired => DateTime.now().isAfter(expireAt);
}
