import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:weather_app/data/repositories/auth/auth_repository.dart';
import 'package:weather_app/domain/models/app_user_model.dart';
part 'auth_notifier.g.dart';

@riverpod
class AuthNotifier extends _$AuthNotifier {
  late final _repo = ref.read(authRepositoryProvider);

  @override
  FutureOr<AppUserModel?> build() {
    return null;
  }

  checkAuth() async {
    await Future.delayed(Duration(seconds: 2));
    state = AsyncValue.loading();

    state = await AsyncValue.guard(
      () async {
        bool isLoggedIn = _repo.checkAuth();

        if (isLoggedIn) {
          return _repo.currentAuth();
        } else {
          return null;
        }
      },
    );
  }

  signOut() {
    _repo.signOut();
  }
}
