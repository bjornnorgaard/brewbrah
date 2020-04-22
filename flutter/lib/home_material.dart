import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomeMaterial extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => HomeMaterialState();
}

class HomeMaterialState extends State<HomeMaterial> {
  int desiredAmount;
  int ratio ;

  @override
  void initState() {
    super.initState();
    desiredAmount = 1000;
    ratio = 17;
  }

  void desiredAmountUpdated(newValue) {
    setState(() {
      if (newValue != 0) {
        desiredAmount = newValue;
      }
    });
  }

  void ratioUpdated(newValue) {
    setState(() {
      if (newValue != 0) {
        ratio = newValue;
      }
    });
  }

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
                BrewForm(
                    desiredAmount, desiredAmountUpdated, ratio, ratioUpdated),
                Card(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 20, bottom: 25),
                    child: Center(
                      child: Column(
                        children: <Widget>[
                          Text(
                            "You will need",
                            style: TextStyle(fontSize: 30, letterSpacing: 3),
                          ),
                          Text(
                            "${(desiredAmount / ratio).toStringAsFixed(1)}g",
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
  int desiredAmount = 1000;
  int ratio = 15;

  Function(int) desiredAmountUpdated;

  Function(int) ratioUpdated;

  BrewForm(this.desiredAmount, this.desiredAmountUpdated, this.ratio,
      this.ratioUpdated);

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
                  border: InputBorder.none,
                  labelText: "How much coffee are we making?",
                  hintText: "1000 is four big cups",
                  suffixText: "grams",
                  prefixIcon: Icon(
                    Icons.local_cafe,
                  ),
                ),
                keyboardType: TextInputType.number,
                initialValue: "1000",
                onChanged: (value) {
                  widget.desiredAmountUpdated(int.parse(value));
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
                initialValue: "17",
                onChanged: (value) {
                  widget.ratioUpdated(int.parse(value));
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
