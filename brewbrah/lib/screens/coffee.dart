import 'package:brewbrah/amout_slider.dart';
import 'package:brewbrah/brew_state.dart';
import 'package:brewbrah/ratio_slider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Coffee extends StatefulWidget {
  const Coffee({super.key});

  @override
  CoffeeState createState() => CoffeeState();
}

class CoffeeState extends State<Coffee> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: <Widget>[
          Positioned(
            bottom: 0,
            top: 0,
            left: 0,
            right: 0,
            child: Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.orangeAccent, Colors.deepOrange],
                  begin: Alignment.topRight,
                  end: Alignment.centerLeft,
                ),
              ),
            ),
          ),
          Positioned(
            top: 200,
            height: 100,
            left: 5,
            right: 5,
            child: ClipOval(
              child: Container(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Colors.grey, Colors.white],
                    begin: Alignment.topRight,
                    end: Alignment.bottomLeft,
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            top: 250,
            height: 100,
            left: 5,
            right: 5,
            child: ClipOval(
              child: Container(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Colors.black, Colors.brown],
                    begin: Alignment.topRight,
                    end: Alignment.bottomLeft,
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            top: 250,
            left: 5,
            right: 5,
            bottom: 0,
            child: ClipPath(
              clipper: CupEdgeClipper(),
              child: Container(
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                  colors: [
                    Colors.white,
                    Colors.grey.shade400,
                  ],
                  begin: Alignment.topRight,
                  end: Alignment.bottomLeft,
                )),
              ),
            ),
          ),
          const Positioned(
            bottom: 50,
            left: 30,
            height: 450,
            child: AmountSlider(),
          ),
          const Positioned(
            bottom: 45,
            right: 60,
            child: RatioSlider(),
          ),
          Positioned(
            top: 400,
            right: 55,
            child: Consumer<BrewState>(
              builder: (context, brew, child) {
                return Column(
                  children: <Widget>[
                    Text(
                      "${brew.amount} divided by ${brew.ratio} is",
                      style: const TextStyle(fontSize: 20, color: Colors.grey),
                    ),
                    Text(
                      brew.grounds.toStringAsFixed(1),
                      style: const TextStyle(
                        fontSize: 90,
                      ),
                    ),
                    const Text(
                      "grams of good coffee",
                      style: TextStyle(fontSize: 20, color: Colors.grey),
                    ),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class CupEdgeClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    path.lineTo(0, size.height);
    path.lineTo(size.width, size.height);
    path.lineTo(size.width, 0);
    path.lineTo(0, 0);
    path.addOval(Rect.fromLTWH(0, -50, size.width, 100));
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return false;
  }
}
