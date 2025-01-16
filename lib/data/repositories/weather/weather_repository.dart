import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geolocator/geolocator.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:weather_app/data/repositories/weather/weather_repository_remote.dart';
import 'package:weather_app/domain/models/geo_location.dart';
import 'package:weather_app/domain/models/weather.dart';
part 'weather_repository.g.dart';

abstract class WeatherRepository {
  Future<Weather> fetchWeatherData({
    required double lat,
    required double lon,
  });

  Future<GeoLocation> getGeoCode({
    required String cityName,
    required String stateCode,
    required String countryCode,
  });

  Future<Position> getCurrentLocation();
}

@Riverpod(keepAlive: true)
WeatherRepository weatherRepository(Ref ref) {
  return WeatherRepositoryRemote();
}
