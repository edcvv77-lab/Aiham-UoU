class UserModel {
  final String id;
  final String username;
  final String email;
  final String role;

  const UserModel({
    required this.id,
    required this.username,
    required this.email,
    this.role = 'USER',
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'username': username,
      'email': email,
      'role': role,
    };
  }
}
