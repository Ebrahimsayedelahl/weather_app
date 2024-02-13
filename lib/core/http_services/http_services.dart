import 'dart:convert';
import 'package:weather_appp/core/app_constants/app_constants.dart';
import 'package:http/http.dart' as http;
import 'package:weather_appp/features/home/data/models/fiveDaysWeatherModel.dart';

class HttpServices {

  static getCurrentWeather({
    required String city,
  }) async {
    final response = await http.get(Uri.parse('${AppConstants.baseUrl}/weather?q=$city&${AppConstants.apiKey}'));
    return json.decode(response.body);
  }
  static getFiveDaysWeather({
    required String city,
  }) async {
    final response = await http.get(Uri.parse('${AppConstants.baseUrl}/forecast?q=$city&${AppConstants.apiKey}'));
//print(response.body);
    return json.decode(response.body);
  }


}