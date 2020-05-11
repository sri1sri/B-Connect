import 'dart:async';
import 'package:bhavani_connect/config/router.dart';
import 'package:bhavani_connect/firebase/auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import './bloc.dart';

class AuthenticationBloc extends Bloc<AuthenticationEvent, AuthenticationState> {
  final AuthFirebase _authFirebase;

  final GlobalKey<NavigatorState> _navigatorKey;

  AuthenticationBloc(this._authFirebase, this._navigatorKey);

  @override
  AuthenticationState get initialState => InitialAuthenticationState();


  void gotoLoginPage() {
    print('gotoLoginPage');
    _navigatorKey.currentState.pushNamed(loginRoute);
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
