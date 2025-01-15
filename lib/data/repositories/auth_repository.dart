abstract class AuthRepository {
  Future<void> createUser({
    required String email,
    required String password,
  });

  Future<void> loginUser({
    required String email,
    required String password,
  });

  bool checkAuth();
  Future<void> signInWithGoogle();
  Future<void> signOut();
}
