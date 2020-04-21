import 'package:brewbrah/screens/fancy_calculator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class HomeMaterial extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _HomeMaterialState();
}

class _HomeMaterialState extends State<HomeMaterial> {
  static var _desiredAmount = 1000;
  static var _ratio = 15.0;
  static var _beans = _desiredAmount / _ratio;

  int _cIndex = 0;

  void _incrementTab(index) {
    setState(() {
      _cIndex = index;
      if (index == 0) {
        Navigator.pushNamed(context, "/fancy");
      }
      else {
        Navigator.pushNamed(context, "/");
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Brewbrah"),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.fastfood),
            title: Text("Normal"),
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.fastfood), title: Text("Fancy"))
        ],
        onTap: (index) {
          _incrementTab(index);
        },
      ),
      body: Container(
        padding: EdgeInsets.all(20.0),
        child: Column(
          children: <Widget>[
            TextFormField(
              decoration: InputDecoration(
                labelText: "How much coffee are we making?",
                hintText: "Something in grams, like 1000",
              ),
              keyboardType: TextInputType.number,
              initialValue: _desiredAmount.toString(),
              onChanged: (value) {
                print(value);
              },
            ),
            TextFormField(
              decoration: InputDecoration(
                labelText: "What ratio do you like?",
                hintText: "Usually 16, below 13 is a strong cup...",
              ),
              keyboardType: TextInputType.number,
            ),
            Container(
              padding: EdgeInsets.only(top: 50.0),
            ),
            Text(
              "You'll need",
              style: TextStyle(
                  letterSpacing: 5.0,
                  fontSize: 40.0,
                  fontWeight: FontWeight.bold),
            ),
            Text(
              "58.8",
              style: TextStyle(fontSize: 60.0, fontWeight: FontWeight.bold),
            ),
            Text(
              "grams of coffee",
              style: TextStyle(
                  letterSpacing: 4.0,
                  fontSize: 30.0,
                  fontWeight: FontWeight.bold),
            )
          ],
        ),
      ),
    );
  }
}
