import 'package:brewbrah/brew_state.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AmountSlider extends StatefulWidget {
  @override
  _AmountSliderState createState() => _AmountSliderState();
}

class _AmountSliderState extends State<AmountSlider> {
  @override
  Widget build(BuildContext context) {
    return RotatedBox(
      quarterTurns: 3,
      child: Stack(
        overflow: Overflow.visible,
        children: <Widget>[
          SliderTheme(
            data: SliderTheme.of(context).copyWith(
              thumbColor: Colors.deepOrange,
              inactiveTrackColor: Colors.grey,
              activeTrackColor: Colors.black,
              trackHeight: 10,
              disabledActiveTrackColor: Colors.blue,
              overlayColor: Colors.transparent,
              thumbShape: RoundSliderThumbShape(
                enabledThumbRadius: 15,
                disabledThumbRadius: 0,
              ),
            ),
            child: Slider(
              min: 0,
              max: 1000,
              divisions: 40,
              value: Provider
                  .of<BrewState>(context)
                  .amount
                  .toDouble(),
              onChanged: (value) =>
                  setState(
                        () => Provider.of<BrewState>(context).setAmount(value.toInt()),
                  ),
            ),
          ),
          SliderMarker(text: "300", bottom: -20, left: 122),
          SliderMarker(text: "600", bottom: -20, left: 227),
          SliderMarker(text: "900", bottom: -20, left: 333),
        ],
      ),
    );
  }
}

class SliderMarker extends StatelessWidget {
  final String text;
  final double bottom;
  final double left;

  SliderMarker({
    @required this.text,
    @required this.bottom,
    @required this.left,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: bottom,
      left: left,
      child: RotatedBox(
        quarterTurns: 1,
        child: Text(
          text,
          style: TextStyle(
            color: Colors.black38,
          ),
        ),
      ),
    );
  }
}
