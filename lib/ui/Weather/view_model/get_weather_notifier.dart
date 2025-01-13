import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:weather_app/data/repositories/weather_repository.dart';
import 'package:weather_app/domain/models/weather.dart';
part 'get_weather_notifier.g.dart';

@riverpod
class GetWeatherNotifier extends _$GetWeatherNotifier {
  @override
  FutureOr<Weather?> build() {
    return null;
  }

  getData({
    required String cityName,
    required String stateCode,
    required String countryCode,
  }) async {
    state = const AsyncValue.loading();

    state = await AsyncValue.guard(() async {
      final repo = ref.read(weatherRepositoryProvider);
      final geoData = await repo.getGeoCode(
          cityName: cityName, countryCode: countryCode, stateCode: stateCode);

      final weather =
          await repo.fetchWeatherData(lat: (geoData.lat), lon: (geoData.lon));

      return weather;
    });
  }
}
