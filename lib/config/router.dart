import 'package:bhavani_connect/authentication_screen/login_screens/login_page.dart';
import 'package:bhavani_connect/home_screens/Vehicle_Entry/list/vehicle_list_screen.dart';
import 'package:bhavani_connect/home_screens/home_page.dart';
import 'package:bhavani_connect/landing_page.dart';
import 'package:flutter/material.dart';

const String landingRoute = '/';
const String loginRoute = '/login';
const String homeRoute = '/home';
const String vehicleRoute = '/vehicle';

class Router {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case landingRoute:
        return MaterialPageRoute(builder: (_) => LandingPage());
      case loginRoute:
        return MaterialPageRoute(builder: (_) => LoginPage());
      case homeRoute:
        return MaterialPageRoute(builder: (_) => HomePage());
      case vehicleRoute:
        return MaterialPageRoute(builder: (_) => VehicleListScreen());
      default:
        return MaterialPageRoute(
            builder: (_) => Scaffold(
              body: Center(
                  child: Text('No route defined for ${settings.name}')),
            ));
    }
  }
}
