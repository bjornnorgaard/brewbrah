import 'package:brewbrah/screens/fancy_calculator.dart';
import 'package:brewbrah/screens/home_material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() => runApp(App());

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: "/",
      routes: {
        //"/": (context) => HomeMaterial(),
        "/fancy": (context) => FancyCalculator(),
      },
      title: "Brewbrah",
      home: HomeMaterial(),
    );
  }
}
