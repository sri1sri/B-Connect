import 'package:bhavani_connect/landing_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'authentication_screen/login_screens/login_page.dart';
import 'package:bhavani_connect/authentication_screen/splash_screens/splash_sceen.dart';
import 'package:bhavani_connect/authentication_screen/splash_screens/onboarding_screen.dart';

import 'firebase/auth.dart';

//var routes = <String, WidgetBuilder>{
//  "/login": (BuildContext context) => LoginPage(),
//  "/intro": (BuildContext context) => OnboardingScreen(),
//};

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Provider<AuthBase>(
      create: (context) => Auth(),
      child: MaterialApp(
        title: 'B-Connect',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        debugShowCheckedModeBanner: false,
        home: LandingPage(),
          //routes: routes
      ),
    );
  }//ughsX
}




