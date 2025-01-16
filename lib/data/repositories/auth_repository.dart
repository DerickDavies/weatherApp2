import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:weather_app/data/repositories/auth_repository_remote.dart';

part 'auth_repository.g.dart';

abstract class AuthRepository {
  Future<UserCredential> createUser({
    required String email,
    required String password,
  });

  Future<UserCredential> loginUser({
    required String email,
    required String password,
  });

  bool checkAuth();
  Future<UserCredential> signInWithGoogle();
  Future<void> signOut();
  User? currentAuth();
}

@Riverpod(keepAlive: true)
AuthRepository authRepository(Ref ref) {
  return AuthRepositoryRemote();
}
