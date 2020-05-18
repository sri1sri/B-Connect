import 'package:bhavani_connect/auth/authentication_bloc.dart';
import 'package:bhavani_connect/authentication_screen/login_screens/login_page.dart';
import 'package:bhavani_connect/authentication_screen/login_screens/otp_page.dart';
import 'package:bhavani_connect/authentication_screen/login_screens/phone_number_page.dart';
import 'package:bhavani_connect/authentication_screen/registrtion_screens/sign_up_page.dart';
import 'package:bhavani_connect/filter/vehicle/filter_vehicle_bloc.dart';
import 'package:bhavani_connect/filter/vehicle/filter_vehicle_extras.dart';
import 'package:bhavani_connect/filter/vehicle/filter_vehicle_page.dart';
import 'package:bhavani_connect/filter/vehicle_result/vehicle_result_bloc.dart';
import 'package:bhavani_connect/filter/vehicle_result/vehicle_result_extras.dart';
import 'package:bhavani_connect/filter/vehicle_result/vehicle_result_page.dart';
import 'package:bhavani_connect/home_screens/Vehicle_Entry/list/vehicle_list_screen.dart';
import 'package:bhavani_connect/home_screens/home_page.dart';
import 'package:bhavani_connect/landing/landing_bloc.dart';
import 'package:bhavani_connect/landing/landing_extras.dart';
import 'package:bhavani_connect/landing/landing_page.dart';
import 'package:bhavani_connect/notification/notification_bloc.dart';
import 'package:bhavani_connect/notification/notification_extras.dart';
import 'package:bhavani_connect/notification/notification_page.dart';
import 'package:bhavani_connect/vehicle/add/add_vehicle_bloc.dart';
import 'package:bhavani_connect/vehicle/add/add_vehicle_extras.dart';
import 'package:bhavani_connect/vehicle/add/add_vehicle_page.dart';
import 'package:bhavani_connect/vehicle/detail/reading/vehicle_detail_reading_extras.dart'
    as detailVehicleReadingExtra;
import 'package:bhavani_connect/vehicle/detail/trip/vehicle_detail_trip_extras.dart'
    as detailVehicleTripExtra;
import 'package:bhavani_connect/vehicle/detail/reading/vehicle_detail_reading_bloc.dart';
import 'package:bhavani_connect/vehicle/detail/reading/vehicle_detail_reading_page.dart';
import 'package:bhavani_connect/vehicle/detail/trip/vehicle_detail_trip_bloc.dart';
import 'package:bhavani_connect/vehicle/detail/trip/vehicle_detail_trip_page.dart';
import 'package:bhavani_connect/vehicle/vehicle_bloc.dart';
import 'package:bhavani_connect/vehicle/vehicle_extras.dart';
import 'package:bhavani_connect/vehicle/vehicle_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

const String landingRoute = '/landing_page';
const String loginRoute = '/login';
const String signUpRoute = '/sign_up';
const String phoneNumberRoute = '/phone_number';
const String otpRoute = '/otp';
const String homeRoute = '/home';
const String vehicleRoute = '/vehicle';
const String addVehicleRoute = '/add_vehicle';
const String detailVehicleTripRoute = '/detail_vehicle_trip';
const String detailVehicleReadingRoute = '/detail_vehicle_reading';
const String filterVehicleRoute = '/filter_vehicle';
const String filterVehicleResultRoute = '/filter_vehicle_result';
const String notificationRoute = '/notification';

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
      case signUpRoute:
        final OtpArguments args = settings.arguments;
        return MaterialPageRoute(builder: (_) => SignUpPage(args.phoneNum));
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
            create: (_) => VehicleBloc(
                authenticationBloc: context.bloc<AuthenticationBloc>())
              ..add(LoadDataEvent()),
            child: VehiclePage(),
          ),
        );
      case addVehicleRoute:
        return MaterialPageRoute(
          builder: (context) => BlocProvider(
            create: (_) => AddVehicleBloc(
                authenticationBloc: context.bloc<AuthenticationBloc>())
              ..add(InitDataEvent()),
            child: AddVehiclePage(),
          ),
        );
      case detailVehicleTripRoute:
        final VehicleDetailArguments args = settings.arguments;
        return MaterialPageRoute(
          builder: (context) => BlocProvider(
            create: (_) => VehicleDetailTripBloc(
                authenticationBloc: context.bloc<AuthenticationBloc>())
              ..add(
                  detailVehicleTripExtra.InitDataEvent(vehicle: args.vehicle)),
            child: VehicleDetailTripPage(),
          ),
        );
      case detailVehicleReadingRoute:
        final VehicleDetailArguments args = settings.arguments;
        return MaterialPageRoute(
          builder: (context) => BlocProvider(
            create: (_) => VehicleDetailReadingBloc(
                authenticationBloc: context.bloc<AuthenticationBloc>())
              ..add(detailVehicleReadingExtra.InitDataEvent(
                  vehicle: args.vehicle)),
            child: VehicleDetailReadingPage(),
          ),
        );
      case filterVehicleRoute:
        return MaterialPageRoute(
          builder: (context) => BlocProvider(
            create: (_) => FilterVehicleBloc(
                authenticationBloc: context.bloc<AuthenticationBloc>())
              ..add(InitDataFilterVehicleEvent()),
            child: FilterVehiclePage(),
          ),
        );
      case filterVehicleResultRoute:
        final FilterVehicleResultArguments args = settings.arguments;
        return MaterialPageRoute(
          builder: (context) => BlocProvider(
            create: (_) => VehicleResultBloc(
                authenticationBloc: context.bloc<AuthenticationBloc>())
              ..add(InitDataVehicleResultEvent(
                  sellerName: args.sellerName,
                  siteName: args.siteName,
                  dateFrom: args.dateFrom,
                  dateTo: args.dateTo)),
            child: VehicleResultPage(),
          ),
        );
      case notificationRoute:
        return MaterialPageRoute(
          builder: (context) => BlocProvider(
            create: (_) => NotificationBloc(
                authenticationBloc: context.bloc<AuthenticationBloc>())
              ..add(InitDataNotification()),
            child: NotificationPage(),
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
