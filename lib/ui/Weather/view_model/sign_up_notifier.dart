import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:weather_app/data/repositories/auth_repository.dart';
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

    state = await AsyncValue.guard(
      () async {
        return await _repo.createUser(email: email, password: password);
      },
    );
  }
}
