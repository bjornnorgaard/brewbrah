import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class FancyCalculator extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _FancyCalculatorState();

}

class _FancyCalculatorState extends State<FancyCalculator> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text("Hello World"),
      ),
    );
  }
}