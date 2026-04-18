abstract class AuthRepository {
  Future<bool> signUp(String name, String email, String password);
  Future<bool> signIn(String email, String password);
  Future<void> logout();
}
