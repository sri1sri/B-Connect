import 'dart:async';
import 'package:bhavani_connect/authentication_screen/login_screens/otp_page.dart';
import 'package:bhavani_connect/config/router.dart';
import 'package:bhavani_connect/firebase/auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import './bloc.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  final AuthFirebase _authFirebase;

  final GlobalKey<NavigatorState> _navigatorKey;

  AuthenticationBloc(this._authFirebase, this._navigatorKey);

  @override
  AuthenticationState get initialState => InitialAuthenticationState();

  void gotoLoginPage() {
    _navigatorKey.currentState.pushNamed(loginRoute);
  }

  void gotoPhoneNumberPage() {
    _navigatorKey.currentState.pushNamed(phoneNumberRoute);
  }

  void gotoOtpPage({String phoneNumber, bool isNewUser}) {
    _navigatorKey.currentState.pushNamed(otpRoute,
        arguments: OtpArguments(phoneNum: phoneNumber, isNewUser: isNewUser));
  }

  @override
  Stream<AuthenticationState> mapEventToState(
    AuthenticationEvent event,
  ) async* {
    if (event is AppStarted) {
      final bool hasToken = await _authFirebase.firebaseUser() != null;

      if (hasToken) {
        yield Authenticated();
      } else {
        yield Unauthenticated();
      }
    }

    if (event is LoggedIn) {
      yield Loading();
      yield Authenticated();
    }

    if (event is LoggedOut) {
      yield Loading();
      yield Unauthenticated();
    }
  }
}
