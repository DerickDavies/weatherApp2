import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:weather_app/data/repositories/weather_repository.dart';
import 'package:weather_app/domain/models/weather.dart';
part 'local_weather_notifier.g.dart';

@riverpod
class LocalWeatherNotifier extends _$LocalWeatherNotifier {
  late final _repo = ref.read(weatherRepositoryProvider);
  @override
  FutureOr<Weather?> build() {
    return null;
  }

  getLocalData() async {
    state = const AsyncValue.loading();

    state = await AsyncValue.guard(() async {
      final position = await _repo.getCurrentLocation();
      final weather = await _repo.fetchWeatherData(
          lat: (position.latitude), lon: (position.longitude));

      return weather;
    });
  }
}
