import 'package:brewbrah/brew_state.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sleek_circular_slider/sleek_circular_slider.dart';

class RatioSlider extends StatefulWidget {
  @override
  _RatioSliderState createState() => _RatioSliderState();
}

class _RatioSliderState extends State<RatioSlider> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Stack(
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
            ),
            child: SleekCircularSlider(
              appearance: CircularSliderAppearance(
                size: 200,
                startAngle: 135,
                angleRange: 270,
                customColors: CustomSliderColors(
                  dotColor: Colors.deepOrange,
                  progressBarColors: [
                    Colors.brown,
                    Colors.brown,
                    Colors.black,
                  ],
                  trackColor: Colors.grey,
                  shadowColor: Colors.brown,
                  hideShadow: true,
                ),
                customWidths: CustomSliderWidths(
                  handlerSize: 15,
                  progressBarWidth: 10,
                  trackWidth: 10,
                ),
                infoProperties: InfoProperties(
                  mainLabelStyle: TextStyle(fontSize: 70),
                  modifier: (value) => "${value.ceil()}",
                ),
              ),
              min: 1,
              max: 30,
              initialValue: 15,
              onChange: (value) {
                setState(() {
                  Provider.of<BrewState>(context).setRatio(value.ceil());
                });
              },
            ),
          ),
        ],
      ),
    );
  }
}
