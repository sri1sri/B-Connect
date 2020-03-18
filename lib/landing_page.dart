import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'authentication_screen/splash_screens/onboarding_screen.dart';
import 'common_variables/app_functions.dart';
import 'firebase/auth.dart';
import 'firebase/database.dart';
import 'home_screens/home_page.dart';

class LandingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<AuthBase>(context, listen: false);

    return StreamBuilder<User>(
      stream: auth.onAuthStateChanges,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.active) {
          User user = snapshot.data;
//          if (user == null) {
//            return OnboardingScreen(context: context);
//          }
          return Provider<User>.value(
            value: user,
            child: Provider<Database>(
                create: (_) => FirestoreDatabase(uid: EMPLOYEE_ID = 'PMoedmkIxPZSIk41vGrPGGUilR72'),
                child: HomePage()),
          );

        } else {
          return Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }
      },
    );
  }
}


