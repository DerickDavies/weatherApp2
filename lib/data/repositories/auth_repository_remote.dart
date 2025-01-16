import 'package:firebase_auth/firebase_auth.dart';

import 'package:google_sign_in/google_sign_in.dart';
import 'package:weather_app/data/repositories/auth_repository.dart';
import 'package:weather_app/domain/models/app_user_model.dart';

class AuthRepositoryRemote implements AuthRepository {
  @override
  Future<AppUserModel> createUser({
    required String email,
    required String password,
  }) async {
    // try {
    final userCredential =
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );

    return AppUserModel(email: userCredential.user!.email!);
  }

  @override
  Future<AppUserModel> loginUser({
    required String email,
    required String password,
  }) async {
    final userCredential =
        await FirebaseAuth.instance.signInWithEmailAndPassword(
      email: email,
      password: password,
    );

    return AppUserModel(email: userCredential.user!.email!);
  }

  Future<AppUserModel> signInWithGoogle() async {
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    final GoogleSignInAuthentication? googleAuth =
        await googleUser?.authentication;

    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    final userCredential =
        await FirebaseAuth.instance.signInWithCredential(credential);

    return AppUserModel(email: userCredential.user!.email!);
  }

  @override
  Future<void> signOut() async {
    await FirebaseAuth.instance.signOut();
  }

  @override
  bool checkAuth() {
    final user = FirebaseAuth.instance.currentUser;
    return (user == null) ? false : true;
  }

  @override
  AppUserModel? currentAuth() {
    return AppUserModel(email: FirebaseAuth.instance.currentUser!.email!);
  }
}
