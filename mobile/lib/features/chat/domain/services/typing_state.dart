class TypingState {
  final String userId;
  final bool isTyping;
  final DateTime updatedAt;

  const TypingState({
    required this.userId,
    required this.isTyping,
    required this.updatedAt,
  });
}
