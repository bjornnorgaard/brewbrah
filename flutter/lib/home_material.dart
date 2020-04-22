import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomeMaterial extends StatelessWidget {
  var desiredAmount = 0;
  var ratio = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(25.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Center(
                  child: Text("Brew Brah", style: TextStyle(fontSize: 50)),
                ),
                BrewForm(),
                Card(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 20, bottom: 25),
                    child: Center(
                      child: Column(
                        // mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            "You will need",
                            style: TextStyle(fontSize: 30, letterSpacing: 3),
                          ),
                          Text(
                            "60g",
                            style: TextStyle(fontSize: 80),
                          ),
                          Text(
                            "of good coffee",
                            style: TextStyle(fontSize: 25, letterSpacing: 10),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                // GoToGithubButton()
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class GoToGithubButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      onPressed: () => print("Go to source"),
      onLongPress: () => print("Go to long source"),
      color: Colors.white,
      textColor: Colors.blue,
      child: Text("View source on Github"),
    );
  }
}

class BrewForm extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _BrewFormState();
}

class _BrewFormState extends State<BrewForm> {
  var _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              TextFormField(
                decoration: InputDecoration(
                  labelText: "How much coffee are we making?",
                  hintText: "1000 is four big cups",
                  suffixText: "grams",
                  prefixIcon: Icon(Icons.local_cafe),
                  border: InputBorder.none,
                ),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value.isEmpty) {
                    return "Enter something dammit";
                  }
                  return null;
                },
              ),
              TextFormField(
                decoration: InputDecoration(
                  labelText: "What ratio do you like?",
                  hintText: "15 is a normal cup",
                  suffixText: "water/grounds",
                  prefixIcon: Icon(Icons.group_work),
                  border: InputBorder.none,
                ),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value.isEmpty) {
                    return "Enter something dammit";
                  }
                  return null;
                },
              ),
              Padding(
                padding: const EdgeInsets.all(10),
                child: RaisedButton.icon(
                  onPressed: () => print("go form"),
                  icon: Icon(Icons.sort),
                  label: Text("Go"),
                  color: Colors.blue,
                  textColor: Colors.white,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
