import 'package:bhavani_connect/authentication_screen/login_screens/login_page.dart';
import 'package:bhavani_connect/authentication_screen/splash_screens/onboarding_screen.dart';
import 'package:bhavani_connect/base/app_bloc_delegate.dart';
import 'package:bhavani_connect/home_screens/home_page.dart';
import 'package:bhavani_connect/landing/landing_bloc.dart';
import 'package:bhavani_connect/landing/landing_extras.dart';
import 'package:bhavani_connect/landing/landing_page.dart';
import 'package:bhavani_connect/splash_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'auth/authentication_bloc.dart';
import 'auth/bloc.dart';
import 'config/router.dart';
import 'firebase/auth.dart';

void main() {
  final GlobalKey<NavigatorState> _navigatorKey = GlobalKey();
  BlocSupervisor.delegate = AppBlocDelegate();
  WidgetsFlutterBinding.ensureInitialized();
  AuthFirebase authFirebase = AuthFirebase();
  runApp(BlocProvider(
    create: (context) =>
        AuthenticationBloc(authFirebase, _navigatorKey)..add(AppStarted()),
    child: MyApp(navigatorKey: _navigatorKey),
  ));
}

Future<dynamic> myBackgroundMessageHandler(Map<String, dynamic> message) {
  if (message.containsKey('data')) {
    // Handle data message
    final dynamic data = message['data'];
  }

  if (message.containsKey('notification')) {
    // Handle notification message
    final dynamic notification = message['notification'];
  }

  // Or do other work.
}

class MyApp extends StatefulWidget {
  final GlobalKey<NavigatorState> navigatorKey;

  MyApp({this.navigatorKey});

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'B-Connect',
      theme: ThemeData(
        primarySwatch: Colors.blueGrey,
      ),
      debugShowCheckedModeBanner: false,
      navigatorKey: widget.navigatorKey,
      onGenerateRoute: Router.generateRoute,
      home: BlocBuilder<AuthenticationBloc, AuthenticationState>(
          builder: (context, state) {
        if (state is Uninitialized) {
          return OnboardingScreen();
        } else if (state is Unauthenticated) {
          return LoginPage();
        } else {
          return SplashPage();
        }
      }),
    );
  }
}
