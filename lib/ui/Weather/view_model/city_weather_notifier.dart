import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:weather_app/data/repositories/weather_repository.dart';
import 'package:weather_app/domain/models/weather.dart';
part 'city_weather_notifier.g.dart';

@riverpod
class CityWeatherNotifier extends _$CityWeatherNotifier {
  late final _repo = ref.read(weatherRepositoryProvider);
  @override
  FutureOr<Weather?> build() {
    return null;
  }

  getCityData({
    required String cityName,
    required String stateCode,
    required String countryCode,
  }) async {
    state = const AsyncValue.loading();

    state = await AsyncValue.guard(() async {
      final geoData = await _repo.getGeoCode(
          cityName: cityName, countryCode: countryCode, stateCode: stateCode);

      final weather =
          await _repo.fetchWeatherData(lat: (geoData.lat), lon: (geoData.lon));

      return weather;
    });
  }

}

