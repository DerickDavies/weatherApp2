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

    state = await AsyncValue.guard(
      () async {
        return await _repo.loginUser(email: email, password: password);
      },
    );
  }
}
