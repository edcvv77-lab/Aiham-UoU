class AppUserModel {
  const AppUserModel({
    required this.uid,
    required this.username,
    required this.createdAt,
    this.photoUrl,
    this.online = false,
  });

  final String uid;
  final String username;
  final String? photoUrl;
  final bool online;
  final DateTime createdAt;

  factory AppUserModel.fromMap(String id, Map<String, dynamic> map) {
    return AppUserModel(
      uid: id,
      username: map['username'] as String? ?? '',
      photoUrl: map['photoUrl'] as String?,
      online: map['online'] as bool? ?? false,
      createdAt: DateTime.tryParse(map['createdAt']?.toString() ?? '') ?? DateTime.now(),
    );
  }

  Map<String, dynamic> toMap() => {
        'username': username,
        'photoUrl': photoUrl,
        'online': online,
        'createdAt': createdAt.toUtc().toIso8601String(),
      };
}
