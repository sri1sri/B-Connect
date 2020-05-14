import 'package:bhavani_connect/database_model/employee_details_model.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:sealed_flutter_bloc/sealed_flutter_bloc.dart';

const dashBoardFeatures = [
//    "Approvals",
//    "Add stock",
//    "Store",
//    "Inventory",
//    "Attendance",
//    "Employees",
  "Vehicle Entries",
  "Stock Register"
];
const List<String> dashboardImage = [
//    "images/Approval.jpg",
//    "images/Addstock.jpg",
//    "images/store.jpg",
//    "images/inventory.png",
//    "images/Attendance.jpg",
//    "images/ManageEmployees.jpg",
  "images/jcb.png",
  "images/invoice.png"
];

abstract class DashboardEvent {}

class LoadEmployee extends DashboardEvent {}

class MapEmployeeToState extends DashboardEvent {
  EmployeeDetails employeeDetails;

  MapEmployeeToState({this.employeeDetails});
}

class EmployeeLoaded extends DashboardEvent {
  EmployeeDetails employee;

  EmployeeLoaded({this.employee});
}

class DashboardState extends Union4Impl<Initial, Loading, Success, Failure> {
  static final unions = const Quartet<Initial, Loading, Success, Failure>();

  DashboardState._(Union4<Initial, Loading, Success, Failure> union)
      : super(union);

  factory DashboardState.initial() => DashboardState._(unions.first(Initial()));

  factory DashboardState.loading() =>
      DashboardState._(unions.second(Loading()));

  factory DashboardState.success({EmployeeDetails data}) =>
      DashboardState._(unions.third(Success(data: data)));

  factory DashboardState.failure({String error}) =>
      DashboardState._(unions.fourth(Failure(error: error)));
}

class Initial {}

class Loading {}

class Success {
  final EmployeeDetails data;

  Success({this.data});
}

class Failure {
  String error;

  Failure({this.error});
}
