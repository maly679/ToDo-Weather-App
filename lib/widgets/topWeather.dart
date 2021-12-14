import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../weatherIntegration.dart';
import 'package:todo_list_weather/pages/mainWeatherPage.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class topWeather extends StatefulWidget {
  weatherIntegration? wi;
  List<weather>? weatherData;

  topWeather({Key? key, this.wi, this.weatherData}) : super(key: key);

  @override
  _topWeatherState createState() => _topWeatherState();
}

class _topWeatherState extends State<topWeather> {
  @override
  bool loading = true;

  Future<void> getLocations() async {
    final response =
        await http.get(Uri.parse('http://34.66.241.147:8080/api/locations'));
    if (response.statusCode == 200) {
      if (jsonDecode(response.body).length > 0) {
        for (var i = 0; i < jsonDecode(response.body).length; i++) {
          widget.weatherData!.add(new weather(
              jsonDecode(response.body)[i]['city'],
              jsonDecode(response.body)[i]['latitude'],
              jsonDecode(response.body)[i]['longitude']));
        }
      } else {
        widget.weatherData!.add(new weather("Calgary", "51.0501", "-114.0853"));
      }
    } else {
      print("error. status code not 200/success.");
    }
    setState(() {
      loading = false;
    });
  }

  Widget build(BuildContext context) {
    if (widget.wi == null && widget.weatherData == null) {
      widget.wi = new weatherIntegration();
      widget.wi!.generateHourlyandDaily("51.0501", "-114.0853");
      widget.weatherData = [];
      getLocations();
    }
    if (loading == true) {
      return CircularProgressIndicator();
    } else {
      return Container(
          color: Colors.white.withOpacity(0.4),
          margin: const EdgeInsets.fromLTRB(20, 50, 20, 25),
          alignment: Alignment.center,
          child: new FutureBuilder<basicWeatherInfo>(
              future: widget.wi!.generateBasicWeatherInfo(
                  widget.weatherData![0].city.toString()),
              builder: (context, snapshot) {
                if (snapshot.data == null) {
                  return Text('no data');
                } else {
                  // var splitWeatherData = text.data.toString().split(';');
                  return SafeArea(
                      child: new Column(children: <Widget>[
                    Row(mainAxisSize: MainAxisSize.min, children: <Widget>[
                      Expanded(
                          child: new Text(
                        snapshot.data!.areaName,
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
                        snapshot.data!.date,
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
                            "https://openweathermap.org/img/w/${snapshot.data!.weatherIcon}.png"),
                      ),
                      Expanded(
                        child: new Text(
                          snapshot.data!.temperature
                              .replaceAll(' Celsius', ' °C'),
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
                              onTap: () async {
                                //Navigator.push returns a future value so you need to await for it.
                                List<weather>? updatedLocations =
                                    await Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => new mainWeather(
                                              wi: widget.wi,
                                              weatherData: widget.weatherData),
                                        ));
                                setState(() {
                                  widget.weatherData = updatedLocations;
                                  print(widget.weatherData);
                                });
                              },
                              child: new Text("MORE",
                                  style: new TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontStyle: FontStyle.italic,
                                      fontSize: 20,
                                      color: Colors.blue)))
                        ])
                  ]));
                }
              }));
      throw UnimplementedError();
    }
  }
}
