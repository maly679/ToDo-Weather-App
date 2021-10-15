import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:weather/weather.dart';

class topWeather extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    return Container(

      padding: const EdgeInsets.all(8.0),
      color: Colors.blue[600],
      alignment: Alignment.center,
      child: Text('Hello World',
          style: Theme.of(context)
              .textTheme
              .headline4!
              .copyWith(color: Colors.white)),
      transform: Matrix4.rotationZ(0.1),
    );
  

  }


}