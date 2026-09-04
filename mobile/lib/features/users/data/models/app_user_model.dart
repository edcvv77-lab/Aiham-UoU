class AppUserModel {
  final String id;
  final String email;
  final String displayName;

  const AppUserModel({
    required this.id,
    required this.email,
    required this.displayName,
  });

  factory AppUserModel.fromMap(Map<String, dynamic> map) {
    return AppUserModel(
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
