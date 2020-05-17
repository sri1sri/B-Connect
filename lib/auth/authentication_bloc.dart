import 'dart:async';
import 'package:bhavani_connect/authentication_screen/login_screens/otp_page.dart';
import 'package:bhavani_connect/config/router.dart';
import 'package:bhavani_connect/database_model/vehicle_model.dart';
import 'package:bhavani_connect/database_model/vehicle_type.dart';
import 'package:bhavani_connect/filter/vehicle_result/vehicle_result_extras.dart'
    as vehicleResultExtra;
import 'package:bhavani_connect/firebase/auth.dart';
import 'package:bhavani_connect/firebase/database.dart';
import 'package:bhavani_connect/vehicle/vehicle_extras.dart' as vehicleExtra;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
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
    _navigatorKey.currentState.pushReplacementNamed(homeRoute);
  }

  void gotoLandingPage() {
    _navigatorKey.currentState.pushReplacementNamed(landingRoute);
  }

  void gotoVehicle() {
    _navigatorKey.currentState.pushNamed(vehicleRoute);
  }

  void gotoAddVehicle() {
    _navigatorKey.currentState.pushNamed(addVehicleRoute);
  }

  void gotoVehicleResult(
      {String sellerName,
      String siteName,
      DateTime dateFrom,
      DateTime dateTo}) {
    vehicleResultExtra.FilterVehicleResultArguments arguments =
        vehicleResultExtra.FilterVehicleResultArguments(
      sellerName: sellerName,
      siteName: siteName,
      dateFrom: Timestamp.fromDate(dateFrom),
      dateTo: Timestamp.fromDate(dateTo),
    );
    _navigatorKey.currentState
        .pushNamed(filterVehicleResultRoute, arguments: arguments);
  }

  void gotoVehicleDetail({Vehicle vehicle}) {
    switch (vehicle.vehicleTypeId) {
      case VehicleType.vehicleTypeTrip:
        _navigatorKey.currentState.pushNamed(detailVehicleTripRoute,
            arguments: vehicleExtra.VehicleDetailArguments(vehicle: vehicle));
        break;
      default:
        _navigatorKey.currentState.pushNamed(detailVehicleReadingRoute,
            arguments: vehicleExtra.VehicleDetailArguments(vehicle: vehicle));
        break;
    }
  }

  void gotoFilterVehicle() {
    _navigatorKey.currentState.pushNamed(filterVehicleRoute);
  }

  void gotoNotification() {
    _navigatorKey.currentState.pushNamed(notificationRoute);
  }

  void pop() {
    _navigatorKey.currentState.pop();
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
      yield PhoneNumberVerified(
          phoneNumber: event.phoneNumber, isNewUser: event.isNewUser);
    }

    if (event is SubmitOpt) {
      yield OtpStateLoading();
      await authFirebase.verifyOtp(event.otp);
      yield OtpVerified();
    }
  }

  void signOut() => authFirebase.signOut();

  void saveFirebaseToken() async {
    String token = await FirebaseMessaging().getToken();
    fireStoreDatabase.currentUserDetails().listen((event) {
      event.firebaseToken = token;
      fireStoreDatabase.updateEmployeeDetails(event, event.employeeID);
    });
  }
}
