import 'package:flutter/cupertino.dart';


class OfflinePage extends CustomOfflinePage{
  OfflinePage({
    @required String text,
  }) : assert(text != null),
        super(
        text: text,
      );
}

class CustomOfflinePage extends StatelessWidget {

  CustomOfflinePage({this.text});

  final text;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(text),
    );
  }
}