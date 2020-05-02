import 'package:flutter/material.dart';
import 'package:sleek_circular_slider/sleek_circular_slider.dart';

class RatioSlider extends StatefulWidget {
  @override
  _RatioSliderState createState() => _RatioSliderState();
}

class _RatioSliderState extends State<RatioSlider> {
  double _currentRatio = 14;

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
                  progressBarWidth: 20,
                  trackWidth: 18,
                ),
                infoProperties: InfoProperties(
                  mainLabelStyle: TextStyle(fontSize: 70),
                  modifier: (value) => "${value.ceil()}",
                ),
              ),
              min: 1,
              max: 30,
              initialValue: 14,
              onChange: (value) {
                setState(() {
                  _currentRatio = value;
                });
              },
            ),
          ),
        ],
      ),
    );
  }
}
