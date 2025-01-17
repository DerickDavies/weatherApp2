import 'package:firebase_auth/firebase_auth.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:weather_app/data/repositories/auth/auth_repository.dart';
import 'package:weather_app/domain/models/app_user_model.dart';

part 'sign_up_notifier.g.dart';

@riverpod
class SignUpNotifier extends _$SignUpNotifier {
  late final _repo = ref.read(authRepositoryProvider);

  @override
  FutureOr<AppUserModel?> build() {
    return null;
  }

  createNewUser({
    required String email,
    required String password,
  }) async {
    state = AsyncValue.loading();

    try {
      final user = await _repo.createUser(email: email, password: password);
      state = AsyncValue.data(user); // Update state with the successful result
    } on FirebaseAuthException catch (e, stackTrace) {
      state = AsyncValue.error(
        e.code,
        stackTrace,
      ); // Pass the exception object and stack trace
    }
  }
}
