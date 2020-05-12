import 'package:bhavani_connect/authentication_screen/login_screens/login_page.dart';
import 'package:bhavani_connect/authentication_screen/login_screens/otp_page.dart';
import 'package:bhavani_connect/authentication_screen/login_screens/phone_number_page.dart';
import 'package:bhavani_connect/home_screens/Vehicle_Entry/list/vehicle_list_screen.dart';
import 'package:bhavani_connect/home_screens/home_page.dart';
import 'package:bhavani_connect/landing_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

const String landingRoute = '/';
const String loginRoute = '/login';
const String phoneNumberRoute = '/phone_number';
const String otpRoute = '/otp';
const String homeRoute = '/home';
const String vehicleRoute = '/vehicle';

class Router {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case landingRoute:
        return MaterialPageRoute(builder: (_) => LandingPage());
      case loginRoute:
        return MaterialPageRoute(builder: (_) => LoginPage());
      case phoneNumberRoute:
        return MaterialPageRoute(builder: (_) => PhoneNumberPage());
      case otpRoute:
        final OtpArguments args = settings.arguments;
        return MaterialPageRoute(
          builder: (context) {
            return OTPPage(phoneNo: args.phoneNum, newUser: args.isNewUser);
          },
        );
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
