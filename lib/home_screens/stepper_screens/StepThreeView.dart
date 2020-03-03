import 'package:flutter/material.dart';

class StepThreeView extends StatefulWidget {
  StepThreeView({Key key}) : super(key: key);

  @override
  _StepThreeViewState createState() => _StepThreeViewState();
}

class _StepThreeViewState extends State<StepThreeView>{
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        children: <Widget>[
          new TextFormField(
            decoration: const InputDecoration(labelText: 'Text 1'),
            keyboardType: TextInputType.number,
          ),
          new TextFormField(
            decoration: const InputDecoration(labelText: 'Text 2'),
            keyboardType: TextInputType.number,
          ),

        ],
      ),
    );
  }
}
