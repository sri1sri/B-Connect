import 'package:bhavani_connect/common_widgets/offline_widgets/offline_widget.dart';
import 'package:bhavani_connect/common_variables/app_colors.dart';
import 'package:bhavani_connect/common_variables/app_fonts.dart';
import 'package:bhavani_connect/utilities/my_navigator.dart';
import 'package:flutter/material.dart';
import 'dart:async';

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: F_SplashScreen(),
    );
  }
}

class F_SplashScreen  extends StatefulWidget {
  @override
  _F_SplashScreenState createState() => _F_SplashScreenState();
}

class _F_SplashScreenState extends State<F_SplashScreen > {


    @override
    void initState() {
      // TODO: implement initState
      super.initState();

      Timer(Duration(seconds: 5),

              () => MyNavigator.goToIntro(context));

  }

    @override
    Widget build(BuildContext context) {
      return  Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
              color: backgroundColor,
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Expanded(
                flex: 2,
                child: Container(

                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[

                      Image.asset('images/22.JPG'),

                      Padding(
                        padding: EdgeInsets.only(top: 10.0),
                      ),

                    ],
                  ),
                ),
              ),
              Expanded(
                flex: 1,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    CircularProgressIndicator(
                      backgroundColor: Color(0xFF1F4B6E).withOpacity(0.7),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 20.0),
                    ),
                    Text(
                      'We Build for your Happiness',
                      textAlign: TextAlign.center,
                      style: activeSubTitleStyle,

                    ),
                  ],
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}