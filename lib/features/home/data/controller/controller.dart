import 'dart:async';
import 'package:weather_appp/features/home/data/models/currentWeatherModel.dart';
import '../../presentation/home_view.dart';
import '../models/fiveDaysWeatherModel.dart';

class WeatherData {
  final CurrentWeather currentWeather;
  final FiveDaysWeatherModel fiveDaysWeather;

  WeatherData({required this.currentWeather, required this.fiveDaysWeather});
}

Future<WeatherData> fetchWeatherData(String city) async {
  CurrentWeather currentWeather = await getCurrentWeather(city: city);
  FiveDaysWeatherModel fiveDaysWeather = await getFiveDaysWeather(city: city);
  return WeatherData(
      currentWeather: currentWeather, fiveDaysWeather: fiveDaysWeather);
}

