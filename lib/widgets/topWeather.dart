import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../weatherIntegration.dart';
import 'package:weather/weather.dart';
import 'package:todo_apps/pages/mainWeatherPage.dart';

class topWeather extends StatelessWidget {
  @override
  final wi = new weatherIntegration();

  Widget build(BuildContext context) {
    return Container(
        color: Colors.white.withOpacity(0.4),
        margin: const EdgeInsets.fromLTRB(20, 50, 20, 25),
        alignment: Alignment.center,
        child: new FutureBuilder(
            future: wi.generateBasicWeatherInfo(),
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
                Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      new GestureDetector(
                          onTap: () {
                            var route = new MaterialPageRoute(
                              builder: (BuildContext context) =>
                                  new mainWeather(wi: wi),
                            );
                            Navigator.of(context).push(route);
                          },
                          child: new Text("MORE",
                              style: new TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontStyle: FontStyle.italic,
                                  fontSize: 20,
                                  color: Colors.blue)))
                    ])
              ]));
            }));
    throw UnimplementedError();
  }
}
