import 'package:cloud_firestore/cloud_firestore.dart';

class MessageModel {
  final String id;
  final String conversationId;
  final String senderId;
  final String receiverId;
  final String text;
  final DateTime createdAt;
  final DateTime expireAt;

  const MessageModel({
    required this.id,
    required this.conversationId,
    required this.senderId,
    required this.receiverId,
    required this.text,
    required this.createdAt,
    required this.expireAt,
  });

  bool get isExpired => !expireAt.isAfter(DateTime.now().toUtc());

  Map<String, Object?> toMap() {
    return {
      'conversationId': conversationId,
      'senderId': senderId,
      'receiverId': receiverId,
      'text': text,
      'createdAt': Timestamp.fromDate(createdAt.toUtc()),
      'expireAt': Timestamp.fromDate(expireAt.toUtc()),
    };
  }

  factory MessageModel.fromMap(
    String id,
    Map<String, dynamic> data,
  ) {
    return MessageModel(
      id: id,
      conversationId: data['conversationId'] as String? ?? '',
      senderId: data['senderId'] as String? ?? '',
      receiverId: data['receiverId'] as String? ?? '',
      text: data['text'] as String? ?? '',
      createdAt: _readDate(data['createdAt']),
      expireAt: _readDate(data['expireAt']),
    );
  }

  static DateTime _readDate(dynamic value) {
    if (value is Timestamp) return value.toDate().toUtc();
    if (value is DateTime) return value.toUtc();
    if (value is int) {
      return DateTime.fromMillisecondsSinceEpoch(value, isUtc: true);
    }
    return DateTime.fromMillisecondsSinceEpoch(0, isUtc: true);
  }
}
