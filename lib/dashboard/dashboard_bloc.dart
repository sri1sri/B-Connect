import 'dart:async';
import 'package:bhavani_connect/auth/authentication_bloc.dart';
import 'package:bhavani_connect/common_variables/app_functions.dart';
import 'package:bhavani_connect/database_model/employee_details_model.dart';
import 'package:bhavani_connect/landing/landing_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'dashboard_extras.dart';

class DashboardBloc extends Bloc<DashboardEvent, DashboardState> {
  AuthenticationBloc authenticationBloc;
  StreamSubscription _streamSubscriptionReadEmployee;

  DashboardBloc({this.authenticationBloc});

  @override
  DashboardState get initialState => DashboardState.initial();

  @override
  Stream<DashboardState> mapEventToState(DashboardEvent event) async* {
    if (event is LoadEmployee) {
      final employeeDetails = EmployeeDetails(deviceToken: DEVICE_TOKEN);
      _streamSubscriptionReadEmployee?.cancel();
      authenticationBloc.fireStoreDatabase.updateEmployeeDetails(
          employeeDetails, authenticationBloc.fireStoreDatabase.uid);
      _streamSubscriptionReadEmployee = authenticationBloc.fireStoreDatabase
          .readEmployeeDetails()
          .listen((event) {
        add(MapEmployeeToState(employeeDetails: event));
      });
    } else if (event is MapEmployeeToState) {
      _streamSubscriptionReadEmployee?.cancel();
      yield DashboardState.success(data: event.employeeDetails);
    }
  }
}
