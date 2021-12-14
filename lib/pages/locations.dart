import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../weatherIntegration.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class locations extends StatefulWidget {
  final data;

  locations({Key? key, this.data}) : super(key: key);

  @override
  _locationsState createState() => _locationsState();
}

class _locationsState extends State<locations> {
  invalidCityName() async {
    return Fluttertoast.showToast(
      msg: "Invalid city name!",
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.BOTTOM,
    );
  }

  var appBarColor = Color(0x00000000);
  TextEditingController weatherLocationController =
      TextEditingController(text: "");
  weatherIntegration addLocations = new weatherIntegration();

  _addItemToList(weatherData, city) async {
    if (!weatherData.map((weatherObj) => weatherObj.city).contains(city)) {
      List<weather> tempList = weatherData;
      try {
        basicWeatherInfo weatherInfoObj =
            await addLocations.generateBasicWeatherInfo(city.toString());
        String cityName = weatherInfoObj.areaName;
        String latitude = weatherInfoObj.latitude;
        String longitude = weatherInfoObj.longitude;
        tempList.add(new weather(cityName, latitude, longitude));
        addLocation(cityName, latitude, longitude);
        setState(() {
          weatherData =
              tempList; // this will trigger a rebuild of the ENTIRE widget, therefore adding our new item to the list!
        });
      } catch (e) {
        print(e);
        return invalidCityName();
      }
    }
  }

  addLocation(city, latitude, longitude) {
    http.post(
      Uri.parse('http://34.66.241.147:8080/api/location'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'city': city,
        'longitude': longitude,
        'latitude': latitude
      }),
    );
  }

  Widget build(BuildContext context) {
    List<weather> weatherData = widget.data;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Color(0xff00CC00),
      appBar: AppBar(
        title: Text('Locations'),
        backgroundColor: Color(0xff00CC00),
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context, weatherData),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Container(
            alignment: Alignment.center,
            height: 50,
            width: 300,
            margin: const EdgeInsets.fromLTRB(20, 20, 20, 25),
            padding: EdgeInsets.symmetric(horizontal: 20),
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(10)),
            child: TextFormField(
              controller: weatherLocationController,
              decoration: InputDecoration.collapsed(hintText: "Add a city..."),
            ),
          ),

          FloatingActionButton(
            onPressed: () {
              print("fab clicked");
              _addItemToList(
                  weatherData, weatherLocationController.text); // new method
            },
            child: Text("+"),
            backgroundColor: Colors.blue,
          ),
          Container(
              padding: EdgeInsets.fromLTRB(20, 40, 20, 20),
              child: Text(
                "Click City Name Below ",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontStyle: FontStyle.italic,
                    fontWeight: FontWeight.w700),
              )),

          //NOTE: Todo List
          Expanded(
              child: ListView(
            padding: EdgeInsets.all(12.0),
            children: weatherData.map(
              (data) {
                return ListTile(
                    title: Text(data.city),
                    onTap: () {
                      var mainCity = data;
                      weatherData.remove(mainCity);
                      weatherData.insert(0, mainCity);
                      Navigator.pop(context, weatherData);
                    });
              },
            ).toList(),
          ))
        ],
      ),
    );
  }
}
