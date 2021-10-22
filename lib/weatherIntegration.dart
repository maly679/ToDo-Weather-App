import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:weather/weather.dart';


class weatherIntegration extends StatelessWidget {
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
    WeatherFactory wf = new WeatherFactory("c48e86678767091bfe526d529e68a4af");
    double lat = 55.0111;
    double lon = 15.0569;
    Weather w = await wf.currentWeatherByCityName("Calgary");
    weatherInfo w2 = new weatherInfo(w.weatherIcon.toString(), w.date.toString(), w.areaName.toString(), w.weatherDescription.toString(), w.temperature.toString()
    , w.cloudiness.toString(), w.country.toString(), w.humidity.toString(), w.tempFeelsLike.toString(), w.windSpeed.toString(),
     w.rainLast3Hours.toString(), w.snowLast3Hours.toString());
    //generateExtendedWeatherInfo();
    return w2.toString();
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

  toString() {
    return '${this.weatherIcon};${this.date};${this.areaName};${this.weatherDescription};${this.temperature.replaceAll(' Celsius',' °C')};${this.cloudiness};${this.country};${this.humidity};${this.tempFeelsLike};${this.windSpeed};${this.rainLast3Hours};${this.snowLast3Hours}';

  }

}

