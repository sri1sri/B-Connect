import 'package:bhavani_connect/database_model/vehicle_category.dart';
import 'package:bhavani_connect/database_model/vehicle_model.dart';
import 'package:bhavani_connect/database_model/vehicle_type.dart';
import 'package:equatable/equatable.dart';
import 'package:sealed_flutter_bloc/sealed_flutter_bloc.dart';

abstract class AddVehicleEvent extends Equatable {}

class SubmitVehicle extends AddVehicleEvent {
  final VehicleCategory vehicleCateSelected;
  final String dealerName;
  final String vehicleNo;
  final String unitPerTrip;
  final VehicleType vehicleTypeSelected;

  SubmitVehicle(
      {this.vehicleCateSelected,
      this.dealerName,
      this.vehicleNo,
      this.unitPerTrip,
      this.vehicleTypeSelected});

  @override
  List<Object> get props => throw UnimplementedError();
}

class SubmitVehicleLast extends AddVehicleEvent {
  final Vehicle vehicleEntity;

  SubmitVehicleLast(this.vehicleEntity);

  @override
  // TODO: implement props
  List<Object> get props => throw UnimplementedError();
}

class InitDataEvent extends AddVehicleEvent {
  @override
  List<Object> get props => throw UnimplementedError();
}

class VehicleCategoryLoaded extends AddVehicleEvent {
  final List<VehicleCategory> vehicleCate;

  VehicleCategoryLoaded({this.vehicleCate});

  @override
  // TODO: implement props
  List<Object> get props => throw UnimplementedError();
}

class VehicleInitUpdated extends AddVehicleEvent {
  final List<VehicleCategory> vehicleCate;
  final List<VehicleType> vehicleType;

  VehicleInitUpdated({this.vehicleCate, this.vehicleType});

  VehicleInitUpdated copyWith(
          {List<VehicleCategory> vehicleCate, List<VehicleType> vehicleType}) =>
      VehicleInitUpdated(
          vehicleCate: vehicleCate ?? this.vehicleCate,
          vehicleType: vehicleType ?? this.vehicleType);

  VehicleInitUpdated.copyWith({this.vehicleCate, this.vehicleType});

  @override
  // TODO: implement props
  List<Object> get props => throw UnimplementedError();
}

class VehicleTypeUpdated extends AddVehicleEvent {
  final List<VehicleCategory> vehicleCate;

  VehicleTypeUpdated(this.vehicleCate);

  @override
  // TODO: implement props
  List<Object> get props => throw UnimplementedError();
}

class MapVehicleCategoryToState extends AddVehicleEvent {
  @override
  List<Object> get props => throw UnimplementedError();
}

class MapVehicleTypeToState extends AddVehicleEvent {
  @override
  List<Object> get props => throw UnimplementedError();
}

class AddVehicleState extends Union7Impl<Initial, Loading, LoadingInit, Success,
    SuccessInit, Failure, FailureInit> {
  static final unions = const Septet<Initial, Loading, LoadingInit, Success,
      SuccessInit, Failure, FailureInit>();

  AddVehicleState._(
      Union7<Initial, Loading, LoadingInit, Success, SuccessInit, Failure,
              FailureInit>
          union)
      : super(union);

  factory AddVehicleState.initial() =>
      AddVehicleState._(unions.first(Initial()));

  factory AddVehicleState.loading() =>
      AddVehicleState._(unions.second(Loading()));

  factory AddVehicleState.loadingInit() =>
      AddVehicleState._(unions.third(LoadingInit()));

  factory AddVehicleState.success() =>
      AddVehicleState._(unions.fourth(Success()));

  factory AddVehicleState.successInit(
          {List<VehicleCategory> vehicleCateList,
          List<VehicleType> vehicleTypeList}) =>
      AddVehicleState._(unions.fifth(SuccessInit(
          vehicleCateList: vehicleCateList, vehicleTypeList: vehicleTypeList)));

  factory AddVehicleState.failure({String error}) =>
      AddVehicleState._(unions.sixth(Failure(error: error)));

  factory AddVehicleState.failureInit({String error}) =>
      AddVehicleState._(unions.seventh(FailureInit(error: error)));
}

class Initial {}

class Loading {}

class LoadingInit {}

class Success {}

class SuccessInit {
  List<VehicleCategory> vehicleCateList;
  List<VehicleType> vehicleTypeList;

  SuccessInit({this.vehicleCateList, this.vehicleTypeList});
}

class Failure {
  String error;

  Failure({this.error});
}

class FailureInit {
  String error;

  FailureInit({this.error});
}
