import 'dart:async';
import 'package:bhavani_connect/auth/authentication_bloc.dart';
import 'package:bhavani_connect/firebase/database.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'landing_extras.dart';

class LandingBloc extends Bloc<LandingEvent, LandingState> {
  AuthenticationBloc bloc;
  FirestoreDatabase fireStoreDatabase;

  LandingBloc({this.bloc});

  init() {
//    print('LandingBloc');
//    initFireBaseDatabase().then((value) =>
//        bloc.gotoHomePage()
//    );
  }

  @override
  LandingState get initialState => LandingState();

  @override
  Stream<LandingState> mapEventToState(LandingEvent event) async* {
    if (event is LandingInitData) {
      await initFireBaseDatabase();
      bloc.gotoHomePage();
    }
  }

  Future<void> initFireBaseDatabase() async {
    await bloc.authFirebase
        .currentUser()
        .then((value) => bloc.fireStoreDatabase = FirestoreDatabase(uid: value.uid));
  }
}
