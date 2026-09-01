import 'package:firebase_auth/firebase_auth.dart';

import 'auth_service.dart';

class AuthRepository {
  final AuthService _service;

  AuthRepository({AuthService? service})
      : _service = service ?? AuthService();

  Stream<User?> watchUser() => _service.authStateChanges;

  Future<UserCredential> createAccount({
    required String email,
    required String password,
  }) {
    return _service.register(email: email, password: password);
  }

  Future<UserCredential> signIn({
    required String email,
    required String password,
  }) {
    return _service.login(email: email, password: password);
  }

  Future<void> signOut() => _service.logout();
}
