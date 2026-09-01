class UserProfileModel {
  final String id;
  final String email;
  final String displayName;

  const UserProfileModel({
    required this.id,
    required this.email,
    required this.displayName,
  });

  factory UserProfileModel.fromMap(Map<String, dynamic> map) {
    return UserProfileModel(
      id: map['id'] ?? '',
      email: map['email'] ?? '',
      displayName: map['displayName'] ?? '',
    );
  }

  Map<String, dynamic> toMap() => {
    'id': id,
    'email': email,
    'displayName': displayName,
  };
}
