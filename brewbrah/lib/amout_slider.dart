import 'package:brewbrah/brew_state.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AmountSlider extends StatefulWidget {
  const AmountSlider({super.key});

  @override
  AmountSliderState createState() => AmountSliderState();
}

class AmountSliderState extends State<AmountSlider> {
  @override
  Widget build(BuildContext context) {
    return RotatedBox(
      quarterTurns: 3,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          SliderTheme(
            data: SliderTheme.of(context).copyWith(
              thumbColor: Colors.deepOrange,
              inactiveTrackColor: Colors.grey,
              activeTrackColor: Colors.black,
              trackHeight: 10,
              disabledActiveTrackColor: Colors.blue,
              overlayColor: Colors.transparent,
              thumbShape: const RoundSliderThumbShape(
                enabledThumbRadius: 15,
                disabledThumbRadius: 0,
              ),
            ),
            child: Slider(
              min: 0,
              max: 1000,
              divisions: 40,
              value: Provider.of<BrewState>(context, listen: false)
                  .amount
                  .toDouble(),
              onChanged: (value) => setState(
                () => Provider.of<BrewState>(context, listen: false).setAmount(
                  value.toInt(),
                ),
              ),
            ),
          ),
          const SliderMarker(text: "300", bottom: -25, left: 137),
          const SliderMarker(text: "600", bottom: -25, left: 257),
          const SliderMarker(text: "900", bottom: -25, left: 380),
        ],
      ),
    );
  }
}

class SliderMarker extends StatelessWidget {
  final String text;
  final double bottom;
  final double left;

  const SliderMarker({
    super.key,
    required this.text,
    required this.bottom,
    required this.left,
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
          style: const TextStyle(
            color: Colors.black38,
          ),
        ),
      ),
    );
  }
}
