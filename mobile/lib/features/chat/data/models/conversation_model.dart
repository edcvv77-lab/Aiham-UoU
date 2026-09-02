import 'package:cloud_firestore/cloud_firestore.dart';

class ConversationModel {
  final String id;
  final List<String> participants;
  final String lastMessage;
  final int unreadCount;
  final bool isTyping;
  final DateTime? updatedAt;

  const ConversationModel({
    required this.id,
    required this.participants,
    required this.lastMessage,
    this.unreadCount = 0,
    this.isTyping = false,
    this.updatedAt,
  });

  factory ConversationModel.fromMap(String id, Map<String, dynamic> map) {
    return ConversationModel(
      id: id,
      participants: List<String>.from(map['participants'] ?? const []),
      lastMessage: map['lastMessage'] as String? ?? '',
      unreadCount: map['unreadCount'] as int? ?? 0,
      isTyping: map['isTyping'] as bool? ?? false,
      updatedAt: _readDate(map['updatedAt']),
    );
  }

  Map<String, dynamic> toMap() => {
        'participants': participants,
        'lastMessage': lastMessage,
        'unreadCount': unreadCount,
        'isTyping': isTyping,
        'updatedAt': updatedAt == null
            ? null
            : Timestamp.fromDate(updatedAt!.toUtc()),
      };

  static DateTime? _readDate(dynamic value) {
    if (value is Timestamp) return value.toDate().toUtc();
    if (value is DateTime) return value.toUtc();
    return null;
  }
}
