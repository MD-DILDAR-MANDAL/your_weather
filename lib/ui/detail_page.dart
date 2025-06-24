import 'dart:ui';

import 'package:flutter/material.dart';

import 'package:intl/intl.dart';
import 'package:your_weather/components/weather_item.dart';
import 'package:your_weather/widgets/constants.dart';

class DetailPage extends StatefulWidget {
  final dailyForecastWeather;

  const DetailPage({super.key, this.dailyForecastWeather});

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  final Constants _constants = Constants();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    var weatherData = widget.dailyForecastWeather;

    //function to get weather
    Map getForecastWeather(int index) {
      int maxWindSpeed = weatherData[index]["day"]["maxwind_kph"].toInt();
      int avgHumidity = weatherData[index]["day"]["avghumidity"].toInt();
      int chanceOfRain =
          weatherData[index]["day"]["daily_chance_of_rain"].toInt();

      var parsedDate = DateTime.parse(weatherData[index]["date"]);
      var forecastDate = DateFormat('EEEE, d MMMM').format(parsedDate);

      String weatherName = weatherData[index]["day"]["condition"]["text"];
      String weatherIcon =
          weatherName.replaceAll(' ', '').toLowerCase() + ".png";

      int minTemperature = weatherData[index]["day"]["mintemp_c"].toInt();
      int maxTemperature = weatherData[index]["day"]["maxtemp_c"].toInt();

      var forecastData = {
        'maxWindSpeed': maxWindSpeed,
        'avgHumidity': avgHumidity,
        'chanceOfRain': chanceOfRain,
        'forecastDate': forecastDate,
        'weatherName': weatherName,
        'weatherIcon': weatherIcon,
        'minTemperature': minTemperature,
        'maxTemperature': maxTemperature,
      };
      return forecastData;
    }

    return Scaffold(
      backgroundColor: _constants.primaryColor,
      appBar: AppBar(
        title: const Text('Forecasts'),
        centerTitle: true,
        foregroundColor: Colors.white,
        backgroundColor: _constants.primaryColor,
        elevation: 0.0,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: IconButton(
              onPressed: () {
                print("Settings Tapped!");
              },
              icon: const Icon(Icons.settings),
            ),
          ),
        ],
      ),
      body: Stack(
        alignment: Alignment.center,
        clipBehavior: Clip.none,
        children: [
          Positioned(
            bottom: 0,
            left: 0,
            child: Container(
              height: size.height * .75,
              width: size.width,
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(50),
                  topRight: Radius.circular(50),
                ),
              ),
              child: Stack(
                clipBehavior: Clip.none,
                children: [
                  Positioned(
                    top: -50,
                    right: 20,
                    left: 20,
                    child: Container(
                      height: 300,
                      width: size.width * .7,
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.center,
                          colors: [Color(0xffA15F19), Color(0xffCF9D67)],
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: _constants.primaryColor.withOpacity(.3),
                            offset: const Offset(-15, 15),
                            blurRadius: 3,
                            spreadRadius: -5,
                          ),
                        ],
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Stack(
                        clipBehavior: Clip.none,
                        children: [
                          Positioned(
                            child: Image.asset(
                              "assets/" + getForecastWeather(0)["weatherIcon"],
                              errorBuilder: (context, error, StackTrace) {
                                return Container();
                              },
                            ),
                            width: 150,
                          ),
                          Positioned(
                            top: 150,
                            left: 30,
                            child: Padding(
                              padding: const EdgeInsets.only(bottom: 10.0),
                              child: Text(
                                getForecastWeather(0)["weatherName"],
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                ),
                              ),
                            ),
                          ),
                          Positioned(
                            bottom: 20,
                            left: 20,
                            child: Container(
                              width: size.width * .8,
                              padding: const EdgeInsets.symmetric(
                                horizontal: 20,
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  WeatherItem(
                                    value:
                                        getForecastWeather(0)["maxWindSpeed"],
                                    unit: "km/h",
                                    imageUrl: "assets/windspeed.png",
                                  ),
                                  WeatherItem(
                                    value: getForecastWeather(0)["avgHumidity"],
                                    unit: "%",
                                    imageUrl: "assets/humidity.png",
                                  ),
                                  WeatherItem(
                                    value:
                                        getForecastWeather(0)["chanceOfRain"],
                                    unit: "%",
                                    imageUrl: "assets/lightrain.png",
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Positioned(
                            top: 20,
                            right: 20,
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  getForecastWeather(
                                    0,
                                  )["maxTemperature"].toString(),
                                  style: TextStyle(
                                    fontSize: 80,
                                    fontWeight: FontWeight.bold,
                                    foreground:
                                        Paint()..shader = _constants.shader,
                                  ),
                                ),
                                Text(
                                  'o',
                                  style: TextStyle(
                                    fontSize: 40,
                                    fontWeight: FontWeight.bold,
                                    foreground:
                                        Paint()..shader = _constants.shader,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Positioned(
                            top: 320,
                            left: 0,
                            right: 0,
                            //bottom: 0,
                            child: Column(
                              children: [
                                cardElement(getForecastWeather, 0),
                                cardElement(getForecastWeather, 1),
                                cardElement(getForecastWeather, 2),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Card cardElement(
    Map<dynamic, dynamic> Function(int index) getForecastWeather,
    final int ind,
  ) {
    return Card(
      elevation: 3.0,
      margin: const EdgeInsets.only(bottom: 20),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  getForecastWeather(ind)["forecastDate"],
                  style: TextStyle(
                    color: _constants.primaryColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Row(
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 8.0),
                          child: Text(
                            getForecastWeather(
                              ind,
                            )["minTemperature"].toString(),
                            style: TextStyle(
                              color: _constants.greyColor,
                              fontSize: 30,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        Text(
                          'o',
                          style: TextStyle(
                            color: _constants.greyColor,
                            fontSize: 22,
                            fontWeight: FontWeight.w600,
                            fontFeatures: const [FontFeature.enable('sups')],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(width: 30),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 8.0),
                          child: Text(
                            getForecastWeather(
                              ind,
                            )["maxTemperature"].toString(),
                            style: TextStyle(
                              color: _constants.blackColor,
                              fontSize: 30,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        Text(
                          'o',
                          style: TextStyle(
                            color: _constants.blackColor,
                            fontSize: 22,
                            fontWeight: FontWeight.w600,
                            fontFeatures: const [FontFeature.enable('sups')],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      'assets/' + getForecastWeather(ind)["weatherIcon"],
                      width: 30,
                      errorBuilder: (context, error, StackTrace) {
                        return Container();
                      },
                    ),
                    const SizedBox(width: 5),
                    Text(
                      getForecastWeather(ind)["weatherName"],
                      style: TextStyle(
                        fontSize: 16,
                        color: _constants.secondaryColor,
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      getForecastWeather(ind)["chanceOfRain"].toString() + "%",
                      style: const TextStyle(fontSize: 18, color: Colors.grey),
                    ),
                    const SizedBox(width: 5),
                    Image.asset('assets/lightrain.png', width: 30),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
