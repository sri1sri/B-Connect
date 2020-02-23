import 'package:flutter/material.dart';

class StepTwoView extends StatefulWidget {
  StepTwoView({Key key}) : super(key: key);

  @override
  _StepTwoViewState createState() => _StepTwoViewState();
}

class _StepTwoViewState extends State<StepTwoView>{
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
