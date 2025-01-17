import 'package:firebase_auth/firebase_auth.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:weather_app/data/repositories/auth/auth_repository.dart';
import 'package:weather_app/domain/models/app_user_model.dart';

part 'login_in_notifier.g.dart';

@riverpod
class LoginInNotifier extends _$LoginInNotifier {
  late final _repo = ref.read(authRepositoryProvider);

  FutureOr<AppUserModel?> build() {
    return null;
  }

  loginUser({
    required String email,
    required String password,
  }) async {
    state = AsyncValue.loading();

    // try {
    //   state = AsyncValue.data(user); // Update state with the successful result
    // } on FirebaseAuthException catch (e, stackTrace) {
    //   state = AsyncValue.error(
    //     e.code,
    //     stackTrace,
    //   ); // Pass the exception object and stack trace
    // }

    state = await AsyncValue.guard(
      () async {
        final user = await _repo.loginUser(email: email, password: password);
        return user;
      },
    );
  }
}
