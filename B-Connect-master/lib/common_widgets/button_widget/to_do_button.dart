import 'package:flutter/cupertino.dart';
import 'custom_raised_button.dart';

class ToDoButton extends CustomRaisedButton{
  ToDoButton({
    @required String assetName,
    @required String text,
    Color backgroundColor,
    Color textColor,
    VoidCallback onPressed,
  }) :  assert(assetName != null),
        assert(text != null),
        super(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Image.asset(assetName),
            Text(text,
              style: TextStyle(fontSize: 19, fontWeight: FontWeight.w600,fontFamily: 'Quicksand'),
            ),
            Opacity(
              opacity: 0.0,
              child: Image.asset(assetName),
            )
          ],
        ),
        color: backgroundColor,
        textColor: textColor,
        onPressed: onPressed,
      );
}