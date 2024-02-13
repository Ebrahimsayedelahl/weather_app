import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:weather_appp/features/home/data/controller/controller.dart';

import 'package:weather_appp/features/home/data/models/currentWeatherModel.dart';
import 'package:weather_appp/features/home/data/models/fiveDaysWeatherModel.dart';

import '../../../core/http_services/http_services.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  List<FiveDaysWeatherModel> daysList = [];

  final TextEditingController searchController = TextEditingController();

  String city = 'Cairo';

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    return Scaffold(
        body: FutureBuilder<WeatherData>(
            future: fetchWeatherData(city),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                print(snapshot.data);
                return Container(
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage("assets/images/cloud4.jpg"),
                      fit: BoxFit.cover,
                    ),
                  ),
                  child: Padding(
                    padding:
                        const EdgeInsets.only(top: 60, right: 15, left: 15),
                    child: Column(
                      children: [
                        TextField(
                          controller: searchController,
                          decoration: InputDecoration(
                            border: const OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                            ),
                            suffixIcon: IconButton(
                                onPressed: () {
                                  setState(() {
                                    city = searchController.text;
                                  });
                                },
                                icon: const Icon(
                                  Icons.search,
                                  color: Colors.white,
                                )),
                            hintText: "search",
                            hintStyle: const TextStyle(color: Colors.white),
                            fillColor: Colors.white,
                          ),
                          keyboardType: TextInputType.text,
                          style: TextStyle(color: Colors.white),
                        ),
                        SizedBox(
                          height: screenSize.height * 0.07,
                        ),
                        Container(
                          child: Center(
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      " ${snapshot.data!.currentWeather.name},",
                                      style: const TextStyle(
                                          fontSize: 30, color: Colors.white),
                                    ),
                                    Text(
                                      " ${snapshot.data!.currentWeather.country}",
                                      style: const TextStyle(
                                          fontSize: 25, color: Colors.white),
                                    ),
                                  ],
                                ),
                                const Divider(),
                                Padding(
                                  padding: const EdgeInsets.only(left: 8.0),
                                  child: Row(
                                    children: [
                                      Column(
                                        children: [
                                          Text(
                                            '${(snapshot.data!.currentWeather.temp - 273.15).round().toString()}\u2103',
                                            style: Theme.of(context)
                                                .textTheme
                                                .headline2!
                                                .copyWith(
                                                    color: Colors.white,
                                                    fontFamily:
                                                        'flutterfonts'),
                                          ),
                                          const SizedBox(
                                            height: 15,
                                          ),
                                          Text(
                                            'Max:${(snapshot.data!.currentWeather.temp_min - 273.15).round().toString()}\u2103-Min:${(snapshot.data!.currentWeather.temp_max - 273.15).round().toString()}\u2103',
                                            style: const TextStyle(
                                                color: Colors.white),
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        width: screenSize.width * 0.25,
                                      ),
                                      Column(
                                        children: [
                                          Image.network(
                                            'https://openweathermap.org/img/wn/${snapshot.data!.currentWeather.icon}@2x.png',
                                            scale: 1.2,
                                          ),
                                          Text(
                                            " ${snapshot.data!.currentWeather.description}",
                                            overflow: TextOverflow.ellipsis,
                                            style: const TextStyle(
                                                fontSize: 15,
                                                color: Colors.white),
                                          ),
                                          const SizedBox(
                                            height: 20,
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                                //Text('${snapshot.data!.currentWeather.speed}')
                              ],
                            ),
                          ),
                          height: screenSize.height * 0.3,
                          width: screenSize.width * 0.9,
                          decoration: BoxDecoration(
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black12.withOpacity(0.2),
                                ),
                              ],
                              borderRadius: const BorderRadius.all(
                                  Radius.circular(10))),
                        ),
                        ListTile(
                          leading:Icon(Icons.watch_later_outlined ,color: Colors.white,size: 35,),
                          title: Text('Hourly Forecast',style: TextStyle(color: Colors.white,fontSize: 36),),
                        ),
                        Divider(),
                        SizedBox(
                          height: screenSize.height * 0.1,
                        ),
                        Container(
                            height: 150,
                            child: ListView.separated(
                              physics: const BouncingScrollPhysics(),
                              scrollDirection: Axis.horizontal,
                              separatorBuilder: (context, index) =>
                                  const VerticalDivider(
                                color: Colors.transparent,
                                width: 3,
                              ),
                              itemCount:
                                  snapshot.data!.fiveDaysWeather.list.length,
                              itemBuilder: (context, index) {
                                return Container(
                                  width: 110,
                                  height: 200,
                                  child: Card(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    color: Colors.black.withOpacity(0.2),
                                    // Set the background color with transparency
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: <Widget>[
                                        Text(
                                          DateFormat('MMMM').format(
                                              DateTime.parse(snapshot
                                                  .data!
                                                  .fiveDaysWeather
                                                  .list[index]
                                                  .dt_txt)),
                                          style: const TextStyle(
                                              color: Colors.white),
                                        ),
                                        Text(
                                          DateFormat('hh:mm a').format(
                                              DateTime.parse(snapshot
                                                  .data!
                                                  .fiveDaysWeather
                                                  .list[index]
                                                  .dt_txt)),
                                          style: const TextStyle(
                                              color: Colors.white),
                                        ),
                                        Image.network(
                                          'https://openweathermap.org/img/wn/${snapshot.data!.fiveDaysWeather.list[index].weather[0].icon}@2x.png',
                                          scale: 1.5,
                                        ),
                                        Text(
                                          '${(snapshot.data!.fiveDaysWeather.list[index].temp - 273.15).round().toString()}\u2103',
                                          style: const TextStyle(
                                              color: Colors.white),
                                        ),
                                        Text(
                                          '${snapshot.data!.fiveDaysWeather.list[index].weather[0].description}',
                                          style: const TextStyle(
                                              color: Colors.white),
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              },
                            ))
                      ],
                    ),
                  ),
                );
              } else if (snapshot.hasError) {
                return Center(
                  child: Text('Error: ${snapshot.error.toString()}'),
                );
              } else {
                // Return a loading indicator while waiting for data
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
            }));
  }
}

Future<CurrentWeather> getCurrentWeather({required String city}) async {
  var data = await HttpServices.getCurrentWeather(city: city);
  CurrentWeather weather = CurrentWeather.fromJson(data);
  return weather;
}

Future<FiveDaysWeatherModel> getFiveDaysWeather({required String city}) async {
  var data = await HttpServices.getFiveDaysWeather(city: city);
  FiveDaysWeatherModel weather = FiveDaysWeatherModel.fromJson(data);

  return weather;
}
