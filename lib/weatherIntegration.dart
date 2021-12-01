import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:weather/weather.dart';
import 'package:intl/intl.dart';

class weatherIntegration extends StatelessWidget {
  WeatherFactory wf = new WeatherFactory("2abf19a0ef448d0b015dd915f5be78d1");
  @override
  Widget build(BuildContext context) {
    return new FutureBuilder(
        future: generateBasicWeatherInfo(),
        builder: ( context, AsyncSnapshot<String?> text) {
          return new SingleChildScrollView(

              padding: new EdgeInsets.fromLTRB(40, 50, 0, 0),
              child: new Text(
                text.data.toString(),
                style: new TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 19.0,
                ),
              ));
        });
    throw UnimplementedError();
  }

  Future <String> generateBasicWeatherInfo() async {
    final now = new DateTime.now();
    String formatter = DateFormat.yMMMMd('en_US').add_jm().format(now);
    Weather w = await wf.currentWeatherByCityName("Calgary");
    weatherInfo w2 = new weatherInfo(w.weatherIcon.toString(), formatter, w.areaName.toString(), w.weatherDescription.toString(), w.temperature.toString(),w.cloudiness.toString(), w.country.toString(), w.humidity.toString(), w.tempFeelsLike.toString(), w.windSpeed.toString(),
     w.rainLast3Hours.toString(), w.snowLast3Hours.toString());
    //generateExtendedWeatherInfo();
    return w2.homePageWeather();
  }

  Future <String> generateHourlyWeatherInfo() async {
    final now = new DateTime.now();
    String formatter = DateFormat.yMMMMd('en_US').add_jm().format(now);
    Weather w = await wf.currentWeatherByCityName("Calgary");
    weatherInfo w2 = new weatherInfo(w.weatherIcon.toString(), formatter, w.areaName.toString(), w.weatherDescription.toString(), w.temperature.toString(),w.cloudiness.toString(), w.country.toString(), w.humidity.toString(), w.tempFeelsLike.toString(), w.windSpeed.toString(),
        w.rainLast3Hours.toString(), w.snowLast3Hours.toString());
    //generateExtendedWeatherInfo();
    return w2.TopMainPageWeather();
  }

  Future <String> generateDailyWeatherInfo() async {
    final now = new DateTime.now();
    String formatter = DateFormat.yMMMMd('en_US').add_jm().format(now);
    Weather w = await wf.currentWeatherByCityName("Calgary");
    weatherInfo w2 = new weatherInfo(w.weatherIcon.toString(), formatter, w.areaName.toString(), w.weatherDescription.toString(), w.temperature.toString(),w.cloudiness.toString(), w.country.toString(), w.humidity.toString(), w.tempFeelsLike.toString(), w.windSpeed.toString(),
        w.rainLast3Hours.toString(), w.snowLast3Hours.toString());
    //generateExtendedWeatherInfo();
    return w2.TopMainPageWeather();
  }

// Future <void> generateExtendedWeatherInfo() async {
  //   WeatherFactory wf = new WeatherFactory("c48e86678767091bfe526d529e68a4af");
  //   List <Weather> w = await wf.fiveDayForecastByCityName("Calgary");
  //   print(w);
  // }

  }


class weatherInfo {
  String weatherIcon;
  String date;
  String areaName;
  String weatherDescription;
  String temperature;
  String cloudiness;
  String country;
  String humidity;
  String tempFeelsLike;
  String windSpeed;
  String rainLast3Hours;
  String snowLast3Hours;



  weatherInfo(this.weatherIcon, this.date, this.areaName, this.weatherDescription, this.temperature,
      this.cloudiness, this.country, this.humidity, this.tempFeelsLike, this.windSpeed,
      this.rainLast3Hours, this.snowLast3Hours);

  homePageWeather() {
    return '${this.weatherIcon};${this.date};${this.areaName};${this.weatherDescription};${this.temperature.replaceAll(' Celsius',' °C')}';
  }

  TopMainPageWeather() {
    return '${this.weatherIcon};${this.date};${this.areaName};${this.weatherDescription};${this.temperature.replaceAll(' Celsius',' °C')};${this.cloudiness};${this.country};${this.humidity};${this.tempFeelsLike};${this.windSpeed};${this.rainLast3Hours};${this.snowLast3Hours}';
    // return '${this.weatherIcon};${this.date};${this.areaName};${this.temperature.replaceAll(' Celsius',' °C')};${this.country}';
  }

}

