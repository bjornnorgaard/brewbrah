import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class CoffeePage extends StatefulWidget {
  @override
  _CoffeePageState createState() => _CoffeePageState();
}

class _CoffeePageState extends State<CoffeePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: <Widget>[
          Positioned(
            height: 250,
            left: 0,
            right: 0,
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.orange.withOpacity(0.8), Colors.deepOrange],
                  begin: Alignment.topRight,
                  end: Alignment.bottomLeft,
                ),
              ),
            ),
          ),
          Positioned(
            top: 200,
            height: 100,
            left: 0,
            right: 0,
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
            left: 0,
            right: 0,
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
            top: 247,
            left: 0,
            right: 0,
            bottom: 0,
            child: ClipPath(
              clipper: MyClipper(),
              child: Container(
                // color: Colors.white,
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                  colors: [Colors.grey.withOpacity(0.5), Colors.white.withOpacity(0.5)],
                  begin: Alignment.topRight,
                  end: Alignment.bottomLeft,
                )),
              ),
            ),
          ),
          Positioned(
            top: 250,
            left: 0,
            right: 0,
            bottom: 0,
            child: ClipPath(
              clipper: MyClipper(),
              child: Container(
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                  colors: [Colors.white, Colors.white],
                  begin: Alignment.topRight,
                  end: Alignment.bottomLeft,
                )),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class MyClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    path.lineTo(0, size.height);
    path.lineTo(size.width, size.height);
    path.lineTo(size.width, 0);
    path.quadraticBezierTo(size.width / 2, 100, 0, 0);

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return true;
  }
}
