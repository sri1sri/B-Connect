import 'package:bhavani_connect/database_model/employee_details_model.dart';
import 'package:bhavani_connect/database_model/vehicle_model.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:sealed_flutter_bloc/sealed_flutter_bloc.dart';

abstract class VehicleEvent extends Equatable {}

class LoadDataEvent extends VehicleEvent {
  @override
  List<Object> get props => throw UnimplementedError();
}

class MapVehicleToState extends VehicleEvent {
  final List<Vehicle> vehicleList;

  final EmployeeDetails employee;

  MapVehicleToState({this.vehicleList, this.employee});

  @override
  List<Object> get props => throw UnimplementedError();
}

class VehicleState extends Union4Impl<Initial, Loading, Success, Failure> {
  static final unions = const Quartet<Initial, Loading, Success, Failure>();

  VehicleState._(Union4<Initial, Loading, Success, Failure> union)
      : super(union);

  factory VehicleState.initial() => VehicleState._(unions.first(Initial()));

  factory VehicleState.loading() => VehicleState._(unions.second(Loading()));

  factory VehicleState.success({List<Vehicle> vehicleList, EmployeeDetails employee}) =>
      VehicleState._(
          unions.third(Success(vehicleList: vehicleList, employee: employee)));

  factory VehicleState.failure({String error}) =>
      VehicleState._(unions.fourth(Failure(error: error)));
}

class Initial {}

class Loading {}

class Success {
  List<Vehicle> vehicleList;
  EmployeeDetails employee;

  Success({this.vehicleList, this.employee});
}

class Failure {
  String error;

  Failure({this.error});
}

class VehicleDetailArguments {
  Vehicle vehicle;

  VehicleDetailArguments({this.vehicle});
}

String parseApproval(String approvedByUserId, String approvedByUserName,
    String approvedByUserRole) {
  var approvalUserName = approvedByUserName ?? '-';
  var approvalUserRole =
      (approvedByUserRole == null) ? '' : ' ($approvedByUserRole)';
  return approvalUserName + approvalUserRole;
}

String parseRequest(String requestedByUserId, String requestedByUserName,
    String requestedByUserRole) {
  var requestUserName = requestedByUserName ?? '-';
  var requestUserRole =
      (requestedByUserRole == null) ? '' : ' ($requestedByUserRole)';
  return requestUserName + requestUserRole;
}
