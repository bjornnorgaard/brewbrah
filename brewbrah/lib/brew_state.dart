import 'package:flutter/material.dart';

class BrewState extends ChangeNotifier {
  int amount = 300;
  int ratio = 15;

  double get grounds => amount / ratio;

  void setAmount(int val) {
    amount = val;
    notifyListeners();
  }

  void setRatio(int val) {
    ratio = val;
    notifyListeners();
  }
}
