import 'package:flutter/material.dart';

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
    return GestureDetector(
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
    );
  }
}
