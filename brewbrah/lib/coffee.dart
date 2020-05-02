import 'package:brewbrah/amout_gauge_slider.dart';
import 'package:brewbrah/ratio_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class Coffee extends StatefulWidget {
  @override
  _CoffeeState createState() => _CoffeeState();
}

class _CoffeeState extends State<Coffee> {
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
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Colors.orangeAccent,
                    Colors.deepOrange,
                  ],
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
                decoration: BoxDecoration(
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
                decoration: BoxDecoration(
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
          Positioned(
            bottom: 50,
            left: 50,
            height: 400,
            child: AmountGaugeSlider(),
          ),
          Positioned(
            bottom: 40,
            right: 40,
            child: Transform(
              transform: Matrix4.skewY(-0.07),
              child: RatioSlider(),
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
