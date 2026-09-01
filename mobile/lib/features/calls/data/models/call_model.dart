class CallModel {
  final String id;
  final String callerId;
  final String receiverId;
  final String type;
  final String status;
  final DateTime createdAt;

  const CallModel({
    required this.id,
    required this.callerId,
    required this.receiverId,
    required this.type,
    required this.status,
    required this.createdAt,
  });
}
