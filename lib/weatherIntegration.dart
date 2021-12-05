import 'package:weather/weather.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class weatherIntegration {
  WeatherFactory wf = new WeatherFactory("2abf19a0ef448d0b015dd915f5be78d1");

  List<String> locations = [];

  Future<basicWeatherInfo> generateBasicWeatherInfo(city) async {
    final now = new DateTime.now();
    String formatter = DateFormat.yMMMMd('en_US').add_jm().format(now);
    Weather w = await wf.currentWeatherByCityName(city);
    basicWeatherInfo w2 = new basicWeatherInfo(
        w.weatherIcon.toString(),
        formatter,
        w.areaName.toString(),
        w.weatherDescription.toString(),
        w.temperature.toString(),
        w.cloudiness.toString(),
        w.country.toString(),
        w.humidity.toString(),
        w.tempFeelsLike.toString(),
        w.windSpeed.toString(),
        w.rainLast3Hours.toString(),
        w.snowLast3Hours.toString(),
        w.latitude.toString(),
        w.longitude.toString());

    return w2;
  }

  Future<List<hourlyandDailyWeatherInfo>> generateHourlyandDaily(
      lat, lon) async {
    List<hourlyandDailyWeatherInfo> hourlyandDailyWeather = [];
    final response = await http.get(Uri.parse(
        "http://api.openweathermap.org/data/2.5/onecall?lat=${lat}&lon=${lon}&exclude=minutely,currently,alerts&appid=2abf19a0ef448d0b015dd915f5be78d1&units=metric"));

    if (jsonDecode(response.body).length > 0) {
      for (var i = 0; i < 5; i++) {
        String twentyFourHourTime = DateTime.fromMillisecondsSinceEpoch(
                    jsonDecode(response.body)["hourly"][i]['dt'] * 1000)
                .toString()
                .split(" ")[1]
                .split(".")[0]
                .split(":00")[0] +
            (":00");
        String temp =
            jsonDecode(response.body)["hourly"][i]['temp'].toString() + "°C";
        String dailyDt = DateTime.fromMillisecondsSinceEpoch(
                jsonDecode(response.body)["daily"][i]['dt'] * 1000)
            .toString()
            .split(" ")[0];
        String dailyTemp = jsonDecode(response.body)["daily"][i]['temp']['day']
                .toString() +
            "°C" +
            "/" +
            jsonDecode(response.body)["daily"][i]['temp']['night'].toString() +
            "°C";

        hourlyandDailyWeather.add(new hourlyandDailyWeatherInfo(
            temp,
            jsonDecode(response.body)["hourly"][i]["weather"][0]['icon'],
            twentyFourHourTime,
            dailyDt,
            dailyTemp,
            jsonDecode(response.body)["daily"][i]["weather"][0]['icon']));
      }
    }
    return hourlyandDailyWeather;
  }
}

class basicWeatherInfo {
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
  String longitude;
  String latitude;

  basicWeatherInfo(
      this.weatherIcon,
      this.date,
      this.areaName,
      this.weatherDescription,
      this.temperature,
      this.cloudiness,
      this.country,
      this.humidity,
      this.tempFeelsLike,
      this.windSpeed,
      this.rainLast3Hours,
      this.snowLast3Hours,
      this.latitude,
      this.longitude);

  basicWeatherDetails() {
    return '${this.weatherIcon};${this.date};${this.areaName};${this.weatherDescription};${this.temperature.replaceAll(' Celsius', ' °C')};${this.cloudiness};${this.country};${this.humidity};${this.tempFeelsLike};${this.windSpeed};${this.rainLast3Hours};${this.snowLast3Hours}';
  }
}

class hourlyandDailyWeatherInfo {
  String temp;
  String icon;
  String timeStamp;
  String dailyDt;
  String dailyTemp;
  String dailyIcon;

  hourlyandDailyWeatherInfo(this.temp, this.icon, this.timeStamp, this.dailyDt,
      this.dailyTemp, this.dailyIcon);
}

class weather {
  String city;
  String lat;
  String lon;

  weather(this.city, this.lat, this.lon);
}
