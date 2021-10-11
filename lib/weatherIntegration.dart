import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:weather/weather.dart';
import './topWeather.dart';

class weatherIntegration extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    return new FutureBuilder(
        future: generateBasicWeatherInfo(),
        builder: ( context, AsyncSnapshot<String?> text) {
          return new SingleChildScrollView(
              padding: new EdgeInsets.all(8.0),
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
    String weatherDesc = await w.weatherDescription.toString();
    weather2 w2 = new weather2(w.areaName.toString());
    return w2.areaName;
  }

}

class weather2 {
  String areaName;


  weather2(this.areaName);

}

// }
//
// class weatherObj {
//   String areaName;
//   String temperature;
//
//   weatherObj(this.areaName, this.temperature);
// }

