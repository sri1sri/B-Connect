import 'dart:async';

import 'package:bhavani_connect/auth/bloc.dart';
import 'package:bhavani_connect/database_model/vehicle_category.dart';
import 'package:bhavani_connect/database_model/vehicle_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uuid/uuid.dart';

import 'add_vehicle_extras.dart';

class AddVehicleBloc extends Bloc<AddVehicleEvent, AddVehicleState> {
  AuthenticationBloc authenticationBloc;
  StreamSubscription _subscriptionVehicleCate;
  StreamSubscription _subscriptionVehicleType;

  AddVehicleBloc({this.authenticationBloc});

  final List<AddVehicleEvent> _events = new List<AddVehicleEvent>();

  @override
  AddVehicleState get initialState => AddVehicleState.initial();

  @override
  Stream<AddVehicleState> mapEventToState(AddVehicleEvent event) async* {
    _events.add(event); // New Line
    if (event is InitDataEvent) {
      yield* _mapLoadVehicleCateToState();
    } else if (event is VehicleCategoryLoaded) {
      yield* _mapLoadVehicleTypeToState(vehicleCate: event.vehicleCate);
    } else if (event is VehicleInitUpdated) {
      yield* _mapLoadVehicleInitToState(event);
    } else if (event is SubmitVehicle) {
      yield AddVehicleState.loading();
      Vehicle vehicleEntity = mapEventToVehicle(event);
      await authenticationBloc.fireStoreDatabase
          .addVehicle(vehicleEntity, Uuid().v1());
      yield AddVehicleState.success();
    }
  }

  dispatchPreviousState() {
    this.add(_events.removeLast());
  }

  Stream<AddVehicleState> _mapLoadVehicleCateToState() async* {
    _subscriptionVehicleCate?.cancel();
    _subscriptionVehicleCate =
        authenticationBloc.fireStoreDatabase.readAllVehicleCategory().listen(
              (vehicleCate) =>
                  add(VehicleCategoryLoaded(vehicleCate: vehicleCate)),
            );
  }

  Stream<AddVehicleState> _mapLoadVehicleTypeToState(
      {List<VehicleCategory> vehicleCate}) async* {
    _subscriptionVehicleType?.cancel();
    _subscriptionVehicleType =
        authenticationBloc.fireStoreDatabase.readAllVehicleType().listen(
              (vehicleType) => add(VehicleInitUpdated(
                  vehicleCate: vehicleCate, vehicleType: vehicleType)),
            );
  }

  Stream<AddVehicleState> _mapLoadVehicleInitToState(
      VehicleInitUpdated event) async* {
    yield AddVehicleState.successInit(
        vehicleCateList: event.vehicleCate, vehicleTypeList: event.vehicleType);
  }

  Vehicle mapEventToVehicle(SubmitVehicle event) {
    return Vehicle(
        categoryId: event.vehicleCateSelected.id,
        sellerName: event.dealerName,
        vehicleNo: event.vehicleNo,
        unitsPerTrip: event.unitPerTrip,
        vehicleTypeId: event.vehicleTypeSelected.id,
        requestedByUserId: authenticationBloc.fireStoreDatabase.uid,
        date: Timestamp.now());
  }
}
