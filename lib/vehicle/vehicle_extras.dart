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

  MapVehicleToState({this.vehicleList});

  @override
  List<Object> get props => throw UnimplementedError();
}

class VehicleState extends Union4Impl<Initial, Loading, Success, Failure> {
  static final unions = const Quartet<Initial, Loading, Success, Failure>();

  VehicleState._(Union4<Initial, Loading, Success, Failure> union)
      : super(union);

  factory VehicleState.initial() => VehicleState._(unions.first(Initial()));

  factory VehicleState.loading() => VehicleState._(unions.second(Loading()));

  factory VehicleState.success({List<Vehicle> vehicleList}) =>
      VehicleState._(unions.third(Success(vehicleList: vehicleList)));

  factory VehicleState.failure({String error}) =>
      VehicleState._(unions.fourth(Failure(error: error)));
}

class Initial {}

class Loading {}

class Success {
  List<Vehicle> vehicleList;

  Success({this.vehicleList});
}

class Failure {
  String error;

  Failure({this.error});
}
