import 'package:brewbrah/brew_state.dart';
import 'package:brewbrah/coffee.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => BrewState(),
      child: MaterialApp(
        title: 'Brewbrah',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
            fontFamily: "Raleway"
        ),
        home: Coffee(),
      ),
    );
  }
}
