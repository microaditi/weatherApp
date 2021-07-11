import 'dart:math';

import 'package:weatherapp/model/weather.dart';

abstract class WeatherRepository {
  Future<Weather> fetchWeather(String cityName);
}

class FakeWeatherRepository extends WeatherRepository {
  @override
  Future<Weather> fetchWeather(String cityName) {
    //Simulates Network Delay
    return Future.delayed(Duration(seconds: 2), () {
      final random = Random();

      if (random.nextBool()) {
        throw NetworkException();
      }

      return Weather(
          cityName: cityName,
          temperatureCelsius: 20 + random.nextInt(15) + random.nextDouble());
    });
  }
}

class NetworkException implements Exception {}
