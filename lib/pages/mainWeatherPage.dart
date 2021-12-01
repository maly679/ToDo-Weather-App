import 'package:flutter/material.dart';
import 'package:weather/weather.dart';
import '../weatherIntegration.dart';

class mainWeather extends StatelessWidget {
  final weatherIntegration? wi;
  var primaryColor = Color(0xff00CC00);
  var appBarColor = Color(0xFFB2FF59);

  mainWeather({Key? key, this.wi}) : super(key: key);

  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: primaryColor,
        appBar: AppBar(
          backgroundColor: appBarColor,
        ),
        body: Row(children: [
          Expanded(
              child: FutureBuilder(
                  future: wi?.generateBasicWeatherInfo(),
                  builder: (context, AsyncSnapshot<String> text) {
                    var splitWeatherData = text.data.toString().split(';');

                    return SafeArea(
                        child: new Column(children: <Widget>[
                      Row(mainAxisSize: MainAxisSize.min, children: <Widget>[
                        Expanded(
                            child: new Text(
                          splitWeatherData[2],
                          textAlign: TextAlign.center,
                          style: new TextStyle(
                            color: Colors.white,
                            fontSize: 30.0,
                          ),
                        ))
                      ]),
                      Row(mainAxisSize: MainAxisSize.min, children: <Widget>[
                        Expanded(
                            child: new Text(
                          splitWeatherData[1],
                          textAlign: TextAlign.center,
                          style: new TextStyle(
                            color: Colors.black,
                            fontSize: 20.0,
                          ),
                        ))
                      ]),
                      Row(mainAxisSize: MainAxisSize.min, children: <Widget>[
                        Expanded(
                          child: Image.network(
                              "https://openweathermap.org/img/w/${splitWeatherData[0]}.png"),
                        ),
                        Expanded(
                          child: new Text(
                            splitWeatherData[4].toString(),
                            style: new TextStyle(
                              color: Colors.white,
                              fontSize: 30.0,
                            ),
                          ),
                        )
                      ]),
                    ]));
                  }))
        ]));
  }
}
