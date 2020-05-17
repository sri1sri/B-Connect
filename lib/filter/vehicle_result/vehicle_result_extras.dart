import 'package:bhavani_connect/database_model/employee_details_model.dart';
import 'package:bhavani_connect/database_model/vehicle_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:sealed_flutter_bloc/sealed_flutter_bloc.dart';

abstract class VehicleResultEvent extends Equatable {}

class InitDataVehicleResultEvent extends VehicleResultEvent {
  final Timestamp dateTo;
  final String siteName;
  final Timestamp dateFrom;
  final String sellerName;

  InitDataVehicleResultEvent(
      {this.sellerName, this.siteName, this.dateFrom, this.dateTo});

  @override
  List<Object> get props => throw UnimplementedError();
}

class MapVehicleToState extends VehicleResultEvent {
  final List<Vehicle> vehicleList;

  final String sellerName;
  final String siteName;
  final Timestamp dateFrom;
  final Timestamp dateTo;

  MapVehicleToState(
      {this.vehicleList,
      this.sellerName,
      this.siteName,
      this.dateFrom,
      this.dateTo});

  @override
  List<Object> get props => throw UnimplementedError();
}

class VehicleResultState
    extends Union4Impl<Initial, Loading, Success, Failure> {
  static final unions = const Quartet<Initial, Loading, Success, Failure>();

  VehicleResultState._(Union4<Initial, Loading, Success, Failure> union)
      : super(union);

  factory VehicleResultState.initial() =>
      VehicleResultState._(unions.first(Initial()));

  factory VehicleResultState.loading() =>
      VehicleResultState._(unions.second(Loading()));

  factory VehicleResultState.success(
          {List<Vehicle> vehicleList,
          String sellerName,
          String siteName,
          Timestamp dateFrom,
          Timestamp dateTo}) =>
      VehicleResultState._(unions.third(Success(
          data: vehicleList,
          sellerName: sellerName,
          siteName: siteName,
          dateFrom: dateFrom,
          dateTo: dateTo)));

  factory VehicleResultState.failure({String error}) =>
      VehicleResultState._(unions.fourth(Failure(error: error)));
}

class Initial {}

class Loading {}

class Success {
  final List<Vehicle> data;
  final String sellerName;
  final String siteName;
  final Timestamp dateFrom;
  final Timestamp dateTo;

  Success(
      {this.data, this.sellerName, this.siteName, this.dateFrom, this.dateTo});
}

class Failure {
  String error;

  Failure({this.error});
}

class FilterVehicleResultArguments {
  Timestamp dateTo;
  String siteName;
  Timestamp dateFrom;
  String sellerName;

  FilterVehicleResultArguments(
      {this.sellerName, this.siteName, this.dateFrom, this.dateTo});
}
