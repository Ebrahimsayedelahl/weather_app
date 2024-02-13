import 'package:weather_appp/features/home/data/models/list_model.dart';

class FiveDaysWeatherModel {
  String name;
  String country;
  int id;
  int timezone;
  double lat, lon;
  List<ListModel> list;
  //String icon;

  FiveDaysWeatherModel({
    required this.id,
    required this.name,
    required this.country,
    required this.lon,
    required this.lat,
    required this.timezone,
    required this.list,
 //   required this.icon,
  });

  factory FiveDaysWeatherModel.fromJson(Map<String, dynamic> json) {
    List<ListModel> list = (json['list'] as List<dynamic>)
        .map((item) => ListModel.fromJson(item),)
        .toList();
    return FiveDaysWeatherModel(
      id: json['city']['id'],
      name: json['city']['name'],
      country: json['city']['country'],
      lat: json['city']['coord']['lat'],
      lon: json['city']['coord']['lon'],
      timezone: json['city']['timezone'],

      list: list,
    );
  }
}
