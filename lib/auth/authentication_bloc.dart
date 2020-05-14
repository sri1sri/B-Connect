import 'dart:async';
import 'package:bhavani_connect/authentication_screen/login_screens/otp_page.dart';
import 'package:bhavani_connect/config/router.dart';
import 'package:bhavani_connect/firebase/auth.dart';
import 'package:bhavani_connect/firebase/database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import './bloc.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  final AuthFirebase authFirebase;

  final GlobalKey<NavigatorState> _navigatorKey;

  FirestoreDatabase fireStoreDatabase;

  AuthenticationBloc(this.authFirebase, this._navigatorKey);

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

  void gotoHomePage() {
    _navigatorKey.currentState.pushNamed(homeRoute);
  }

  void gotoLandingPage() {
    _navigatorKey.currentState.pushNamed(landingRoute);
  }

  @override
  Stream<AuthenticationState> mapEventToState(
    AuthenticationEvent event,
  ) async* {
    if (event is AppStarted) {
      final bool hasToken = await authFirebase.firebaseUser() != null;

      if (hasToken) {
        gotoLandingPage();
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

    if (event is SubmitPhoneNumber) {
      yield PhoneNumberLoading();
      await authFirebase.verifyPhoneNumber(event.phoneNumber);
      yield PhoneNumberVerified(phoneNumber: event.phoneNumber, isNewUser: event.isNewUser);
    }

    if (event is SubmitOpt) {
      yield OtpStateLoading();
      await authFirebase.verifyOtp(event.otp);
      yield OtpVerified();
    }
  }

  void signOut() => authFirebase.signOut();

//  Future<void> verifyOtp() async {
//    try {
//      widget.phoneNo == '8333876209' ? EMPLOYEE_PNO = widget.phoneNo : '';
//      print('otp${widget.newUser}');
//      if (widget.newUser) {
//        await _submit();
//        GoToPage(context, SignUpPage(phoneNo: widget.phoneNo));
//      } else {
//        await _submit();
//        GoToPage(context, LandingPage());
//      }
//    } on PlatformException catch (e) {
//      PlatformExceptionAlertDialog(
//        title: 'Otp Verification failed',
//        exception: e,
//      ).show(context);
//    }
//  }
}
