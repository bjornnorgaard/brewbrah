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
            // height: 250,
            bottom: 0,
            top: 0,
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
            bottom: 80,
            left: 60,
            child: AmountGaugeSlider(),
          ),
        ],
      ),
    );
  }
}

class AmountGaugeSlider extends StatefulWidget {
  final double height;

  AmountGaugeSlider({this.height = 350});

  @override
  _AmountGaugeSliderState createState() => _AmountGaugeSliderState();
}

class _AmountGaugeSliderState extends State<AmountGaugeSlider> {
  double _dragPosition = 0;
  double _dragPercentage = 0;

  void _updateDragPosition(Offset val) {
    double newDragPosition = 0;

    if (val.dy <= 0) {
      newDragPosition = 0;
    } else if (val.dy >= widget.height) {
      newDragPosition = widget.height;
    } else {
      newDragPosition = val.dy;
    }

    setState(() {
      _dragPosition = newDragPosition;
      _dragPercentage = (_dragPosition / widget.height - 1) * -1;
    });
  }

  void _onDragStart(BuildContext context, DragStartDetails start) {
    RenderBox box = context.findRenderObject();
    Offset offset = box.globalToLocal(start.globalPosition);
    _updateDragPosition(offset);
  }

  void _onDragUpdate(BuildContext context, DragUpdateDetails update) {
    RenderBox box = context.findRenderObject();
    Offset offset = box.globalToLocal(update.globalPosition);
    _updateDragPosition(offset);
  }

  void _onDragEnd(BuildContext context, DragEndDetails update) {
    setState(() {
      // Something...
    });
  }

  @override
  Widget build(BuildContext context) {
    return Transform(
      transform: Matrix4.skewY(0.175),
      child: GestureDetector(
        onVerticalDragUpdate: (update) => _onDragUpdate(context, update),
        onVerticalDragStart: (start) => _onDragStart(context, start),
        onVerticalDragEnd: (end) => _onDragEnd(context, end),
        child: Container(
          height: 320,
          width: 60,
          child: Text(
            "${(_dragPercentage * 1000).toStringAsFixed(0)}\ngram",
            style: TextStyle(fontSize: 30, color: Colors.grey),
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            gradient: LinearGradient(
              colors: [Colors.brown, Colors.black87],
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
            ),
          ),
        ),
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
