import 'package:bhavani_connect/database_model/employee_details_model.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:sealed_flutter_bloc/sealed_flutter_bloc.dart';

abstract class ProfileEvent {}

class ProfileLoadEmployee extends ProfileEvent {}

class MapEmployeeToState extends ProfileEvent {
  EmployeeDetails employeeDetails;

  MapEmployeeToState({this.employeeDetails});
}

class EmployeeLoaded extends ProfileEvent {
  EmployeeDetails employee;

  EmployeeLoaded({this.employee});
}

class ProfileState extends Union4Impl<Initial, Loading, Success, Failure> {
  static final unions = const Quartet<Initial, Loading, Success, Failure>();

  ProfileState._(Union4<Initial, Loading, Success, Failure> union)
      : super(union);

  factory ProfileState.initial() => ProfileState._(unions.first(Initial()));

  factory ProfileState.loading() =>
      ProfileState._(unions.second(Loading()));

  factory ProfileState.success({EmployeeDetails data}) =>
      ProfileState._(unions.third(Success(data: data)));

  factory ProfileState.failure({String error}) =>
      ProfileState._(unions.fourth(Failure(error: error)));
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