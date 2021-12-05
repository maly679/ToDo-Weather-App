import 'package:flutter/material.dart';
import 'package:weather/weather.dart';
import '../weatherIntegration.dart';
import 'locations.dart';
import 'package:http/http.dart' as http;

class mainWeather extends StatefulWidget {
  weatherIntegration? wi;
  List<weather>? weatherData;

  mainWeather({Key? key, this.wi, this.weatherData}) : super(key: key);

  @override
  _mainWeatherState createState() => _mainWeatherState();
}

class _mainWeatherState extends State<mainWeather> {
  var primaryColor = Color(0xff00CC00);
  var appBarColor = Color(0x00000000);

  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: primaryColor,
        appBar: AppBar(
          title: Text('Weather'),
          backgroundColor: Color(0xff00CC00),
          leading: IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () => Navigator.pop(context, widget.weatherData),
          ),
          centerTitle: true,
        ),
        body: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                  child: new FutureBuilder(
                      future: widget.wi!.generateBasicWeatherInfo(
                          widget.weatherData![0].city.toString()),
                      builder:
                          (context, AsyncSnapshot<basicWeatherInfo> snapshot) {
                        return SafeArea(
                            child: new Column(children: <Widget>[
                          Row(
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                new GestureDetector(
                                    onTap: () async {
                                      List<weather>? updatedLocations =
                                          await Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => new locations(
                                                data: widget.weatherData)),
                                      );
                                      setState(() {
                                        widget.weatherData = updatedLocations;
                                      });
                                    },
                                    child: new Text(
                                      "\nLocations +\n",
                                      textAlign: TextAlign.right,
                                      style: new TextStyle(
                                        color: Colors.black,
                                        fontSize: 25,
                                      ),
                                    ))
                              ]),
                          Row(
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
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
                          Row(
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
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
                          Row(
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
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
                        ]));
                      })),
              Container(
                  height: 300, // better for fixed size
                  width: double.infinity,
                  child: new FutureBuilder(
                      future: widget.wi!.generateHourlyandDaily(
                          double.parse(widget.weatherData![0].lat),
                          double.parse(widget.weatherData![0].lon)),
                      builder: (context, AsyncSnapshot snapshot) {
                        return ListView.builder(
                            itemCount: 1,
                            shrinkWrap: true,
                            scrollDirection: Axis.vertical,
                            itemBuilder: (BuildContext context, int index) {
                              return Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: <Widget>[
                                          Text(
                                            snapshot.data![0].timeStamp
                                                .toString(),
                                            style: new TextStyle(
                                              color: Colors.black,
                                              fontSize: 20.0,
                                            ),
                                          ),
                                          SizedBox(width: 32, height: 15),
                                          // give it width
                                          Text(
                                            snapshot.data![1].timeStamp
                                                .toString(),
                                            style: new TextStyle(
                                              color: Colors.black,
                                              fontSize: 20.0,
                                            ),
                                          ),
                                          SizedBox(width: 32, height: 15),
                                          Text(
                                            snapshot.data![2].timeStamp
                                                .toString(),
                                            style: new TextStyle(
                                              color: Colors.black,
                                              fontSize: 20.0,
                                            ),
                                          ),
                                          SizedBox(width: 32, height: 15),
                                          Text(
                                            snapshot.data![3].timeStamp
                                                .toString(),
                                            style: new TextStyle(
                                              color: Colors.black,
                                              fontSize: 20.0,
                                            ),
                                          ),
                                          SizedBox(width: 32, height: 15),
                                          Text(
                                            snapshot.data![4].timeStamp
                                                .toString(),
                                            style: new TextStyle(
                                              color: Colors.black,
                                              fontSize: 20.0,
                                            ),
                                          )
                                        ]),

                                    Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: <Widget>[
                                          Flexible(
                                            child: Image.network(
                                                "https://openweathermap.org/img/w/${snapshot.data![0].icon}.png"),
                                          ),
                                          SizedBox(width: 32.6),
                                          Flexible(
                                            child: Image.network(
                                                "https://openweathermap.org/img/w/${snapshot.data![1].icon}.png"),
                                          ),
                                          SizedBox(width: 32.6),
                                          Flexible(
                                            child: Image.network(
                                                "https://openweathermap.org/img/w/${snapshot.data![2].icon}.png"),
                                          ),
                                          SizedBox(width: 32.6),
                                          Flexible(
                                            child: Image.network(
                                                "https://openweathermap.org/img/w/${snapshot.data![3].icon}.png"),
                                          ),
                                          SizedBox(width: 32.6),
                                          Flexible(
                                            child: Image.network(
                                                "https://openweathermap.org/img/w/${snapshot.data![4].icon}.png"),
                                          ),
                                        ]),

                                    Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: <Widget>[
                                          Text(
                                            snapshot.data![0].temp.toString(),
                                            style: new TextStyle(
                                                color: Colors.black,
                                                fontSize: 13.5),
                                          ),
                                          SizedBox(width: 32, height: 15),
                                          // give it width
                                          Text(
                                            snapshot.data![1].temp.toString(),
                                            style: new TextStyle(
                                                color: Colors.black,
                                                fontSize: 13.5),
                                          ),
                                          SizedBox(width: 32, height: 15),
                                          Text(
                                            snapshot.data![2].temp.toString(),
                                            style: new TextStyle(
                                                color: Colors.black,
                                                fontSize: 13.5),
                                          ),
                                          SizedBox(width: 32, height: 15),
                                          Text(
                                            snapshot.data![3].temp.toString(),
                                            style: new TextStyle(
                                                color: Colors.black,
                                                fontSize: 13.5),
                                          ),
                                          SizedBox(width: 32, height: 15),
                                          Text(
                                            snapshot.data![4].temp.toString(),
                                            style: new TextStyle(
                                                color: Colors.black,
                                                fontSize: 13.5),
                                          )
                                        ]),

                                    Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: <Widget>[
                                          Text(
                                            snapshot.data![0].dailyDt
                                                .toString(),
                                            style: new TextStyle(
                                              color: Colors.black,
                                              fontSize: 20.0,
                                            ),
                                          ),
                                          SizedBox(width: 32, height: 15),
                                          Flexible(
                                            child: Image.network(
                                                "https://openweathermap.org/img/w/${snapshot.data![0].dailyIcon}.png"),
                                          ), // give it width
                                          Text(
                                            snapshot.data![0].dailyTemp
                                                .toString(),
                                            style: new TextStyle(
                                              color: Colors.black,
                                              fontSize: 20,
                                            ),
                                          ),
                                          SizedBox(width: 32, height: 15),
                                        ]),
                                    Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: <Widget>[
                                          Text(
                                            snapshot.data![1].dailyDt
                                                .toString(),
                                            style: new TextStyle(
                                              color: Colors.black,
                                              fontSize: 20.0,
                                            ),
                                          ),
                                          SizedBox(width: 32, height: 15),
                                          Flexible(
                                            child: Image.network(
                                                "https://openweathermap.org/img/w/${snapshot.data![1].dailyIcon}.png"),
                                          ), // give it width
                                          Text(
                                            snapshot.data![1].dailyTemp
                                                .toString(),
                                            style: new TextStyle(
                                              color: Colors.black,
                                              fontSize: 20,
                                            ),
                                          ),
                                          SizedBox(width: 32, height: 15),
                                        ]),
                                    Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: <Widget>[
                                          Text(
                                            snapshot.data![2].dailyDt
                                                .toString(),
                                            style: new TextStyle(
                                              color: Colors.black,
                                              fontSize: 20.0,
                                            ),
                                          ),
                                          SizedBox(width: 32, height: 15),
                                          Flexible(
                                            child: Image.network(
                                                "https://openweathermap.org/img/w/${snapshot.data![2].dailyIcon}.png"),
                                          ), // give it width
                                          Text(
                                            snapshot.data![2].dailyTemp
                                                .toString(),
                                            style: new TextStyle(
                                              color: Colors.black,
                                              fontSize: 20,
                                            ),
                                          ),
                                          SizedBox(width: 32, height: 15),
                                        ]),
                                    Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: <Widget>[
                                          Text(
                                            snapshot.data![3].dailyDt
                                                .toString(),
                                            style: new TextStyle(
                                              color: Colors.black,
                                              fontSize: 20.0,
                                            ),
                                          ),
                                          SizedBox(width: 32, height: 15),
                                          Flexible(
                                            child: Image.network(
                                                "https://openweathermap.org/img/w/${snapshot.data![3].dailyIcon}.png"),
                                          ), // give it width
                                          Text(
                                            snapshot.data![3].dailyTemp
                                                .toString(),
                                            style: new TextStyle(
                                              color: Colors.black,
                                              fontSize: 20,
                                            ),
                                          ),
                                          SizedBox(width: 32, height: 15),
                                        ]),
                                    Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: <Widget>[
                                          Text(
                                            snapshot.data![4].dailyDt
                                                .toString(),
                                            style: new TextStyle(
                                              color: Colors.black,
                                              fontSize: 20.0,
                                            ),
                                          ),
                                          SizedBox(width: 32, height: 15),
                                          Flexible(
                                            child: Image.network(
                                                "https://openweathermap.org/img/w/${snapshot.data![4].dailyIcon}.png"),
                                          ), // give it width
                                          Text(
                                            snapshot.data![4].dailyTemp
                                                .toString(),
                                            style: new TextStyle(
                                              color: Colors.black,
                                              fontSize: 20,
                                            ),
                                          ),
                                          SizedBox(width: 32, height: 15),
                                        ])
                                  ]);
                            });
                      }))
            ]));
  }
}
