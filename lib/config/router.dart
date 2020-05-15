import 'package:bhavani_connect/auth/authentication_bloc.dart';
import 'package:bhavani_connect/authentication_screen/login_screens/login_page.dart';
import 'package:bhavani_connect/authentication_screen/login_screens/otp_page.dart';
import 'package:bhavani_connect/authentication_screen/login_screens/phone_number_page.dart';
import 'package:bhavani_connect/home_screens/Vehicle_Entry/list/vehicle_list_screen.dart';
import 'package:bhavani_connect/home_screens/home_page.dart';
import 'package:bhavani_connect/landing/landing_bloc.dart';
import 'package:bhavani_connect/landing/landing_extras.dart';
import 'package:bhavani_connect/landing/landing_page.dart';
import 'package:bhavani_connect/vehicle/add/add_vehicle_bloc.dart';
import 'package:bhavani_connect/vehicle/add/add_vehicle_extras.dart';
import 'package:bhavani_connect/vehicle/add/add_vehicle_page.dart';
import 'package:bhavani_connect/vehicle/vehicle_bloc.dart';
import 'package:bhavani_connect/vehicle/vehicle_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

const String landingRoute = '/landing_page';
const String loginRoute = '/login';
const String phoneNumberRoute = '/phone_number';
const String otpRoute = '/otp';
const String homeRoute = '/home';
const String vehicleRoute = '/vehicle';
const String addVehicleRoute = '/add_vehicle';

class Router {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case landingRoute:
        return MaterialPageRoute(
          builder: (context) => BlocProvider(
            create: (_) => LandingBloc(bloc: context.bloc<AuthenticationBloc>())
              ..add(LandingInitData()),
            child: LandingPage(),
          ),
        );
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
        return MaterialPageRoute(
          builder: (context) => BlocProvider(
            create: (_) => VehicleBloc(),
            child: VehiclePage(),
          ),
        );
      case addVehicleRoute:
        return MaterialPageRoute(
          builder: (context) => BlocProvider(
            create: (_) => AddVehicleBloc(authenticationBloc: context.bloc<AuthenticationBloc>())..add(InitDataEvent()),
            child: AddVehiclePage(),
          ),
        );
      default:
        return MaterialPageRoute(
            builder: (_) => Scaffold(
                  body: Center(
                      child: Text('No route defined for ${settings.name}')),
                ));
    }
  }
}
