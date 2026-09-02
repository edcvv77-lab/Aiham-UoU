class ConversationModel {
  final String id;
  final List<String> participants;
  final String lastMessage;
  final DateTime? updatedAt;

  const ConversationModel({
    required this.id,
    required this.participants,
    required this.lastMessage,
    this.updatedAt,
  });

  factory ConversationModel.fromMap(String id, Map<String, dynamic> map) {
    return ConversationModel(
      id: id,
      participants: List<String>.from(map['participants'] ?? const []),
      lastMessage: map['lastMessage'] ?? '',
      updatedAt: map['updatedAt'] is DateTime ? map['updatedAt'] : null,
    );
  }

  Map<String, dynamic> toMap() => {
        'participants': participants,
        'lastMessage': lastMessage,
        'updatedAt': updatedAt,
      };
}
