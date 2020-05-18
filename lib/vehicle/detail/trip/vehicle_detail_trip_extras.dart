import 'package:bhavani_connect/database_model/vehicle_model.dart';
import 'package:bhavani_connect/database_model/vehicle_trip_record.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

abstract class VehicleDetailTripEvent extends Equatable {}

class TripRecord extends VehicleDetailTripEvent {
  final Vehicle vehicle;

  TripRecord({this.vehicle});

  @override
  // TODO: implement props
  List<Object> get props => throw UnimplementedError();
}

class LoadedTripRecord extends VehicleDetailTripEvent {
  final List<VehicleTripRecord> allTripRecord;

  final Vehicle vehicle;

  LoadedTripRecord({this.allTripRecord, this.vehicle});

  @override
  // TODO: implement props
  List<Object> get props => throw UnimplementedError();
}

class UpdatedEvent extends VehicleDetailTripEvent {
  final String documentId;

  UpdatedEvent({this.documentId});

  @override
  List<Object> get props => throw UnimplementedError();
}

class MapVehicleToState extends VehicleDetailTripEvent {
  final Vehicle vehicle;

  final List<VehicleTripRecord> tripRecordList;

  MapVehicleToState({this.vehicle, this.tripRecordList});

  @override
  // TODO: implement props
  List<Object> get props => throw UnimplementedError();
}

class StartReading extends VehicleDetailTripEvent {
  final String odoReading;

  final Vehicle vehicle;

  StartReading({this.vehicle, this.odoReading});

  @override
  // TODO: implement props
  List<Object> get props => throw UnimplementedError();
}

class StopReading extends VehicleDetailTripEvent {
  final String odoReading;

  final Vehicle vehicle;

  StopReading({this.vehicle, this.odoReading});

  @override
  // TODO: implement props
  List<Object> get props => throw UnimplementedError();
}

class InitDataEvent extends VehicleDetailTripEvent {
  final Vehicle vehicle;

  InitDataEvent({this.vehicle});

  @override
  // TODO: implement props
  List<Object> get props => throw UnimplementedError();
}

@immutable
abstract class VehicleDetailTripState {}

class Initial extends VehicleDetailTripState {}

class Loading extends VehicleDetailTripState {}

class Success extends VehicleDetailTripState {
  final Vehicle vehicle;

  final List<VehicleTripRecord> tripRecordList;

  Success({this.vehicle, this.tripRecordList});
}

class Failure extends VehicleDetailTripState {
  final String error;

  Failure({this.error});
}
