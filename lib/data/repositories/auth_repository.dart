import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:weather_app/data/repositories/auth_repository_remote.dart';
import 'package:weather_app/domain/models/app_user_model.dart';

part 'auth_repository.g.dart';

abstract class AuthRepository {
  Future<AppUserModel> createUser({
    required String email,
    required String password,
  });

  Future<AppUserModel> loginUser({
    required String email,
    required String password,
  });

  bool checkAuth();
  Future<AppUserModel> signInWithGoogle();
  Future<void> signOut();
  User? currentAuth();
}

@Riverpod(keepAlive: true)
AuthRepository authRepository(Ref ref) {
  return AuthRepositoryRemote();
}
