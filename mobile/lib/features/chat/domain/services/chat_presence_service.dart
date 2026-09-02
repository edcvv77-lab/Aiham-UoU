class ChatPresenceService {
  ChatPresenceService._();

  static Map<String, dynamic> onlineState({
    required String userId,
    required bool online,
  }) {
    return {
      'userId': userId,
      'online': online,
      'updatedAt': DateTime.now().toUtc(),
    };
  }

  static Map<String, dynamic> typingState({
    required String conversationId,
    required String userId,
    required bool typing,
  }) {
    return {
      'conversationId': conversationId,
      'userId': userId,
      'typing': typing,
      'updatedAt': DateTime.now().toUtc(),
    };
  }
}
