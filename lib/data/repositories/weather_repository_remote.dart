import 'dart:convert';

import 'package:weather_app/data/repositories/weather_repository.dart';
import 'package:weather_app/domain/models/geo_location.dart';
import 'package:weather_app/domain/models/weather.dart';
import 'package:geolocator/geolocator.dart';

import 'package:http/http.dart' as http;

class WeatherRepositoryRemote implements WeatherRepository {
  static const String _apiKey = "ef7c7d0589a1ad4788889e69f23c57a1";

  @override
  Future<Weather> fetchWeatherData({
    required double lat,
    required double lon,
  }) async {
    final uri = Uri.parse(
      "https://api.openweathermap.org/data/2.5/weather?lat=$lat&lon=$lon&appid=$_apiKey",
    );

    final response = await http.get(uri);

    /// purpose of [[weatherFromJson]]
    // Else we need this
    // return Weather.fromJson(json.decode(response.body));
    return weatherFromJson(response.body);
  }

  @override
  Future<GeoLocation> getGeoCode({
    required String cityName,
    required String stateCode,
    required String countryCode,
  }) async {
    final uri = Uri.parse(
      "http://api.openweathermap.org/geo/1.0/direct?q=$cityName,$stateCode,$countryCode&appid=$_apiKey",
    );
    final response = await http.get(uri);
    final data = json.decode(response.body);

    return GeoLocation(lat: data[0]['lat'], lon: data[0]['lon']);
  }

  @override //Since this is a separate service, you may put it in another repository.
  // But this is a basic functionality. So its just enough to put it in a riverpod notifier.
  Future<Position> getCurrentLocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled don't continue
      // accessing the position and request users of the
      // App to enable the location services.
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Permissions are denied, next time you could try
        // requesting permissions again (this is also where
        // Android's shouldShowRequestPermissionRationale
        // returned true. According to Android guidelines
        // your App should show an explanatory UI now.
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.
    return await Geolocator.getCurrentPosition();
  }
}
