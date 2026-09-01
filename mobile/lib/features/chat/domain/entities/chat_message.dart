class ChatMessage {
  final String id;
  final String senderId;
  final String receiverId;
  final String text;
  final DateTime createdAt;
  final DateTime expireAt;

  const ChatMessage({
    required this.id,
    required this.senderId,
    required this.receiverId,
    required this.text,
    required this.createdAt,
    required this.expireAt,
  });

  bool get isExpired => DateTime.now().isAfter(expireAt);
}
