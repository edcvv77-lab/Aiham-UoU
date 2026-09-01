abstract class AuthRepository {
  Stream<String?> authState();
  Future<String?> signIn(String email, String password);
  Future<String?> register(String email, String password);
  Future<void> signOut();
}
