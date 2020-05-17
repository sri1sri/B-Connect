import 'package:bhavani_connect/database_model/employee_details_model.dart';
import 'package:bhavani_connect/database_model/vehicle_model.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:sealed_flutter_bloc/sealed_flutter_bloc.dart';

abstract class FilterVehicleEvent extends Equatable {}
 class MapVehicleToSeller extends FilterVehicleEvent {
  final List<Vehicle> vehicleList;

  MapVehicleToSeller({this.vehicleList});

  @override
  // TODO: implement props
  List<Object> get props => throw UnimplementedError();
}

class InitDataFilterVehicleEvent extends FilterVehicleEvent {
  @override
  List<Object> get props => throw UnimplementedError();
}

class FilterVehicleState extends Union4Impl<Initial, Loading, Success, Failure> {
  static final unions = const Quartet<Initial, Loading, Success, Failure>();

  FilterVehicleState._(Union4<Initial, Loading, Success, Failure> union)
      : super(union);

  factory FilterVehicleState.initial() => FilterVehicleState._(unions.first(Initial()));

  factory FilterVehicleState.loading() =>
      FilterVehicleState._(unions.second(Loading()));

  factory FilterVehicleState.success( {List<Vehicle> vehicleList}) =>
      FilterVehicleState._(unions.third(Success(data: vehicleList)));

  factory FilterVehicleState.failure({String error}) =>
      FilterVehicleState._(unions.fourth(Failure(error: error)));
}

class Initial {}

class Loading {}

class Success {
  final List<Vehicle> data;

  Success({this.data});
}

class Failure {
  String error;

  Failure({this.error});
}
