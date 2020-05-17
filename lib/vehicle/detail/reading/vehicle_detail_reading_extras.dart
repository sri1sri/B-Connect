import 'package:bhavani_connect/database_model/vehicle_model.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

abstract class VehicleDetailReadingEvent extends Equatable {}

class UpdatedEvent extends VehicleDetailReadingEvent {
  final String documentId;

  UpdatedEvent({this.documentId});

  @override
  List<Object> get props => throw UnimplementedError();
}

class MapVehicleToState extends VehicleDetailReadingEvent {
  final Vehicle vehicle;

  MapVehicleToState({this.vehicle});

  @override
  // TODO: implement props
  List<Object> get props => throw UnimplementedError();
}

class StartReading extends VehicleDetailReadingEvent {
  final String odoReading;

  final Vehicle vehicle;

  StartReading({this.vehicle, this.odoReading});

  @override
  // TODO: implement props
  List<Object> get props => throw UnimplementedError();
}

class StopReading extends VehicleDetailReadingEvent {
  final String odoReading;

  final Vehicle vehicle;

  StopReading({this.vehicle, this.odoReading});

  @override
  // TODO: implement props
  List<Object> get props => throw UnimplementedError();
}

class InitDataEvent extends VehicleDetailReadingEvent {
  final Vehicle vehicle;

  InitDataEvent({this.vehicle});

  @override
  // TODO: implement props
  List<Object> get props => throw UnimplementedError();
}

@immutable
abstract class VehicleDetailReadingState {}

class Initial extends VehicleDetailReadingState {}

class Loading extends VehicleDetailReadingState {}

class Success extends VehicleDetailReadingState {
  final Vehicle vehicle;

  Success({this.vehicle});
}

class Failure extends VehicleDetailReadingState {
  final String error;

  Failure({this.error});
}
