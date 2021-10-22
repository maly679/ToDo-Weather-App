import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:todolist_weather/weatherIntegration.dart';
import 'package:weather/weather.dart';

class topWeather extends StatelessWidget {
  @override


  final wi = new weatherIntegration();
  Widget build(BuildContext context) {

    return Container(

      padding: const EdgeInsets.fromLTRB(25,25,25,25),
        color: Colors.white.withOpacity(0.4),
      margin: const EdgeInsets.fromLTRB(40, 50, 0, 0),
      alignment: Alignment.center,
      width: 300,
      height: 250,
      child:  new FutureBuilder(
          future: wi.generateBasicWeatherInfo(),
          builder: ( context, AsyncSnapshot<String> text) {
            var splitWeatherData = text.data.toString().split(';');

            return SafeArea(


                child: new Column(children: <Widget>[

                  Row(

                mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Expanded(
                          child: new Text(splitWeatherData[2],
                            textAlign: TextAlign.center,
                        style: new TextStyle(
                          color: Colors.white,
                          fontSize: 30.0,
                        ),
                      ))]),
                  Row(

                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Expanded(
                            child: new Text(splitWeatherData[1],
                              textAlign: TextAlign.center,
                              style: new TextStyle(
                                color: Colors.black,
                                fontSize: 20.0,
                              ),
                            ))]),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                Expanded(

              child: Image.network(
                "https://openweathermap.org/img/w/${splitWeatherData[0]}.png"
              ),),

              Expanded(

              child: new Text(
                splitWeatherData[4].toString(),
                  style: new TextStyle(
                    color: Colors.white,
                    fontSize: 30.0,
                  ),
                ),

            )
          ])
          ]));}));
      throw UnimplementedError();
    }

  }