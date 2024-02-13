import 'package:weather_appp/features/home/data/models/weather.dart';

class ListModel {
 List<Weather> weather;
  dynamic temp;
  dynamic temp_min;
  dynamic temp_max;
  String dt_txt;


  ListModel({
    required this.temp,
    required this.temp_max,
    required this.dt_txt,
   required this.temp_min,
   // required this.icon,
 required this.weather
  });

  factory ListModel.fromJson(Map<String, dynamic> json) {
    List<Weather> list = (json['weather'] as List<dynamic>)
        .map((item) => Weather.fromJson(item),).toList();
    return ListModel(
      temp: json['main']['temp'],
      temp_min: json['main']['temp_min'],
      temp_max: json['main'][' temp_max'],
      dt_txt: json['dt_txt'],

      weather: list,
    );
  }
}
