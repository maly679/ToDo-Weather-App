import 'package:flutter/material.dart';
import 'package:weather/weather.dart';
import './weatherIntegration.dart';
import './topWeather.dart';

void main() async => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
     return  MaterialApp(
         home:Scaffold (
      body: new Stack(
          children: <Widget>[
      new Container(
      decoration: new BoxDecoration(
      image: new DecorationImage(image: new AssetImage("assets/images/background.png"), fit: BoxFit.cover,),
    ),
    ),
    new Center(

    child: new Column(children: <Widget>[
        Row(
        //ROW 1
        children: [
        Container(
    padding: EdgeInsets.all(16.0),

        child:
         new topWeather()

        ),
    ]),
    Row(//ROW 2
    children: [
    Container(

        child:
       new weatherIntegration()

    ),

    ]) ]))])) );
  }
}