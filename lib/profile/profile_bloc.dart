import 'dart:async';
import 'package:bhavani_connect/auth/bloc.dart';
import 'package:bhavani_connect/common_variables/app_functions.dart';
import 'package:bhavani_connect/database_model/employee_details_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'profile_extras.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  AuthenticationBloc authenticationBloc;
  StreamSubscription _streamSubscriptionReadEmployee;


  ProfileBloc({this.authenticationBloc});

  @override
  ProfileState get initialState => ProfileState.initial();

  @override
  Stream<ProfileState> mapEventToState(ProfileEvent event) async* {
    if (event is ProfileLoadEmployee) {
      final employeeDetails = EmployeeDetails(deviceToken: DEVICE_TOKEN);
      authenticationBloc.fireStoreDatabase.updateEmployeeDetails(
          employeeDetails, authenticationBloc.fireStoreDatabase.uid);
      _streamSubscriptionReadEmployee?.cancel();
      _streamSubscriptionReadEmployee = authenticationBloc.fireStoreDatabase
          .readEmployeeDetails()
          .listen((event) {
        add(MapEmployeeToState(employeeDetails: event));
      });
    } else if (event is MapEmployeeToState) {
      _streamSubscriptionReadEmployee?.cancel();
      yield ProfileState.success(data: event.employeeDetails);
    }
  }
}
