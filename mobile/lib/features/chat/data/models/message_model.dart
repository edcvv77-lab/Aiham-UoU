import 'package:cloud_firestore/cloud_firestore.dart';

enum MessageStatus {
  sending,
  sent,
  delivered,
  read,
}

class MessageModel {
  final String id;
  final String conversationId;
  final String senderId;
  final String receiverId;
  final String text;
  final DateTime createdAt;
  final DateTime expireAt;
  final MessageStatus status;

  const MessageModel({
    required this.id,
    required this.conversationId,
    required this.senderId,
    required this.receiverId,
    required this.text,
    required this.createdAt,
    required this.expireAt,
    this.status = MessageStatus.sent,
  });

  bool get isExpired => !expireAt.isAfter(DateTime.now().toUtc());

  Map<String, Object?> toMap() {
    return {
      'conversationId': conversationId,
      'senderId': senderId,
      'receiverId': receiverId,
      'text': text,
      'status': status.name,
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
      status: _readStatus(data['status']),
      createdAt: _readDate(data['createdAt']),
      expireAt: _readDate(data['expireAt']),
    );
  }

  static MessageStatus _readStatus(dynamic value) {
    return MessageStatus.values.firstWhere(
      (item) => item.name == value,
      orElse: () => MessageStatus.sent,
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
